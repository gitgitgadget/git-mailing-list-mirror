From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 08:38:43 +0100
Message-ID: <20071218083843.42d7a15e@pc09.procura.nl>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
	<m3tzmgpzlu.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 08:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4X2o-0004wp-8N
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 08:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbXLRHiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 02:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbXLRHiv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 02:38:51 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:4807 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbXLRHiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 02:38:50 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBI7cjLI088135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 08:38:45 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <m3tzmgpzlu.fsf@roke.D-201>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68706>

On Mon, 17 Dec 2007 17:21:08 -0800 (PST), Jakub Narebski <jnareb@gmail.com>
wrote:

> Andy Dougherty <doughera@lafayette.edu> writes:
> 
> > [...].  Perhaps configure
> > should just go looking for a suitable install program instead of
> > assuming everyone has one.
> 
> First, configure is, and (I think) consensus is that it should remain
> optional.  This means that Makefile "guess" section should have good
> defaults for your operating system.

And what if you OS *does* have an install, but one that is completely
useless^Wdifferent from the GNU install? Like the utterly useless
install on HP-UX.

> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
> there is BSD-compatible `install' program (as 'install-sh' or
> 'install.sh') in the sources.  Adding such script is (I think) not a
> problem;

Yeah!

> finding minimal portable[*1*] script is.  So if you know one...
> 
> Footnotes:
> ----------
> [*1*] By "portable" I mean here 'git portable', i.e. requiring only
> those shell constructs/features that git require, not necessary
> insanelt portable the way ./configure script is.

Something like this? (gui part still missing). This is what I now
use

--8<--- make-install
#!/bin/sh

PREFIX=/pro/local
BINDIR=$PREFIX/bin
SHARED=$PREFIX/share

for p in git-fetch-pack git-hash-object git-index-pack git-fast-import \
	 git-daemon git-merge-index git-mktag git-mktree git-patch-id \
	 git-receive-pack git-send-pack git-shell git-show-index \
	 git-unpack-file git-update-server-info git-upload-pack \
	 git-pack-redundant git-var git-merge-tree git-imap-send \
	 git-merge-recursive  git-bisect git-checkout git-clone \
	 git-merge-one-file git-mergetool git-parse-remote git-pull \
	 git-rebase git-rebase--interactive git-repack git-request-pull \
	 git-sh-setup git-am git-merge git-merge-stupid git-merge-octopus \
	 git-merge-resolve git-lost-found git-quiltimport git-submodule \
	 git-filter-branch git-stash git-add--interactive git-archimport \
	 git-cvsimport git-relink git-cvsserver git-remote git-cvsexportcommit \
	 git-send-email git-svn git-instaweb git-merge-subtree ; do
    rm -f $BINDIR/$p
    cp $p $BINDIR
    chmod 755 $BINDIR/$p
    done

cp git $BINDIR
cd templates
rm -rf $SHARED/git-core
mkdir  $SHARED/git-core
mkdir  $SHARED/git-core/templates
(cd blt && tar cf - .) | (cd $SHARED/git-core/templates/ && tar xf -)
cd ..
cd perl
make
make install UNINST=1
cd ..

for p in git-format-patch git-show git-whatchanged git-cherry \
	 git-get-tar-commit-id git-init git-repo-config git-fsck-objects \
	 git-cherry-pick git-peek-remote git-status git-add git-annotate \
	 git-apply git-archive git-blame git-branch git-bundle git-cat-file \
	 git-check-attr git-checkout-index git-check-ref-format git-clean \
	 git-commit git-commit-tree git-count-objects git-describe git-diff \
	 git-diff-files git-diff-index git-diff-tree git-fast-export \
	 git-fetch git-fetch-pack git-fetch--tool git-fmt-merge-msg \
	 git-for-each-ref git-fsck git-gc git-grep git-init-db git-log \
	 git-ls-files git-ls-tree git-ls-remote git-mailinfo git-mailsplit \
	 git-merge-base git-merge-file git-merge-ours git-mv git-name-rev \
	 git-pack-objects git-prune git-prune-packed git-push git-read-tree \
	 git-reflog git-send-pack git-config git-rerere git-reset \
	 git-rev-list git-rev-parse git-revert git-rm git-shortlog \
	 git-show-branch git-stripspace git-symbolic-ref git-tag git-tar-tree \
	 git-unpack-objects git-update-index git-update-ref \
	 git-upload-archive git-verify-pack git-verify-tag git-write-tree \
	 git-show-ref git-pack-refs ; do
    rm -f $BINDIR/$p
    ln $BINDIR/git $BINDIR/$p
    done
-->8---

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
