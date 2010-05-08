From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Sat, 8 May 2010 07:36:43 -0400
Message-ID: <AANLkTimtBLWaTnCx5wcivLpVfbF-hREsZnJCayCWcJV7@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
	 <q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com>
	 <alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org>
	 <i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com>
	 <alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org>
	 <i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com>
	 <alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org>
	 <g2h600158c31005071949ve3397f18j3c38017be32dd591@mail.gmail.com>
	 <AANLkTikbIHfX5pUOn2Yk44IWzqTFDpyapC1V-C-br9jF@mail.gmail.com>
	 <k2q32541b131005072045jc1192392ke234b7b543aaca33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, kusmabite@googlemail.com,
	prohaska@zib.de, Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 13:36:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAiKy-0001Wd-2m
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 13:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab0EHLgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 07:36:46 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:65137 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0EHLgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 07:36:45 -0400
Received: by wwa36 with SMTP id 36so551719wwa.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BjgPbRXHHrlAlZ0wndgCLdgfUF8rsYIuPZF0kAzL9RA=;
        b=gdrhUXd+yXhY3IEQx6Ikyt3QgQgUbaRFKiisyxB6pz2HIeJTxIhs/635bfiYhzFM/U
         HUoj2elOnSV7nTJigrd0s7l2Nw1DGwu5J2Y/057IjBfZxPgTndv+nWTK7KrlBUaDFARf
         a9SRFR3V3vlEo5Tj1gtBPmqy6aNZ0TxhSQSLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QJnnMxuuynodWPwC4KZB3FKBs/CQDYnCqMyffPVsId4NUbuGW/RI6R1HqBeaXZbxPU
         lKzjMrytfb5bg2+QVro3yOm8RYRaIFQn633A7xCHNzppOUAI0qoHUYsEvPyGsK0J0YXb
         qjbKdPXE2wgCgQyf+rETfG9jLjOy0nBjzFBJg=
Received: by 10.216.160.208 with SMTP id u58mr640683wek.141.1273318603786; 
	Sat, 08 May 2010 04:36:43 -0700 (PDT)
Received: by 10.216.25.18 with HTTP; Sat, 8 May 2010 04:36:43 -0700 (PDT)
In-Reply-To: <k2q32541b131005072045jc1192392ke234b7b543aaca33@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146658>

[...]

>> character.
>
> Erm, this seems to be a counterexample to your point. =C2=A0It says v=
ery
> clearly that the files can use either LF or CRLF line endings, and
> will be parsed correctly either way, or your parser is broken. =C2=A0=
So
> pretty much any CRLF conversion rule (or none at all) will work with
> such files.

Perhaps I was not clear, or you did not understand my point.

Read "...by translating... to #xA", XSLT output to a file therefore
MUST be LF by definition for it to be canonical form. This is an
example of a TEXT file that MUST by definition of the spec be LF based
on all platforms. Looking at the "auto" code that exists in Git, it
does not appear to support this very obvious standard, whereby for
this "file-type" it should always be checked out of source control
with LF regardless of how it came in. This is equivalent to the Git
"input" setting I believe (?), but on a file-type basis. Yes, Git
apparently does not have the notion of file-types, does it (e.g. *.xml
maps to text)?

The point I am really trying to make clear is that there are multiple
dimensions to this problem, and not making that succinct will result
in a botched attempt. We need to carefully distinguish file-types from
other switches that control whether or not to perform automatic
conversions. The two dimensions are eol-style and file-type.

THE SWITCHES

So for the switches, here is what would be meaningful to me, short, swe=
et:

core.autocrlf  :: true false
core.eolstyle  :: local share lf crlf

If autocrlf is false, then what comes out is exactly what goes in.

EOL-STYLE

The eolstyle property only applies to text files (discussed later):

- "local" means normalize "text" files to LF when read in, and convert
to the platform preferred setting when materializing workspaces.
- "share" means accept anything, but when writing files to a workspace
normalize to LF (XML, XSLT, some scripting languages ...)
- "lf" means always to accept anything though and convert to LF, output=
 LF
- "crlf" means to accept anything and convert to CRLF on output

=46ILE-TYPES

Linus alluded above file-types, and being explicit about them. That's
great, I agree. Let me provide examples:

By extension:
    http://www.perforce.com/perforce/doc.current/manuals/cmdref/o.ftype=
s.html

By pathnames or extensions:
    http://www.perforce.com/perforce/doc.current/manuals/cmdref/typemap=
=2Ehtml

Don't beat me up for referencing other systems, please. But as people
move to Git from other systems there will be some level of
expectation, so understanding those perspectives and expectations so
you are prepared to provide a meaningful answer would help.

AUTO/TEXT-DETECTION

So the above explicit definitions gets you most of the way, but what
about "auto"? This is a question at the heart of convert.c, the
gather_stats function that classifies among other things whether or
not an input is text or binary.

While gather_stats is a good start, it naively is US-centric; it most
assuredly does not address UTF-8 and ISO-8859-1, both of which are
VERY easy to identify, but are not presently handled by this
algorithm. I wrote a simple stat gatherer for the MATLAB kernel years
ago that classified the character-set of arbitrary input text to one
of about a half-dozen common character-sets, so what about adding in a
lightweight checker for at least UTF-8 and ISO-8859-1? I could provide
such a thing back to this community if people wish.

To have a little more in the gather_stats code to handle a couple more
cases would go a long way and would be easy to add, and does not
necessarily depend up file-type support. It would simply broaden what
it means to be a text file.
