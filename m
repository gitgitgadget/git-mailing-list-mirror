From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: FYI: Reply from HP-UX
Date: Thu, 17 Jan 2008 18:55:14 +0100
Message-ID: <20080117185514.621525a6@pc09.procura.nl>
References: <20080117141143.38a88c7a@pc09.procura.nl>
	<alpine.LSU.1.00.0801171655570.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYyB-0001J5-Pe
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYAQRzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbYAQRzf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:55:35 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4557 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYAQRze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:55:34 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m0HHtEom023397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 18:55:14 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <alpine.LSU.1.00.0801171655570.5731@racer.site>
X-Mailer: Claws Mail 3.2.0cvs27 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70882>

On Thu, 17 Jan 2008 16:58:36 +0000 (GMT), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Thu, 17 Jan 2008, H.Merijn Brand wrote:
> 
> > > I got git running on HP-UX 11.00, which still is our base for our Version
> > > Control System (VCS)s. Most of the changes I made were incorporated into
> > > the git mainline.  
> > 
> > I've had a look at the git 1.5.3.8 source code and there are several
> > HP-UX issues with it:
> > 
> > * Use of gcc-specific features. Doesn't seem to want to compile nicely
> >   with HP's ANSI C compiler.
> 
> If that would be a bit more specific, we might very well be able to fix 
> it.  After all, AFAIK we do support some non-gcc compilers.

Richard?

> > * Failure of the configure/make to handle the lack of unsetenv() in
> >   pre-11.31 HP-UX releases. Bizarrely, it does handle the lack of setenv()
> >   and also has a compat/unsetenv.c for use by non-unsetenv()-capable OS'es,
> >   but then configure and config.mak.in completely fail to use a NO_UNSETENV
> >   variable like they should!
> 
> Didn't you provide them with a patch to Makefile making a run of 
> ./configure unnecessary?

No, I didn't provide him (yet) with any additional information.

> > * Use of "-include config.mak.autogen" in the top-level Makefile doesn't
> >   seem to actually include that file. I had to remove the leading "-" to
> >   include it. Also had to stop "gmake clean" from deleting config.mak.autogen
> >   otherwise a second "gmake clean" would fail :-(
> 
> That is strange.  The "-" in front means that the exit status of this 
> command is ignored.  So it is no surprise that it fails when you remove 
> the "-".  OTOH it is quite a surprise that it does not work when leaving 
> it alone...  What's the output?
> 
> > * Have to force use of /usr/local/bin/perl, otherwise it picks up /usr/bin/perl
> >   which the build system doesn't like.
> 
> This should be handled in your patch to Makefile IMHO.

You mean this: ?
--8<---
--- Makefile.orig       2007-12-17 07:03:21 +0100
+++ Makefile    2007-12-17 18:04:37 +0100
@@ -401,6 +401,19 @@ EXTLIBS =
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...

+ifeq ($(uname_S),HP-UX)
+       # HP-UX
+       BASIC_LDFLAGS  += -L/usr/local/ssl/lib -L/usr/local/lib
+#      EXTLIBS        += -lc_r -lgcc
+       NO_HSTRERROR    = YesPlease
+       NO_ICONV        = YesPlease
+       NO_INET_NTOP    = YesPlease
+       NO_INET_PTON    = YesPlease
+       NO_UNSETENV     = YesPlease
+       NO_STRTOULL     = YesPlease
+       NO_STRTOUMAX    = YesPlease
+       NO_PREAD        = YesPlease
+endif
 ifeq ($(uname_S),Linux)
        NO_STRLCPY = YesPlease
 endif
-->8---

Note that this was on HP-UX 11.00/32. A 64bit env on 11.23/64 IPF will be
different.

I had no problem with my perl, as I specifically told that on the configure
line:

$ ./configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl

> > * "gmake check" requires porting "sparse" at
> >   http://www.kernel.org/pub/software/devel/sparse/ which could be "fun".
> 
> You don't need to make "check".  You need to make "test".


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
