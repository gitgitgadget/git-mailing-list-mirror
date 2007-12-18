From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 15:27:39 +0100
Message-ID: <20071218152739.060af760@pc09.procura.nl>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
	<200712181333.01051.jnareb@gmail.com>
	<20071218143246.2437bfaf@pc09.procura.nl>
	<200712181503.10614.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 15:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4dSW-0003xE-FO
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 15:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbXLRO3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 09:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbXLRO3t
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 09:29:49 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:4527 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbXLRO3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 09:29:47 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBIERdV1087806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 15:27:40 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <200712181503.10614.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68754>

On Tue, 18 Dec 2007 15:03:09 +0100, Jakub Narebski <jnareb@gmail.com> wrote:

> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> > On Tue, 18 Dec 2007 13:32:59 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
> >> H.Merijn Brand wrote:
> >>> On Tue, 18 Dec 2007 10:14:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
> >>>> 
> >>>> What is ./configure output in your case?
> >>  
> >>> /pro/3gl/LINUX/git-2007-12-17 119> cp /pro/3gl/GNU/gcc/r3/gcc-4.2.2/install-sh install-sh
> >> 
> >>> -- uncommented the AC_PROG_INSTALL line ...
> >> 
> >>> OK, rebuild configure ...
> >>> 
> >>> a5:/pro/3gl/LINUX/git-2007-12-17 129> make configure
> >>>     GEN configure
> >>> a5:/pro/3gl/LINUX/git-2007-12-17 130> rm config.{log,status}
> >>> a5:/pro/3gl/LINUX/git-2007-12-17 131> configure --prefix=/pro/local \
> >>>    --disable-nls --without-iconv --with-perl=/pro/bin/perl >& config-log 
> >>> a5:/pro/3gl/LINUX/git-2007-12-17 132> grep -w install config-log config.log config.status
> >>> config-log:checking for a BSD-compatible install... /opt/imake/bin/install -c
> >>> config.log:configure:2218: checking for a BSD-compatible install
> >>> config.log:configure:2273: result: /opt/imake/bin/install -c
> >>> config.log:ac_cv_path_install='/opt/imake/bin/install -c'
> >>> config.status:INSTALL="/opt/imake/bin/install -c"
> >> 
> >> Does chosen by ./configure script 'install' binary, namely 
> >> /opt/imake/bin/install works correctly, meaning does it install
> >> git correctly?
> > 
> > No. I reported this before, but not to the list. This is why I created
> > my own make-install shell:
> 
> I though that you were talking about _default_ 'install' program
> (first in PATH). Is /opt/imake/bin/install used below?

Yes. There is only ONE install program
(that is a small lie, there is also /usr/sbin/install, but that is not
 accessible for mortal users)

> I have forgot to tell that beside uncommenting AC_PROG_INSTALL line
> in configure.ac (and doing "make configure") you have to also uncomment
> the "INSTALL = @INSTALL@" in config.mak.in for "make install" to use
> install program found by ./configure script.

But I don't think it found install-sh.

/pro/3gl/LINUX/git-2007-12-17 103 > grep -w install config-log
checking for a BSD-compatible install... /opt/imake/bin/install -c

> > /pro/3gl/LINUX/git-2007-12-17 113> make install
> >     SUBDIR git-gui
> >     INDEX lib/
> >     SUBDIR gitk-git
> > make[1]: Nothing to be done for `all'.
> >     SUBDIR perl
> >     SUBDIR templates
> > install -d -m 755 '/pro/local/bin'
> > rm: /pro/local/bin/ directory
> > Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
> >        mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
> >        mv [-f] [-i] [-e warn|force|ignore] d1 d2
> 
> Strange...
> 
> By the way, I have took a look at hos ./configure script chooses which
> 'install' to use, and at least for GNU Autoconf 2.59 it does not talk
> about HP-UX at all, and checks binaries to reject by grepping for
> a string, instead of checking if it install files correctly using some
> script (at least checking if it install files and creates directories,
> and accepts install options used, without checking for correct permissions
> and group, etc.).
> 
> Relevant fragment of generated ./configure script

http://www.xs4all.nl/~procura/configure

added a 'set -x' there:

configure: CHECKS for programs
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
+ echo configure:2219: checking for a BSD-compatible install
+ 1>& 5
+ echo checking for a BSD-compatible install... \c
+ 1>& 6
checking for a BSD-compatible install... + test -z
+ test  = set
+ as_save_IFS=

+ IFS=:
+ IFS=

+ test -z .
+ IFS=

+ test -z /u/usr/merijn/bin/private
+ test -f /u/usr/merijn/bin/private/ginstall
+ test -f /u/usr/merijn/bin/private/scoinst
+ test -f /u/usr/merijn/bin/private/install
+ IFS=

etc etc for the rest of the $PATH ...

+ test -z /opt/imake/bin
+ test -f /opt/imake/bin/ginstall
+ test -f /opt/imake/bin/scoinst
+ test -f /opt/imake/bin/install
+ test install = install
+ grep dspmsg /opt/imake/bin/install
+ 1> /dev/null 2>& 1
+ test install = install
+ grep pwplus /opt/imake/bin/install
+ 1> /dev/null 2>& 1
+ ac_cv_path_install=/opt/imake/bin/install -c
+ break 3
+ test set = set
+ INSTALL=/opt/imake/bin/install -c
+ echo configure:2274: result: /opt/imake/bin/install -c
+ 1>& 5
+ echo /opt/imake/bin/install -c
+ 1>& 6
/opt/imake/bin/install -c
+ exit
+ exit_status=0
+ 1>& 5
+ echo
+ cat
+ 0< /var/tmp/sh8180.20
+ echo
+ 2>& 1
+ 2>& 1
+ sed -n s/'/'\\''/g;
          s/^\([_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]*_cv_[_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]*\)=\(.*\)/\1='\2'/p
+ echo
+ cat
+ 0< /var/tmp/sh8180.21
+ echo
+ sort
+ echo SHELL
+ eval ac_val=$SHELL
:
:
+ ac_val=o
+ echo OBJEXT='o'
+ echo INSTALL_PROGRAM
+ eval ac_val=$INSTALL_PROGRAM
+ ac_val=
+ echo INSTALL_PROGRAM=''
+ echo INSTALL_SCRIPT
+ eval ac_val=$INSTALL_SCRIPT
+ ac_val=
+ echo INSTALL_SCRIPT=''
+ echo INSTALL_DATA
+ eval ac_val=$INSTALL_DATA
+ ac_val=
+ echo INSTALL_DATA=''
+ echo AR
+ eval ac_val=$AR
:
:
+ echo
+ test -n
+ test -s confdefs.h
+ cat
+ 0< /var/tmp/sh8180.23
+ echo
+ sed /^$/d confdefs.h
+ sort
+ echo
+ test 0 != 0
+ echo configure: exit 0
+ rm -f core *.core
+ rm -rf conftest* confdefs.h conf8180*


> -- >8 -- configure
> 
> # Find a good install program.  We prefer a C program (faster),
> # so one script is as good as another.  But avoid the broken or
> # incompatible versions:
> # SysV /etc/install, /usr/sbin/install
> # SunOS /usr/etc/install
> # IRIX /sbin/install
> # AIX /bin/install
> # AmigaOS /C/install, which installs bootblocks on floppy discs
> # AIX 4 /usr/bin/installbsd, which doesn't work without a -g flag
> # AFS /usr/afsws/bin/install, which mishandles nonexistent args
> # SVR4 /usr/ucb/install, which tries to use the nonexistent group "staff"
> # OS/2's system install, which has a completely different semantic
> # ./install, which can be erroneously created by make from ./install.sh.
> echo "$as_me:$LINENO: checking for a BSD-compatible install" >&5
> echo $ECHO_N "checking for a BSD-compatible install... $ECHO_C" >&6
> if test -z "$INSTALL"; then
> if test "${ac_cv_path_install+set}" = set; then
>   echo $ECHO_N "(cached) $ECHO_C" >&6
> else
>   as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
> for as_dir in $PATH
> do
>   IFS=$as_save_IFS
>   test -z "$as_dir" && as_dir=.
>   # Account for people who put trailing slashes in PATH elements.
> case $as_dir/ in
>   ./ | .// | /cC/* | \
>   /etc/* | /usr/sbin/* | /usr/etc/* | /sbin/* | /usr/afsws/bin/* | \
>   ?:\\/os2\\/install\\/* | ?:\\/OS2\\/INSTALL\\/* | \
>   /usr/ucb/* ) ;;
>   *)
>     # OSF1 and SCO ODT 3.0 have their own names for install.
>     # Don't use installbsd from OSF since it installs stuff as root
>     # by default.
>     for ac_prog in ginstall scoinst install; do
>       for ac_exec_ext in '' $ac_executable_extensions; do
> 	if $as_executable_p "$as_dir/$ac_prog$ac_exec_ext"; then
> 	  if test $ac_prog = install &&
> 	    grep dspmsg "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
> 	    # AIX install.  It has an incompatible calling convention.
> 	    :
> 	  elif test $ac_prog = install &&
> 	    grep pwplus "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
> 	    # program-specific install script used by HP pwplus--don't use.
> 	    :
> 	  else
> 	    ac_cv_path_install="$as_dir/$ac_prog$ac_exec_ext -c"
> 	    break 3
> 	  fi
> 	fi
>       done
>     done
>     ;;
> esac
> done
> 
> 
> fi
>   if test "${ac_cv_path_install+set}" = set; then
>     INSTALL=$ac_cv_path_install
>   else
>     # As a last resort, use the slow shell script.  We don't cache a
>     # path for INSTALL within a source directory, because that will
>     # break other packages using the cache if that directory is
>     # removed, or if the path is relative.
>     INSTALL=$ac_install_sh
>   fi
> fi
> echo "$as_me:$LINENO: result: $INSTALL" >&5
> echo "${ECHO_T}$INSTALL" >&6
> 


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
