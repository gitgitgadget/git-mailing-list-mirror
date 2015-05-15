From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v7 4/5] command-list.txt: drop the common tag
Date: Fri, 15 May 2015 20:35:03 +0200
Message-ID: <1431714904-16599-5-git-send-email-sebastien.guimmara@gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri May 15 20:39:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtKWb-0005GS-Le
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933905AbbEOSjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 14:39:53 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36371 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933913AbbEOSfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:35:22 -0400
Received: by wgbhc8 with SMTP id hc8so89475487wgb.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Rd3fTXBcRmWnLqXnO9mnw88VZdVNkdHGV38NK9KCOus=;
        b=qG9xzFEBCd4MOG/89bIRIc79i9foTSOTy1vA9LH15ifHEkzb+p6poVQiCCYd1HaAMy
         8TCQxcUM7HCy7mxU7rDNVjZWJcqn4Yovdq1EyeVIPjeJa219KzWsVoBwqFv81Z7NIGyZ
         rsQaYYzYEhtffGk+bLAfsXr08PLE4F351dvdbjw/xXisbg7C1Fm6gajh4y1pcfxpxLmo
         NMsvjJOknhzzRYLfCi1hwdaQe2/1JpfA4xJm6rVGMs6AKHIEjgp1AU+IpEudN92thbwD
         kyOs9Axl2HEBm3Y/DrYzFX+lYA4pCceg1MS3bp0tMsxAXcc5Iy+JKE+yoo+RyRv1jxUl
         tEkQ==
X-Received: by 10.180.218.108 with SMTP id pf12mr62133483wic.13.1431714921019;
        Fri, 15 May 2015 11:35:21 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id j12sm3674972wjn.48.2015.05.15.11.35.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 May 2015 11:35:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269173>

The parser generate-cmdlist.awk gathers all group information without
needing the common tag.

before:
    git-add          mainporcelain        common worktree

after:
    git-add          mainporcelain        worktree

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 command-list.txt | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index c00b0b6..2203566 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -11,30 +11,30 @@ remote       collaborate (see also: git help workfl=
ows)
 # List of known git commands.
 # command name                          category [deprecated] [common]
 [commands]
-git-add                                 mainporcelain           common=
 worktree
+git-add                                 mainporcelain           worktr=
ee
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
-git-bisect                              mainporcelain           common=
 info
+git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain           common=
 history
+git-branch                              mainporcelain           histor=
y
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain           common=
 history
+git-checkout                            mainporcelain           histor=
y
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
-git-clone                               mainporcelain           common=
 init
+git-clone                               mainporcelain           init
 git-column                              purehelpers
-git-commit                              mainporcelain           common=
 history
+git-commit                              mainporcelain           histor=
y
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
@@ -46,14 +46,14 @@ git-cvsimport                           foreignscmi=
nterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
-git-diff                                mainporcelain           common=
 history
+git-diff                                mainporcelain           histor=
y
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
-git-fetch                               mainporcelain           common=
 remote
+git-fetch                               mainporcelain           remote
 git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
@@ -62,7 +62,7 @@ git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain           common=
 info
+git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators
@@ -71,17 +71,17 @@ git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain           common=
 init
+git-init                                mainporcelain           init
 git-instaweb                            ancillaryinterrogators
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
-git-log                                 mainporcelain           common=
 info
+git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
-git-merge                               mainporcelain           common=
 history
+git-merge                               mainporcelain           histor=
y
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
@@ -90,7 +90,7 @@ git-mergetool                           ancillarymani=
pulators
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain           common=
 worktree
+git-mv                                  mainporcelain           worktr=
ee
 git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
@@ -101,11 +101,11 @@ git-parse-remote                        synchelpe=
rs
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain           common=
 remote
-git-push                                mainporcelain           common=
 remote
+git-pull                                mainporcelain           remote
+git-push                                mainporcelain           remote
 git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain           common=
 history
+git-rebase                              mainporcelain           histor=
y
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
@@ -114,28 +114,28 @@ git-repack                              ancillary=
manipulators
 git-replace                             ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain           common=
 worktree
+git-reset                               mainporcelain           worktr=
ee
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain           common=
 worktree
+git-rm                                  mainporcelain           worktr=
ee
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
-git-show                                mainporcelain           common=
 info
+git-show                                mainporcelain           info
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
-git-status                              mainporcelain           common=
 info
+git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain           common=
 history
+git-tag                                 mainporcelain           histor=
y
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
--=20
2.4.0
