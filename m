From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 15:01:02 +0000
Message-ID: <20071204150102.7f3ec3e9@pc09.procura.nl>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZHB-0006S4-Fr
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbXLDPBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbXLDPBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:01:09 -0500
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:1558 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbXLDPBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:01:08 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id lB4F14Yn024449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 16:01:04 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <Pine.LNX.4.64.0712041439590.27959@racer.site>
X-Mailer: Claws Mail 3.1.0cvs51 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67051>

On Tue, 4 Dec 2007 14:40:47 +0000 (GMT), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Tue, 4 Dec 2007, H.Merijn Brand wrote:
> 
> > On Tue, 4 Dec 2007 13:44:02 +0000 (GMT), Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > Hi,
> > > 
> > > On Tue, 4 Dec 2007, H.Merijn Brand wrote:
> > > 
> > > > make test then fails:
> > > 
> > > Could you run the failing test manually with -i -v, like so:
> > > 
> > > 	$ cd t/
> > > 	$ sh t0001*.sh -i -v
> > 
> > /pro/3gl/LINUX/git-1.5.3.7 183 > cd t
> > /pro/3gl/LINUX/git-1.5.3.7/t 184 > sh t0001*.sh -i -v
> > * error: cannot run git init -- have you built things yet?
> > Exit 1
> > /pro/3gl/LINUX/git-1.5.3.7/t 185 >
> 
> Next step: add the sh option -x:

I also meanwhile forced copied the git binaries to my bin dir

/pro/3gl/LINUX/git-1.5.3.7/t 106 > git --version
git version 1.5.3.7


> 	$ sh -x t0001*.sh -i -v

/pro/3gl/LINUX/git-1.5.3.7/t 105 > sh -x t0001*.sh -i -v
+ test_description=git init
+ . ./test-lib.sh
+ LANG=C
+ LC_ALL=C
+ PAGER=cat
+ TZ=UTC
+ export LANG LC_ALL PAGER TZ
+ EDITOR=:
+ VISUAL=:
+ unset GIT_EDITOR
+ unset AUTHOR_DATE
+ unset AUTHOR_EMAIL
+ unset AUTHOR_NAME
+ unset COMMIT_AUTHOR_EMAIL
+ unset COMMIT_AUTHOR_NAME
+ unset EMAIL
+ unset GIT_ALTERNATE_OBJECT_DIRECTORIES
+ unset GIT_AUTHOR_DATE
+ GIT_AUTHOR_EMAIL=author@example.com
+ GIT_AUTHOR_NAME=A U Thor
+ unset GIT_COMMITTER_DATE
+ GIT_COMMITTER_EMAIL=committer@example.com
+ GIT_COMMITTER_NAME=C O Mitter
+ unset GIT_DIFF_OPTS
+ unset GIT_DIR
+ unset GIT_WORK_TREE
+ unset GIT_EXTERNAL_DIFF
+ unset GIT_INDEX_FILE
+ unset GIT_OBJECT_DIRECTORY
+ unset SHA1_FILE_DIRECTORIES
+ unset SHA1_FILE_DIRECTORY
+ GIT_MERGE_VERBOSITY=5
+ export GIT_MERGE_VERBOSITY
+ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
+ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+ export EDITOR VISUAL
+ unset CDPATH
+ tr [A-Z] [a-z]
+ echo
+ test git init !=
+ test 2 -ne 0
+ immediate=t
+ shift
+ test 1 -ne 0
+ verbose=t
+ shift
+ test 0 -ne 0
+ exec
+ 5>& 1
+ test t = t
+ exec
+ 4>& 2 3>& 1
+ test_failure=0
+ test_count=0
+ trap echo >&5 "FATAL: Unexpected exit with code $?"; exit 1 exit
+ + pwd
PATH=/pro/3gl/LINUX/git-1.5.3.7/t/..:.:/u/usr/merijn/bin/private:/u/usr/merijn/bin:/pro/local/bin:/pro/bin:/usr/hosts:/usr/bin:/opt/ansic/bin:/usr/ccs/bin:/usr/contrib/bin:/opt/nettladm/bin:/opt/fc/bin:/opt/fcms/bin:/opt/upgrade/bin:/opt/pd/bin:/usr/bin/X11:/usr/contrib/bin/X11:/opt/resmon/bin:/usr/sbin/diag/contrib:/opt/pred/bin:/opt/hparray/bin:/opt/perf/bin:/opt/langtools/bin:/opt/imake/bin:/opt/ignite/bin:/opt/sec_mgmt/spc/bin:/usr/local/bin:/usr/local/sbin:/opt/java1.5/jre/bin:/opt/graphics/common/bin:/pro/local/libexec:/pro/local/sbin:/pro/local/samba/bin:/pro/local/samba/sbin:/opt/hpnpl/bin:/pro/tu/bin:/usr/sbin:/sbin:/usr/local/pa20_64/bin:/pro/3gl/CPAN/bin
+ + pwd
GIT_EXEC_PATH=/pro/3gl/LINUX/git-1.5.3.7/t/..
+ + pwd
GIT_TEMPLATE_DIR=/pro/3gl/LINUX/git-1.5.3.7/t/../templates/blt
+ GIT_CONFIG=.git/config
+ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
+ + pwd
+ pwd
GITPERLLIB=/pro/3gl/LINUX/git-1.5.3.7/t/../perl/blib/lib:/pro/3gl/LINUX/git-1.5.3.7/t/../perl/blib/arch/auto/Git
+ export GITPERLLIB
+ test -d ../templates/blt
+ test -x ../test-chmtime
+ test=trash
+ rm -fr trash
+ test_create_repo trash
* error: cannot run git init -- have you built things yet?
Exit 1

pro/3gl/LINUX/git-1.5.3.7/t 108 > ll /pro/local/bin/git*
127035 -rwxrwxrwx 1 merijn softwr 1081204 Dec  4 15:19 /pro/local/bin/git
 86787 -rwxrwxrwx 1 merijn softwr   16467 Dec  4 15:22 /pro/local/bin/git-add--interactive
 86627 -rwxrwxrwx 1 merijn softwr   11285 Dec  4 15:22 /pro/local/bin/git-am
 86909 -rwxrwxrwx 1 merijn softwr   36968 Dec  4 15:22 /pro/local/bin/git-archimport
 86420 -rwxrwxrwx 1 merijn softwr    8508 Dec  4 15:22 /pro/local/bin/git-bisect
 86423 -rwxrwxrwx 1 merijn softwr    6905 Dec  4 15:22 /pro/local/bin/git-checkout
 86424 -rwxrwxrwx 1 merijn softwr    1972 Dec  4 15:22 /pro/local/bin/git-clean
 86427 -rwxrwxrwx 1 merijn softwr   11560 Dec  4 15:22 /pro/local/bin/git-clone
 86428 -rwxrwxrwx 1 merijn softwr   14693 Dec  4 15:22 /pro/local/bin/git-commit
127036 -rwxrwxrwx 1 merijn softwr  327540 Dec  4 15:19 /pro/local/bin/git-convert-objects
 87086 -rwxrwxrwx 1 merijn softwr    9394 Dec  4 15:22 /pro/local/bin/git-cvsexportcommit
 86968 -rwxrwxrwx 1 merijn softwr   26590 Dec  4 15:22 /pro/local/bin/git-cvsimport
 86997 -rwxrwxrwx 1 merijn softwr  101558 Dec  4 15:22 /pro/local/bin/git-cvsserver
 86356 -rwxrwxrwx 1 merijn softwr  343924 Dec  4 15:22 /pro/local/bin/git-daemon
 86355 -rwxrwxrwx 1 merijn softwr  420048 Dec  4 15:22 /pro/local/bin/git-fast-import
 86440 -rwxrwxrwx 1 merijn softwr    9083 Dec  4 15:22 /pro/local/bin/git-fetch
 87107 -rwxrwxrwx 1 merijn softwr  360308 Dec  4 15:22 /pro/local/bin/git-fetch-pack
 86724 -rwxrwxrwx 1 merijn softwr   10240 Dec  4 15:22 /pro/local/bin/git-filter-branch
 86351 -rwxrwxrwx 1 merijn softwr  323444 Dec  4 15:22 /pro/local/bin/git-hash-object
 86390 -rwxrwxrwx 1 merijn softwr  343924 Dec  4 15:22 /pro/local/bin/git-imap-send
 87114 -rwxrwxrwx 1 merijn softwr  348020 Dec  4 15:22 /pro/local/bin/git-index-pack
 87100 -rwxrwxrwx 1 merijn softwr  177519 Dec  4 15:22 /pro/local/bin/git-instaweb
 86342 -rwxrwxrwx 1 merijn softwr  339828 Dec  4 15:22 /pro/local/bin/git-local-fetch
 86680 -rwxrwxrwx 1 merijn softwr     473 Dec  4 15:22 /pro/local/bin/git-lost-found
 86444 -rwxrwxrwx 1 merijn softwr    2544 Dec  4 15:22 /pro/local/bin/git-ls-remote
 86633 -rwxrwxrwx 1 merijn softwr   11464 Dec  4 15:22 /pro/local/bin/git-merge
 86359 -rwxrwxrwx 1 merijn softwr  323444 Dec  4 15:22 /pro/local/bin/git-merge-index
 86636 -rwxrwxrwx 1 merijn softwr    2415 Dec  4 15:22 /pro/local/bin/git-merge-octopus
 86445 -rwxrwxrwx 1 merijn softwr    3364 Dec  4 15:22 /pro/local/bin/git-merge-one-file
 86656 -rwxrwxrwx 1 merijn softwr     338 Dec  4 15:22 /pro/local/bin/git-merge-ours
 86391 -rwxrwxrwx 1 merijn softwr  491380 Dec  4 15:22 /pro/local/bin/git-merge-recursive
 86643 -rwxrwxrwx 1 merijn softwr     954 Dec  4 15:22 /pro/local/bin/git-merge-resolve
 86634 -rwxrwxrwx 1 merijn softwr    1456 Dec  4 15:22 /pro/local/bin/git-merge-stupid
 86399 -rwxrwxrwx 1 merijn softwr  491380 Dec  4 15:21 /pro/local/bin/git-merge-subtree
 86389 -rwxrwxrwx 1 merijn softwr  348020 Dec  4 15:22 /pro/local/bin/git-merge-tree
 86446 -rwxrwxrwx 1 merijn softwr    8649 Dec  4 15:22 /pro/local/bin/git-mergetool
 86361 -rwxrwxrwx 1 merijn softwr  323444 Dec  4 15:22 /pro/local/bin/git-mktag
 86363 -rwxrwxrwx 1 merijn softwr  323444 Dec  4 15:22 /pro/local/bin/git-mktree
 86387 -rwxrwxrwx 1 merijn softwr  331636 Dec  4 15:22 /pro/local/bin/git-pack-redundant
 86447 -rwxrwxrwx 1 merijn softwr    5892 Dec  4 15:22 /pro/local/bin/git-parse-remote
 86365 -rwxrwxrwx 1 merijn softwr  319348 Dec  4 15:22 /pro/local/bin/git-patch-id
 86367 -rwxrwxrwx 1 merijn softwr  348020 Dec  4 15:22 /pro/local/bin/git-peek-remote
 86450 -rwxrwxrwx 1 merijn softwr    3868 Dec  4 15:22 /pro/local/bin/git-pull
 86692 -rwxrwxrwx 1 merijn softwr    3203 Dec  4 15:22 /pro/local/bin/git-quiltimport
 86454 -rwxrwxrwx 1 merijn softwr    8737 Dec  4 15:22 /pro/local/bin/git-rebase
 86456 -rwxrwxrwx 1 merijn softwr   11642 Dec  4 15:22 /pro/local/bin/git-rebase--interactive
 86369 -rwxrwxrwx 1 merijn softwr  335732 Dec  4 15:22 /pro/local/bin/git-receive-pack
 86988 -rwxrwxrwx 1 merijn softwr    4189 Dec  4 15:22 /pro/local/bin/git-relink
 87012 -rwxrwxrwx 1 merijn softwr    9524 Dec  4 15:22 /pro/local/bin/git-remote
 86457 -rwxrwxrwx 1 merijn softwr    2886 Dec  4 15:22 /pro/local/bin/git-repack
 86458 -rwxrwxrwx 1 merijn softwr    1364 Dec  4 15:22 /pro/local/bin/git-request-pull
 86591 -rwxrwxrwx 1 merijn softwr    2304 Dec  4 15:22 /pro/local/bin/git-reset
 87087 -rwxrwxrwx 1 merijn softwr   20052 Dec  4 15:22 /pro/local/bin/git-send-email
 86371 -rwxrwxrwx 1 merijn softwr  356212 Dec  4 15:22 /pro/local/bin/git-send-pack
 86616 -rwxrwxrwx 1 merijn softwr    2960 Dec  4 15:22 /pro/local/bin/git-sh-setup
 86372 -rwxrwxrwx 1 merijn softwr  319348 Dec  4 15:22 /pro/local/bin/git-shell
 86375 -rwxrwxrwx 1 merijn softwr  323444 Dec  4 15:22 /pro/local/bin/git-show-index
 86376 -rwxrwxrwx 1 merijn softwr  335732 Dec  4 15:22 /pro/local/bin/git-ssh-fetch
 86392 -rwxrwxrwx 1 merijn softwr  335732 Dec  4 15:22 /pro/local/bin/git-ssh-pull
 86414 -rwxrwxrwx 1 merijn softwr  327540 Dec  4 15:22 /pro/local/bin/git-ssh-push
 86379 -rwxrwxrwx 1 merijn softwr  327540 Dec  4 15:22 /pro/local/bin/git-ssh-upload
 86749 -rwxrwxrwx 1 merijn softwr    4613 Dec  4 15:22 /pro/local/bin/git-stash
 87098 -rwxrwxrwx 1 merijn softwr   14693 Dec  4 15:22 /pro/local/bin/git-status
 86697 -rwxrwxrwx 1 merijn softwr    6388 Dec  4 15:22 /pro/local/bin/git-submodule
 87097 -rwxrwxrwx 1 merijn softwr  119623 Dec  4 15:22 /pro/local/bin/git-svn
 87085 -rwxrwxrwx 1 merijn softwr   24869 Dec  4 15:22 /pro/local/bin/git-svnimport
 86381 -rwxrwxrwx 1 merijn softwr  319348 Dec  4 15:22 /pro/local/bin/git-unpack-file
 86382 -rwxrwxrwx 1 merijn softwr  327540 Dec  4 15:22 /pro/local/bin/git-update-server-info
 86386 -rwxrwxrwx 1 merijn softwr  487284 Dec  4 15:22 /pro/local/bin/git-upload-pack
 86388 -rwxrwxrwx 1 merijn softwr  319348 Dec  4 15:22 /pro/local/bin/git-var


> to find out what made it 

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
