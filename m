From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 14:32:46 +0100
Message-ID: <20071218143246.2437bfaf@pc09.procura.nl>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
	<200712181014.38986.jnareb@gmail.com>
	<20071218121115.1c893dc4@pc09.procura.nl>
	<200712181333.01051.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 14:33:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4cZY-0007hZ-2n
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 14:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbXLRNdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 08:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbXLRNdA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 08:33:00 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:3853 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbXLRNc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 08:32:58 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBIDWnSG072744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 14:32:49 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <200712181333.01051.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68744>

On Tue, 18 Dec 2007 13:32:59 +0100, Jakub Narebski <jnareb@gmail.com> wrote:

> H.Merijn Brand wrote:
> > On Tue, 18 Dec 2007 10:14:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
> >> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> >>> On Tue, 18 Dec 2007 09:20:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
> >>>> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> >>>>> On Mon, 17 Dec 2007 17:21:08 -0800 (PST), Jakub Narebski wrote:
> >>>>>>
> >>>>>> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
> >>>>>> there is BSD-compatible `install' program (as 'install-sh' or
> >>>>>> 'install.sh') in the sources.  Adding such script is (I think) not a
> >>>>>> problem; finding minimal portable[*1*] script is.  
> >>>>>> So if you know one... 
> >>>> 
> >>>> [...]. There is need for BSD-compatibile
> >>>> `install` program as 'install-sh', not 'make-install' script. The idea
> >>>> is to use system-provided 'install' if it exists and is compatibile,
> >>> 
> >>> There lies the problem. HP-UX does have an 'install', but it is not
> >>> compatible, and chances are (very) small that people have installed
> >>> the GNU or any other BSD compliant install.
> >>> 
> >>>> because it should be faster than script version, and fallback to 
> >>>> provided install-sh only if system install is not found.
> >>> 
> >>> The problem again. It *does* find install, but it turns out to be
> >>> unusable.
> >> 
> >> Could you check if ./configure correctly uses install-sh in your case?
> >> Copy install-sh from for example autotools[*1*] (e.g. libtool has one)
> >> to the git sources, uncomment line with AC_PROG_INSTALL in configure.ac,
> >> generate configure script using "make configure" and check what
> >> ./configure chooses.
> >> 
> >> In my case it is:
> >> 
> >>   $ cp /usr/share/libtool/install-sh .
> >>   $ make configure
> >>   GIT_VERSION = 1.5.4.rc0.56.g6fbe-dirty
> >>       GEN configure
> >>   $ ./configure
> >>   configure: CHECKS for programs
> >>   [...]
> >>   checking for a BSD-compatible install... /usr/bin/install -c
> >> 
> >> What is ./configure output in your case?
> 
>  
> > /pro/3gl/LINUX/git-2007-12-17 119> cp /pro/3gl/GNU/gcc/r3/gcc-4.2.2/install-sh install-sh
> 
> > -- uncommented the AC_PROG_INSTALL line ...
> 
> > OK, rebuild configure ...
> > 
> > a5:/pro/3gl/LINUX/git-2007-12-17 129> make configure
> >     GEN configure
> > a5:/pro/3gl/LINUX/git-2007-12-17 130> rm config.{log,status}
> > a5:/pro/3gl/LINUX/git-2007-12-17 131> configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl> & config-log
> > a5:/pro/3gl/LINUX/git-2007-12-17 132> grep -w install config-log config.log config.status
> > config-log:checking for a BSD-compatible install... /opt/imake/bin/install -c
> > config.log:configure:2218: checking for a BSD-compatible install
> > config.log:configure:2273: result: /opt/imake/bin/install -c
> > config.log:ac_cv_path_install='/opt/imake/bin/install -c'
> > config.status:INSTALL="/opt/imake/bin/install -c"
> 
> Does chosen by ./configure script 'install' binary, namely 
> /opt/imake/bin/install works correctly, meaning does it install
> git correctly?

No. I reported this before, but not to the list. This is why I created
my own make-install shell:

/pro/3gl/LINUX/git-2007-12-17 113 > make install
    SUBDIR git-gui
    INDEX lib/
    SUBDIR gitk-git
make[1]: Nothing to be done for `all'.
    SUBDIR perl
    SUBDIR templates
install -d -m 755 '/pro/local/bin'
rm: /pro/local/bin/ directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
install -d -m 755 '/pro/local/bin'
rm: /pro/local/bin/ directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
install git-fetch-pack git-hash-object git-index-pack git-fast-import git-daemon git-merge-index git-mktag git-mktree git-patch-id git-receive-pack git-send-pack git-shell git-show-index git-unpack-file git-update-server-info git-upload-pack git-pack-redundant git-var git-merge-tree git-imap-send git-merge-recursive  git-bisect git-checkout git-clone git-merge-one-file git-mergetool git-parse-remote git-pull git-rebase git-rebase--interactive git-repack git-request-pull git-sh-setup git-am git-merge git-merge-stupid git-merge-octopus git-merge-resolve git-lost-found git-quiltimport git-submodule git-filter-branch git-stash git-help--browse git-add--interactive git-archimport git-cvsimport git-relink git-cvsserver git-remote git-cvsexportcommit git-send-email git-svn git-instaweb git-merge-
 subtree '/pro/local/bin'
install git '/pro/local/bin'
make -C templates DESTDIR='' install
make[1]: Entering directory `/pro/3gl/LINUX/git-2007-12-17/templates'
install -d -m 755 '/pro/local/share/git-core/templates/'
rm: /pro/local/share/git-core/templates// directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
(cd blt && tar cf - .) | \
(cd '/pro/local/share/git-core/templates/' && tar xf -)
make[1]: Leaving directory `/pro/3gl/LINUX/git-2007-12-17/templates'
make -C perl prefix='/pro/local' DESTDIR='' install
make[1]: Entering directory `/pro/3gl/LINUX/git-2007-12-17/perl'
make[2]: Entering directory `/pro/3gl/LINUX/git-2007-12-17/perl'
Writing /pro/local/lib/perl5/site_perl/5.8.8/PA-RISC2.0/auto/Git/.packlist
Appending installation info to /pro/local/lib/perl5/5.8.8/PA-RISC2.0/perllocal.pod
make[2]: Leaving directory `/pro/3gl/LINUX/git-2007-12-17/perl'
make[1]: Leaving directory `/pro/3gl/LINUX/git-2007-12-17/perl'
make -C gitk-git install
make[1]: Entering directory `/pro/3gl/LINUX/git-2007-12-17/gitk-git'
install gitk-wish '/pro/local/bin'/gitk
make[1]: Leaving directory `/pro/3gl/LINUX/git-2007-12-17/gitk-git'
make -C git-gui install
make[1]: Entering directory `/pro/3gl/LINUX/git-2007-12-17/git-gui'
    INDEX lib/
  DEST /pro/local/bin
rm: /pro/local/bin/ directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
    INSTALL 755 git-gui
    LINK        git-citool -> git-gui
  DEST /pro/local/share/git-gui/lib
rm: /pro/local/share/git-gui/lib/ directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
    INSTALL 644 tclIndex
mv: lib/tclIndex: cannot access: No such file or directory
chmod: can't access /pro/local/share/git-gui/lib/tclIndex
    INSTALL 644 git-gui.ico
mv: lib/git-gui.ico: cannot access: No such file or directory
chmod: can't access /pro/local/share/git-gui/lib/git-gui.ico
  DEST /pro/local/share/git-gui/lib/msgs
rm: /pro/local/share/git-gui/lib/msgs/ directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
    INSTALL 644 de.msg
    INSTALL 644 hu.msg
    INSTALL 644 it.msg
    INSTALL 644 ja.msg
    INSTALL 644 ru.msg
    INSTALL 644 zh_cn.msg
make[1]: Leaving directory `/pro/3gl/LINUX/git-2007-12-17/git-gui'
if test 'z/pro/local/bin' != 'z/pro/local/bin'; \
then \
        ln -f '/pro/local/bin/git' \
                '/pro/local/bin/git' || \
        cp '/pro/local/bin/git' \
                '/pro/local/bin/git'; \
fi
rm -f '/pro/local/bin/git-format-patch' && ln '/pro/local/bin/git' '/pro/local/bin/git-format-patch' ;  rm -f '/pro/local/bin/git-show' && ln '/pro/local/bin/git' '/pro/local/bin/git-show' ;  rm -f '/pro/local/bin/git-whatchanged' && ln '/pro/local/bin/git' '/pro/local/bin/git-whatchanged' ;  rm -f '/pro/local/bin/git-cherry' && ln '/pro/local/bin/git' '/pro/local/bin/git-cherry' ;  rm -f '/pro/local/bin/git-get-tar-commit-id' && ln '/pro/local/bin/git' '/pro/local/bin/git-get-tar-commit-id' ;  rm -f '/pro/local/bin/git-init' && ln '/pro/local/bin/git' '/pro/local/bin/git-init' ;  rm -f '/pro/local/bin/git-repo-config' && ln '/pro/local/bin/git' '/pro/local/bin/git-repo-config' ;  rm -f '/pro/local/bin/git-fsck-objects' && ln '/pro/local/bin/git' '/pro/local/bin/git-fsck-objects' ;  rm -f 
 '/pro/local/bin/git-cherry-pick' && ln '/pro/local/bin/git' '/pro/local/bin/git-cherry-pick' ;  rm -f '/pro/local/bin/git-peek-remote' && ln '/pro/local/bin/git' '/pro/local/bin/git-peek-re!
 mote' ;  rm -f '/pro/local/bin/git-status' && ln '/pro/local/bin/git' '/pro/local/bin/git-status' ;  rm -f '/pro/local/bin/git-add' && ln '/pro/local/bin/git' '/pro/local/bin/git-add' ;  rm -f '/pro/local/bin/git-annotate' && ln '/pro/local/bin/git' '/pro/local/bin/git-annotate' ;  rm -f '/pro/local/bin/git-apply' && ln '/pro/local/bin/git' '/pro/local/bin/git-apply' ;  rm -f '/pro/local/bin/git-archive' && ln '/pro/local/bin/git' '/pro/local/bin/git-archive' ;  rm -f '/pro/local/bin/git-blame' && ln '/pro/local/bin/git' '/pro/local/bin/git-blame' ;  rm -f '/pro/local/bin/git-branch' && ln '/pro/local/bin/git' '/pro/local/bin/git-branch' ;  rm -f '/pro/local/bin/git-bundle' && ln '/pro/local/bin/git' '/pro/local/bin/git-bundle' ;  rm -f '/pro/local/bin/git-cat-file' && ln '/pro/local/bin/
 git' '/pro/local/bin/git-cat-file' ;  rm -f '/pro/local/bin/git-check-attr' && ln '/pro/local/bin/git' '/pro/local/bin/git-check-attr' ;  rm -f '/pro/local/bin/git-checkout-index' && ln '/p!
 ro/local/bin/git' '/pro/local/bin/git-checkout-index' ;  rm -f '/pro/l
ocal/bin/git-check-ref-format' && ln '/pro/local/bin/git' '/pro/local/bin/git-check-ref-format' ;  rm -f '/pro/local/bin/git-clean' && ln '/pro/local/bin/git' '/pro/local/bin/git-clean' ;  rm -f '/pro/local/bin/git-commit' && ln '/pro/local/bin/git' '/pro/local/bin/git-commit' ;  rm -f '/pro/local/bin/git-commit-tree' && ln '/pro/local/bin/git' '/pro/local/bin/git-commit-tree' ;  rm -f '/pro/local/bin/git-count-objects' && ln '/pro/local/bin/git' '/pro/local/bin/git-count-objects' ;  rm -f '/pro/local/bin/git-describe' && ln '/pro/local/bin/git' '/pro/local/bin/git-describe' ;  rm -f '/pro/local/bin/git-diff' && ln '/pro/local/bin/git' '/pro/local/bin/git-diff' ;  rm -f '/pro/local/bin/git-diff-files' && ln '/pro/local/bin/git' '/pro/local/bin/git-diff-files' ;  rm -f '/pro/local/bin/git-d
 iff-index' && ln '/pro/local/bin/git' '/pro/local/bin/git-diff-index' ;  rm -f '/pro/local/bin/git-diff-tree' && ln '/pro/local/bin/git' '/pro/local/bin/git-diff-tree' ;  rm -f '/pro/local/!
 bin/git-fast-export' && ln '/pro/local/bin/git' '/pro/local/bin/git-fast-export' ;  rm -f '/pro/local/bin/git-fetch' && ln '/pro/local/bin/git' '/pro/local/bin/git-fetch' ;  rm -f '/pro/local/bin/git-fetch-pack' && ln '/pro/local/bin/git' '/pro/local/bin/git-fetch-pack' ;  rm -f '/pro/local/bin/git-fetch--tool' && ln '/pro/local/bin/git' '/pro/local/bin/git-fetch--tool' ;  rm -f '/pro/local/bin/git-fmt-merge-msg' && ln '/pro/local/bin/git' '/pro/local/bin/git-fmt-merge-msg' ;  rm -f '/pro/local/bin/git-for-each-ref' && ln '/pro/local/bin/git' '/pro/local/bin/git-for-each-ref' ;  rm -f '/pro/local/bin/git-fsck' && ln '/pro/local/bin/git' '/pro/local/bin/git-fsck' ;  rm -f '/pro/local/bin/git-gc' && ln '/pro/local/bin/git' '/pro/local/bin/git-gc' ;  rm -f '/pro/local/bin/git-grep' && ln '/p
 ro/local/bin/git' '/pro/local/bin/git-grep' ;  rm -f '/pro/local/bin/git-init-db' && ln '/pro/local/bin/git' '/pro/local/bin/git-init-db' ;  rm -f '/pro/local/bin/git-log' && ln '/pro/local!
 /bin/git' '/pro/local/bin/git-log' ;  rm -f '/pro/local/bin/git-ls-fil
es' && ln '/pro/local/bin/git' '/pro/local/bin/git-ls-files' ;  rm -f '/pro/local/bin/git-ls-tree' && ln '/pro/local/bin/git' '/pro/local/bin/git-ls-tree' ;  rm -f '/pro/local/bin/git-ls-remote' && ln '/pro/local/bin/git' '/pro/local/bin/git-ls-remote' ;  rm -f '/pro/local/bin/git-mailinfo' && ln '/pro/local/bin/git' '/pro/local/bin/git-mailinfo' ;  rm -f '/pro/local/bin/git-mailsplit' && ln '/pro/local/bin/git' '/pro/local/bin/git-mailsplit' ;  rm -f '/pro/local/bin/git-merge-base' && ln '/pro/local/bin/git' '/pro/local/bin/git-merge-base' ;  rm -f '/pro/local/bin/git-merge-file' && ln '/pro/local/bin/git' '/pro/local/bin/git-merge-file' ;  rm -f '/pro/local/bin/git-merge-ours' && ln '/pro/local/bin/git' '/pro/local/bin/git-merge-ours' ;  rm -f '/pro/local/bin/git-mv' && ln '/pro/local/bi
 n/git' '/pro/local/bin/git-mv' ;  rm -f '/pro/local/bin/git-name-rev' && ln '/pro/local/bin/git' '/pro/local/bin/git-name-rev' ;  rm -f '/pro/local/bin/git-pack-objects' && ln '/pro/local/b!
 in/git' '/pro/local/bin/git-pack-objects' ;  rm -f '/pro/local/bin/git-prune' && ln '/pro/local/bin/git' '/pro/local/bin/git-prune' ;  rm -f '/pro/local/bin/git-prune-packed' && ln '/pro/local/bin/git' '/pro/local/bin/git-prune-packed' ;  rm -f '/pro/local/bin/git-push' && ln '/pro/local/bin/git' '/pro/local/bin/git-push' ;  rm -f '/pro/local/bin/git-read-tree' && ln '/pro/local/bin/git' '/pro/local/bin/git-read-tree' ;  rm -f '/pro/local/bin/git-reflog' && ln '/pro/local/bin/git' '/pro/local/bin/git-reflog' ;  rm -f '/pro/local/bin/git-send-pack' && ln '/pro/local/bin/git' '/pro/local/bin/git-send-pack' ;  rm -f '/pro/local/bin/git-config' && ln '/pro/local/bin/git' '/pro/local/bin/git-config' ;  rm -f '/pro/local/bin/git-rerere' && ln '/pro/local/bin/git' '/pro/local/bin/git-rerere' ;  
 rm -f '/pro/local/bin/git-reset' && ln '/pro/local/bin/git' '/pro/local/bin/git-reset' ;  rm -f '/pro/local/bin/git-rev-list' && ln '/pro/local/bin/git' '/pro/local/bin/git-rev-list' ;  rm !
 -f '/pro/local/bin/git-rev-parse' && ln '/pro/local/bin/git' '/pro/loc
al/bin/git-rev-parse' ;  rm -f '/pro/local/bin/git-revert' && ln '/pro/local/bin/git' '/pro/local/bin/git-revert' ;  rm -f '/pro/local/bin/git-rm' && ln '/pro/local/bin/git' '/pro/local/bin/git-rm' ;  rm -f '/pro/local/bin/git-shortlog' && ln '/pro/local/bin/git' '/pro/local/bin/git-shortlog' ;  rm -f '/pro/local/bin/git-show-branch' && ln '/pro/local/bin/git' '/pro/local/bin/git-show-branch' ;  rm -f '/pro/local/bin/git-stripspace' && ln '/pro/local/bin/git' '/pro/local/bin/git-stripspace' ;  rm -f '/pro/local/bin/git-symbolic-ref' && ln '/pro/local/bin/git' '/pro/local/bin/git-symbolic-ref' ;  rm -f '/pro/local/bin/git-tag' && ln '/pro/local/bin/git' '/pro/local/bin/git-tag' ;  rm -f '/pro/local/bin/git-tar-tree' && ln '/pro/local/bin/git' '/pro/local/bin/git-tar-tree' ;  rm -f '/pro/loc
 al/bin/git-unpack-objects' && ln '/pro/local/bin/git' '/pro/local/bin/git-unpack-objects' ;  rm -f '/pro/local/bin/git-update-index' && ln '/pro/local/bin/git' '/pro/local/bin/git-update-in!
 dex' ;  rm -f '/pro/local/bin/git-update-ref' && ln '/pro/local/bin/git' '/pro/local/bin/git-update-ref' ;  rm -f '/pro/local/bin/git-upload-archive' && ln '/pro/local/bin/git' '/pro/local/bin/git-upload-archive' ;  rm -f '/pro/local/bin/git-verify-pack' && ln '/pro/local/bin/git' '/pro/local/bin/git-verify-pack' ;  rm -f '/pro/local/bin/git-verify-tag' && ln '/pro/local/bin/git' '/pro/local/bin/git-verify-tag' ;  rm -f '/pro/local/bin/git-write-tree' && ln '/pro/local/bin/git' '/pro/local/bin/git-write-tree' ;  rm -f '/pro/local/bin/git-show-ref' && ln '/pro/local/bin/git' '/pro/local/bin/git-show-ref' ;  rm -f '/pro/local/bin/git-pack-refs' && ln '/pro/local/bin/git' '/pro/local/bin/git-pack-refs' ;


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
