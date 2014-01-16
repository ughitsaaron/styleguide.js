source_css = document.querySelector('textarea.source_css').textContent
source_js = document.querySelector('textarea.source_js').textContent

Guide = (guide) ->
  preview = guide.querySelector('.preview')
  source = guide.querySelector('.source')
  iframe = guide.querySelector('.preview iframe')

  return false if not source

  guide_source = source.textContent

  # write guide html
  d = iframe.contentWindow.document
  d.open()
  d.write("<!DOCTYPE html><html><head></head><body style='padding: 20px'>#{guide_source}</body></html>")

  # append stylesheet
  stylesheet = d.createElement('style')
  stylesheet.innerHTML = source_css
  d.querySelector('head').appendChild(stylesheet)
  
  # append js
  script = d.createElement('script')
  script.innerHTML = source_js
  d.querySelector('head').appendChild(script)

  d.close()


  # toggle link
  guide.querySelector("a.toggle").addEventListener "click", (ev)->
    preview.classList.toggle('hidden')
    source.classList.toggle('hidden')
    ev.preventDefault()


for guide in document.querySelectorAll('.guide')
  Guide(guide)


all_frames = document.querySelectorAll('.preview iframe')
scaleIframes = ->
  for frame in all_frames
    frame.height = frame.contentWindow.document.querySelector('html').scrollHeight

scaleIframes()
setInterval(scaleIframes, 500)