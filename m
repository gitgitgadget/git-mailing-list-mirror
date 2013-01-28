From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Mon, 28 Jan 2013 11:44:34 +0100
Message-ID: <51065692.9000708@alum.mit.edu>
References: <cover.1358686905.git.john@keeping.me.uk> <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk> <20130126175158.GK7498@serenity.lan> <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu> <20130127141329.GN7498@serenity.lan> <20130127145056.GP7498@serenity.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010306050203080406070902"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:45:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzmD0-0003BN-54
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 11:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750Ab3A1Kol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 05:44:41 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:50461 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753029Ab3A1Koj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 05:44:39 -0500
X-AuditID: 1207440d-b7f306d0000008b7-bd-51065696c7ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 09.AC.02231.69656015; Mon, 28 Jan 2013 05:44:38 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0SAiY7x003916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 28 Jan 2013 05:44:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130127145056.GP7498@serenity.lan>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsUixO6iqDstjC3QYO9rTYuuK91MFg29V5gt
	bpzfxWox/8ZZRgcWj52z7rJ7nH30gNnj4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4Mz5+ecFe
	0KJX8eK6WwPjbZUuRk4OCQETiasfupkgbDGJC/fWs3UxcnEICVxmlFj2vJ8ZwjnOJPFgwS0W
	kCpeAW2J3u9vWbsYOThYBFQlDl5KBwmzCehKLOppBhskKhAm0fv6HCNEuaDEyZlPwFpFgMqn
	fbrBDmIzC+RKfHlzig3EFhZwlTjW/gCsV0hgN5PEoVmcIOM5BQwlLvxmhCgPkJj3pZNlAiP/
	LCRTZyFJQdg6Eu/6HjBD2PISzVtnQ9n6Evuvf2GHiW9/Owcqbi5xr/0X6wJG9lWMcok5pbm6
	uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYITHBu4Px/zqZQ4wCHIxKPLxBmSyBQqyJZcWV
	uYcYJTmYlER5e0PZAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8MacYQ0U4k1JrKxKLcqHSUlz
	sCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8C4BGSpYlJqeWpGWmVOCkGbi4AQZziUlUpya
	l5JalFhakhEPivb4YmC8g6R4gPYuBGnnLS5IzAWKQrSeYtTl2P67/TmjEEtefl6qlDhvBUiR
	AEhRRmke3ApYAnzFKA70sTBvJkgVDzB5wk16BbSECWhJdi8zyJKSRISUVANje8THl/8WcBt6
	B+acSNjyKWIGk8mGD5xfnz36feXvQZ6NUw4e2mPyL6DendljRoXQ6oqZU178bJQP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214827>

This is a multi-part message in MIME format.
--------------010306050203080406070902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 01/27/2013 03:50 PM, John Keeping wrote:
> When this change was originally made (0846b0c - git-remote-testpy: hash
> bytes explicitly , I didn't realised that the "hex" encoding we chose is
> a "bytes to bytes" encoding so it just fails with an error on Python 3
> in the same way as the original code.
> 
> It is not possible to provide a single code path that works on Python 2
> and Python 3 since Python 2.x will attempt to decode the string before
> encoding it, which fails for strings that are not valid in the default
> encoding.  Python 3.1 introduced the "surrogateescape" error handler
> which handles this correctly and permits a bytes -> unicode -> bytes
> round-trip to be lossless.
> 
> At this point Python 3.0 is unsupported so we don't go out of our way to
> try to support it.
> 
> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> On Sun, Jan 27, 2013 at 02:13:29PM +0000, John Keeping wrote:
>> On Sun, Jan 27, 2013 at 05:44:37AM +0100, Michael Haggerty wrote:
>>> So to handle all of the cases across Python versions as closely as
>>> possible to the old 2.x code, it might be necessary to make the code
>>> explicitly depend on the Python version number, like:
>>>
>>>     hasher = _digest()
>>>     if sys.hexversion < 0x03000000:
>>>         pathbytes = repo.path
>>>     elif sys.hexversion < 0x03010000:
>>>         # If support for Python 3.0.x is desired (note: result can
>>>         # be different in this case than under 2.x or 3.1+):
>>>         pathbytes = repo.path.encode(sys.getfilesystemencoding(),
>>> 'backslashreplace')
>>>     else
>>>         pathbytes = repo.path.encode(sys.getfilesystemencoding(),
>>> 'surrogateescape')
>>>     hasher.update(pathbytes)
>>>     repo.hash = hasher.hexdigest()
> 
> How about this?
> 
>  git-remote-testpy.py | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
> index c7a04ec..16b0c52 100644
> --- a/git-remote-testpy.py
> +++ b/git-remote-testpy.py
> @@ -36,6 +36,22 @@ if sys.hexversion < 0x02000000:
>      sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
>      sys.exit(1)
>  
> +
> +def _encode_filepath(path):
> +    """Encodes a Unicode file path to a byte string.
> +
> +    On Python 2 this is a no-op; on Python 3 we encode the string as
> +    suggested by [1] which allows an exact round-trip from the command line
> +    to the filesystem.
> +
> +    [1] http://docs.python.org/3/c-api/unicode.html#file-system-encoding
> +
> +    """
> +    if sys.hexversion < 0x03000000:
> +        return path
> +    return path.encode('utf-8', 'surrogateescape')
> +
> +
>  def get_repo(alias, url):
>      """Returns a git repository object initialized for usage.
>      """
> @@ -45,7 +61,7 @@ def get_repo(alias, url):
>      repo.get_head()
>  
>      hasher = _digest()
> -    hasher.update(repo.path.encode('hex'))
> +    hasher.update(_encode_filepath(repo.path))
>      repo.hash = hasher.hexdigest()
>  
>      repo.get_base_path = lambda base: os.path.join(
> 

NAK.  It is still not right.  If the locale is not utf-8 based, then it
is incorrect to re-encode the string using utf-8.  I think you really
have to use sys.getfilesystemencoding() as I suggested.

The attached program demonstrates the problem: the output of re-encoding
using UTF-8 depends on the locale, whereas that of re-encoding using the
filesystemencoding is independent of locale (as we want).  The output,
using Python 3.2.3:

# This is 0xb6 0xc3:
$ ARG="ö"
$ LANG='C' /usr/bin/python3 chaos3.py "$ARG"
LANG = 'C'
fse = 'ascii'
sys.argv[1] = u"U+DCC3 U+DCB6"
re-encoded using UTF-8: b"C3 B6"
re-encoded using fse: b"C3 B6"

$ LANG='C.UTF-8' /usr/bin/python3 chaos3.py "$ARG"
LANG = 'C.UTF-8'
fse = 'utf-8'
sys.argv[1] = u"U+00F6"
re-encoded using UTF-8: b"C3 B6"
re-encoded using fse: b"C3 B6"

$ LANG='en_US.iso88591' /usr/bin/python3 chaos3.py "$ARG"
LANG = 'en_US.iso88591'
fse = 'iso8859-1'
sys.argv[1] = u"U+00C3 U+00B6"
re-encoded using UTF-8: b"C3 83 C2 B6"
re-encoded using fse: b"C3 B6"

Even though the Unicode intermediate representation is different for
UTF-8 and ASCII, re-encoding using the correct encoding gives back the
original bytes (which is what we want).  But when using the ios8859-1
locale, the original bytes look like a valid latin1 string so they are
not surrogated going in, giving the incorrect Unicode string u"U+00C3
U+00B6".  When this is re-encoded using UTF-8, the code points U+00C3
and U+00B6 are each encoded as two bytes.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------010306050203080406070902
Content-Type: text/x-python;
 name="chaos3.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="chaos3.py"

#! /usr/bin/python3

import sys
import os


def explicit(s):
    """Convert a string or bytestring into an unambiguous human-readable string."""

    if isinstance(s, str):
        return 'u"%s"' % (' '.join('U+%04X' % (ord(c),) for c in s))
    else:
        return 'b"%s"' % (' '.join('%02X' % (c,) for c in s))


fse = sys.getfilesystemencoding()

print('LANG = %r' % (os.getenv('LANG'),))
print('fse = %r' % (fse,))
print('sys.argv[1] = %s' % explicit(sys.argv[1]))
print('re-encoded using UTF-8: %s' % explicit(sys.argv[1].encode('utf-8', 'surrogateescape')))
print('re-encoded using fse: %s' % explicit(sys.argv[1].encode(fse, 'surrogateescape')))
print()



--------------010306050203080406070902--
