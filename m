From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v11 4/5] command-list.txt: drop the "common" tag
Date: Thu, 21 May 2015 19:39:21 +0200
Message-ID: <1432229962-21405-5-git-send-email-sebastien.guimmara@gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 19:40:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUSb-0000Z9-Ln
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbbEURkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 13:40:41 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36174 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbbEURkc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:40:32 -0400
Received: by wizk4 with SMTP id k4so22939868wiz.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AxN51BmkNYOZLUww6u5nMn5wSz109NslpXexUTp3NQs=;
        b=OiCuTGZDxSrbCzE9TutA4sj7PDWwR8k0upPAnBAIb7PPPXMxdQgPlKE8ELTbxbA1dG
         X+yds2QFP21qoRMwU6iTpaRo/vPsk8H7IT9hKf0mgKNcyaLeZCl1wC+UUQni4Mq3h4/S
         s+lYZfvJzU82xMwN/KQ8WfbTU5BQ4r3WuaP5UVjzGufu//RodNAKT9VPAlhpl8Unx0Zy
         VAf0SGbarEQXvUSdKFvfeySrFPMC0n0YYxxXk10MeVWhDQxNwWuxfV8YAlrZWwgfmWys
         g87E+IGC8PDkMzumniaZtK2zFrKpMazZ6p+upPbjvp3gA25tMlyxH+NzDgutQFnLbyp3
         swnw==
X-Received: by 10.180.208.7 with SMTP id ma7mr9250257wic.0.1432230031514;
        Thu, 21 May 2015 10:40:31 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id v3sm3660231wix.8.2015.05.21.10.40.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 10:40:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269624>

command-list.sh, retired in the previous patch, was the only
consumer of the "common" tag, so drop this now-unnecessary
attribute.

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
index 32ddab3..9a98752 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -11,30 +11,30 @@ remote       collaborate (see also: git help workfl=
ows)
 # List of known git commands.
 ### command list (do not change this line)
 # command name                          category [deprecated] [common]
-git-add                                 mainporcelain common
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
2.4.0.GIT
