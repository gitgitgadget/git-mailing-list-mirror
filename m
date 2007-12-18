From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 12:11:15 +0100
Message-ID: <20071218121115.1c893dc4@pc09.procura.nl>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
	<200712180920.39633.jnareb@gmail.com>
	<20071218093819.0b1caf16@pc09.procura.nl>
	<200712181014.38986.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 12:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4aMb-0005Wc-Dj
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 12:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbXLRLL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 06:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXLRLL3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 06:11:29 -0500
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:1575 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbXLRLL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 06:11:28 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBIBBFMK077818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 12:11:15 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <200712181014.38986.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68729>

On Tue, 18 Dec 2007 10:14:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:

> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> > On Tue, 18 Dec 2007 09:20:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
> >> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> >>> On Mon, 17 Dec 2007 17:21:08 -0800 (PST), Jakub Narebski wrote:
> >>>>
> >>>> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
> >>>> there is BSD-compatible `install' program (as 'install-sh' or
> >>>> 'install.sh') in the sources.  Adding such script is (I think) not a
> >>>> problem; finding minimal portable[*1*] script is.  
> >>>> So if you know one... 
> >> 
> >> [...]. There is need for BSD-compatibile
> >> `install` program as 'install-sh', not 'make-install' script. The idea
> >> is to use system-provided 'install' if it exists and is compatibile,
> > 
> > There lies the problem. HP-UX does have an 'install', but it is not
> > compatible, and chances are (very) small that people have installed
> > the GNU or any other BSD compliant install.
> > 
> >> because it should be faster than script version, and fallback to 
> >> provided install-sh only if system install is not found.
> > 
> > The problem again. It *does* find install, but it turns out to be
> > unusable.
> 
> Could you check if ./configure correctly uses install-sh in your case?
> Copy install-sh from for example autotools[*1*] (e.g. libtool has one)
> to the git sources, uncomment line with AC_PROG_INSTALL in configure.ac,
> generate configure script using "make configure" and check what
> ./configure chooses.
> 
> In my case it is:
> 
>   $ cp /usr/share/libtool/install-sh .
>   $ make configure
>   GIT_VERSION = 1.5.4.rc0.56.g6fbe-dirty
>       GEN configure
>   $ ./configure
>   configure: CHECKS for programs
>   [...]
>   checking for a BSD-compatible install... /usr/bin/install -c
> 
> What is ./configure output in your case?

/pro/3gl/LINUX/git-2007-12-17 112 > rm config.{log,status}
/pro/3gl/LINUX/git-2007-12-17 113 > configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl >& config-log
/pro/3gl/LINUX/git-2007-12-17 114 > grep -w install !$
grep -w install config-log
Exit 1
/pro/3gl/LINUX/git-2007-12-17 115 >

The system could have used either one of these:

/pro/3gl/LINUX/git-2007-12-17 116 > ll /pro/local/share/automa*/install-sh
258090 -rwxr-xr-x 1 merijn softwr 9212 Sep  2  2004 /pro/local/share/automake-1.9/install-sh
 77938 -rwxr-xr-x 1 merijn softwr 5598 Oct  4  2001 /pro/local/share/automake/install-sh

/pro/3gl/LINUX/git-2007-12-17 119 > cp /pro/3gl/GNU/gcc/r3/gcc-4.2.2/install-sh install-sh
/pro/3gl/LINUX/git-2007-12-17 120 > rm config.{log,status}
/pro/3gl/LINUX/git-2007-12-17 121 > configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl > & config-log
/pro/3gl/LINUX/git-2007-12-17 122 > grep -w install config-log
Exit 1
/pro/3gl/LINUX/git-2007-12-17 123 > ll install-sh
121737 -rwxrwxr-x 1 merijn softwr 9233 Dec 18 12:06 install-sh
/pro/3gl/LINUX/git-2007-12-17 124 >

-- uncommented the AC_PROG_INSTALL line ...

a5:/pro/3gl/LINUX/git-2007-12-17 125 > rm config.{log,status}
a5:/pro/3gl/LINUX/git-2007-12-17 126 > configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl > & config-log
a5:/pro/3gl/LINUX/git-2007-12-17 127 > grep -w install config-log
Exit 1
a5:/pro/3gl/LINUX/git-2007-12-17 128 > grep -w install config.log config.status
Exit 1
a5:/pro/3gl/LINUX/git-2007-12-17 129 >

OK, rebuild configure ...

a5:/pro/3gl/LINUX/git-2007-12-17 129 > make configure
    GEN configure
a5:/pro/3gl/LINUX/git-2007-12-17 130 > rm config.{log,status}
a5:/pro/3gl/LINUX/git-2007-12-17 131 > configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl > & config-log
a5:/pro/3gl/LINUX/git-2007-12-17 132 > grep -w install config-log config.log config.status
config-log:checking for a BSD-compatible install... /opt/imake/bin/install -c
config.log:configure:2218: checking for a BSD-compatible install
config.log:configure:2273: result: /opt/imake/bin/install -c
config.log:ac_cv_path_install='/opt/imake/bin/install -c'
config.status:INSTALL="/opt/imake/bin/install -c"
a5:/pro/3gl/LINUX/git-2007-12-17 133 >

> Footnotes:
> ----------
> [*1*] Or for example http://svn.scheffers.net/zlib/tclconfig/install-sh
> which is smaller (2189 bytes vs. 9233 autotools one, or 10970 from
> kapptemplate (kdesdk 3.5.3)).


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
