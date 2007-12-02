From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Sun, 2 Dec 2007 16:02:07 +0100
Message-ID: <FFEBE8BB-E764-4DD0-A7DC-8CC01659D9BC@wincent.com>
References: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home> <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se> <20071130150948.GA22095@coredump.intra.peff.net> <7vve7jqz92.fsf@gitster.siamese.dyndns.org> <20071130212500.GB25946@coredump.intra.peff.net> <Pine.LNX.4.64.0711302306580.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 16:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyqM0-0005Al-IR
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 16:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbXLBPDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 10:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbXLBPDJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 10:03:09 -0500
Received: from wincent.com ([72.3.236.74]:57888 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503AbXLBPDI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 10:03:08 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB2F29Co002217;
	Sun, 2 Dec 2007 09:02:10 -0600
In-Reply-To: <Pine.LNX.4.64.0711302306580.27959@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66783>

El 1/12/2007, a las 0:10, Johannes Schindelin escribi=F3:

> To me, it is mighty annoying anybody brings up that "144 commands"
> argument Linus was referring to, and if there is _any_ way to shut up
> those bikeshedders, I am all for it.

This is not a bikeshed argument and it is not an "idiotic =20
complaint" (to use Linus' phrase). It is a legitimate concern and a =20
*real* UI problem.

You and Linus don't care that there are 140+ Git commands and I =20
imagine that you know exactly what each of them does.

I don't really care either because although I don't know what every =20
single command does, I know what the 20 or 30 commands I personally =20
need for my own workflow do.

The problem is for *newcomers* to Git who sit down for the first time =20
and ask themselves, "Now, how do I...?". This is not an idiotic =20
complaint but a legitimate concern about a real UI problem.

Honestly, Johannes, do you think the following is a good UI?

$ git
Display all 148 possibilities? (y or n)
git*                     git-cvsimport*           git-local-=20
fetch*         git-peek-remote*         git-show-index*
git-add*                 git-cvsserver*           git-=20
log*                 git-prune*               git-show-ref*
git-add--interactive*    git-daemon*              git-lost-=20
found*          git-prune-packed*        git-ssh-fetch*
git-am*                  git-describe*            git-ls-=20
files*            git-pull*                git-ssh-pull*
git-annotate*            git-diff*                git-ls-=20
remote*           git-push*                git-ssh-push*
git-apply*               git-diff-files*          git-ls-=20
tree*             git-quiltimport*         git-ssh-upload*
git-applymbox            git-diff-index*          git-=20
mailinfo*            git-read-tree*           git-stash*
git-applypatch           git-diff-tree*           git-=20
mailsplit*           git-rebase*              git-status*
git-archimport*          git-fast-import*         git-=20
merge*               git-rebase--interactive* git-stripspace*
git-archive*             git-fetch*               git-merge-=20
base*          git-receive-pack*        git-submodule*
git-bisect*              git-fetch--tool*         git-merge-=20
file*          git-reflog*              git-svn*
git-blame*               git-fetch-pack*          git-merge-=20
index*         git-relink*              git-svnimport
git-branch*              git-filter-branch*       git-merge-=20
octopus*       git-remote*              git-symbolic-ref*
git-bundle*              git-fmt-merge-msg*       git-merge-one-=20
file*      git-repack*              git-tag*
git-cat-file*            git-for-each-ref*        git-merge-=20
ours*          git-repo-config*         git-tar-tree*
git-check-attr*          git-format-patch*        git-merge-=20
recursive*     git-request-pull*        git-unpack-file*
git-check-ref-format*    git-fsck*                git-merge-=20
resolve*       git-rerere*              git-unpack-objects*
git-checkout*            git-fsck-objects*        git-merge-=20
stupid*        git-reset*               git-update-index*
git-checkout-index*      git-gc*                  git-merge-=20
subtree*       git-rev-list*            git-update-ref*
git-cherry*              git-get-tar-commit-id*   git-merge-=20
tree*          git-rev-parse*           git-update-server-info*
git-cherry-pick*         git-grep*                git-=20
mergetool*           git-revert*              git-upload-archive*
git-citool               git-gui/                 git-=20
mktag*               git-rm*                  git-upload-pack*
git-clean*               git-hash-object*         git-=20
mktree*              git-runstatus*           git-var*
git-clone*               git-http-fetch*          git-=20
mv*                  git-send-email*          git-verify-pack*
git-commit*              git-http-push*           git-name-=20
rev*            git-send-pack*           git-verify-tag*
git-commit-tree*         git-imap-send*           git-pack-=20
objects*        git-sh-setup*            git-whatchanged*
git-config*              git-index-pack*          git-pack-=20
redundant*      git-shell*               git-write-tree*
git-convert-objects      git-init*                git-pack-=20
refs*           git-shortlog*            gitk
git-count-objects*       git-init-db*             git-parse-=20
remote*        git-show*
git-cvsexportcommit*     git-instaweb*            git-patch-=20
id*            git-show-branch*

Would you argue that this screenshot shows a sane UI?

<http://wincent.com/tmp/git-ui.png>

Note: I am not complaining about the *number* of commands; I myself =20
find them highly useful for scripting. I am saying that the =20
*visibility* of those commands is the problem. That's why I support =20
the efforts to move most of this stuff out of the default PATH. We're =20
not talking about getting rid of it, just about putting it somewhere =20
more appropriate in order to correct what is basically a *hideous* =20
user interface for the beginner.

Cheers,
Wincent
