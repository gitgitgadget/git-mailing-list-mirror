From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 09:38:19 +0100
Message-ID: <20071218093819.0b1caf16@pc09.procura.nl>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
	<m3tzmgpzlu.fsf@roke.D-201>
	<20071218083843.42d7a15e@pc09.procura.nl>
	<200712180920.39633.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 09:38:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4XyV-0002Tf-45
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 09:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbXLRIi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 03:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbXLRIi1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 03:38:27 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:4389 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbXLRIi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 03:38:26 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBI8cKnC080366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 09:38:21 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <200712180920.39633.jnareb@gmail.com>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68709>

On Tue, 18 Dec 2007 09:20:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:

> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> > On Mon, 17 Dec 2007 17:21:08 -0800 (PST), Jakub Narebski wrote:
> > 
> >> Andy Dougherty <doughera@lafayette.edu> writes:
> >> 
> >>> [...].  Perhaps configure
> >>> should just go looking for a suitable install program instead of
> >>> assuming everyone has one.
> >> 
> >> First, configure is, and (I think) consensus is that it should remain
> >> optional.  This means that Makefile "guess" section should have good
> >> defaults for your operating system.
> > 
> > And what if you OS *does* have an install, but one that is completely
> > useless^Wdifferent from the GNU install? Like the utterly useless
> > install on HP-UX.
> 
> Then "guess" section should have INSTALL=ginstall, or something.
> Or just install with
> 
>   INSTALL=/opt/bin/ginstall make install

Chances are close to zero that HP-UX systems have installed any working
or compliant version of install

> or something like that.
> 
> >> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
> >> there is BSD-compatible `install' program (as 'install-sh' or
> >> 'install.sh') in the sources.  Adding such script is (I think) not a
> >> problem;
> > 
> > Yeah!
> > 
> >> finding minimal portable[*1*] script is.  So if you know one...
> >> 
> >> Footnotes:
> >> ----------
> >> [*1*] By "portable" I mean here 'git portable', i.e. requiring only
> >> those shell constructs/features that git require, not necessary
> >> insanelt portable the way ./configure script is.
> > 
> > Something like this? (gui part still missing). This is what I now
> > use
> > 
> > --8<--- make-install
> 
> Errr... please read more carefully. There is need for BSD-compatibile
> `install` program as 'install-sh', not 'make-install' script. The idea
> is to use system-provided 'install' if it exists and is compatibile,

There lies the problem. HP-UX does have an 'install', but it is not
compatible, and chances are (very) small that people have installed
the GNU or any other BSD compliant install.

> because it should be faster than script version, and fallback to 
> provided install-sh only if system install is not found.

The problem again. It *does* find install, but it turns out to be
unusable.

> install-sh has to understand '-d' and '-m <mode>' switches for git 
> install purposes, and probably implement all three (src dest, src dir, 
> dir) formats.

BTW the same, but worse exists for the 'patch' program. On HP-UX there
is a program called 'patch' which is used for system upgrades, but it
has nothing to do with the patch util the rest of the world so happily
uses.

So far that is used in a few places in the test suite, but I heared it
would not be too hard to eliminate the use of the hard-coded patch util

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
