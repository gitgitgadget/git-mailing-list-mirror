From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 4/5] command-list.txt: drop the common- prefix
Date: Thu, 14 May 2015 14:59:09 +0200
Message-ID: <1431608351-9413-5-git-send-email-sebastien.guimmara@gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 14 15:00:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsskY-0007Na-IL
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbbENNAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 09:00:13 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33183 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964812AbbENNAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 09:00:10 -0400
Received: by wgin8 with SMTP id n8so74754643wgi.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uKwBDqbrv7fmhIitHdKI048Slez+paXycggYXI7i2QI=;
        b=BBaHARamUw+MQWq3cQpFOOTogf/2lj64bKBGhCKYDX476poHjSjMZ8gKHmLcRlSMlZ
         wIhUXRJ3PowiK+OpExcX4/B4UjkjYsrKVNYSwVSIpS3X6lsRZP9wE4msUQDjnX+uarm+
         hds0q5Ekk9inTGV4LqTSN5cE5HinMsptbf9KbhxebrqfHurlW+RRuDb4ya8+TAEJP0j4
         EW3Atft2ks3WXLyPoKQhB+Obi0tr+zO0i8vbJ5L3bdqhILcsNi5YUfbRo0DTF1cLuLir
         CzxAQhh329DFKECi45nPOKs2TqF+zrtmE7934/hc3e33IODkQSQE5kkP6nYzeioT53ZR
         lpBQ==
X-Received: by 10.180.230.199 with SMTP id ta7mr1841901wic.1.1431608409248;
        Thu, 14 May 2015 06:00:09 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id pj5sm32671676wjb.40.2015.05.14.06.00.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 06:00:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269035>

The parser generate-cmdlist.awk gathers all group information without
needing the common- prefix.

before:
    git-add          mainporcelain        common-worktree

after:
    git-add          mainporcelain        worktree

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 command-list.txt | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 7cb77f0..65e40ee 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -11,30 +11,30 @@ remote       collaborate (see also: git help workfl=
ows)
 # List of known git commands.
 # command name				category [deprecated] [common]
 [commands]
-git-add                                 mainporcelain           common=
-worktree
+git-add                                 mainporcelain           worktr=
ee
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
-git-bisect                              mainporcelain           common=
-info
+git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain           common=
-history
+git-branch                              mainporcelain           histor=
y
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain           common=
-history
+git-checkout                            mainporcelain           histor=
y
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
-git-clone                               mainporcelain           common=
-init
+git-clone                               mainporcelain           init
 git-column                              purehelpers
-git-commit                              mainporcelain           common=
-history
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
-history
+git-diff                                mainporcelain           histor=
y
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators
 git-fast-export				ancillarymanipulators
 git-fast-import				ancillarymanipulators
-git-fetch                               mainporcelain           common=
-remote
+git-fetch                               mainporcelain           remote
 git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
@@ -62,7 +62,7 @@ git-format-patch                        mainporcelain
 git-fsck	                        ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain           common=
-info
+git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help				ancillaryinterrogators
@@ -71,17 +71,17 @@ git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain           common=
-init
+git-init                                mainporcelain           init
 git-instaweb                            ancillaryinterrogators
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
-git-log                                 mainporcelain           common=
-info
+git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
-git-merge                               mainporcelain           common=
-history
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
-worktree
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
-remote
-git-push                                mainporcelain           common=
-remote
+git-pull                                mainporcelain           remote
+git-push                                mainporcelain           remote
 git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain           common=
-history
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
-worktree
+git-reset                               mainporcelain           worktr=
ee
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain           common=
-worktree
+git-rm                                  mainporcelain           worktr=
ee
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
-git-show                                mainporcelain           common=
-info
+git-show                                mainporcelain           info
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
-git-status                              mainporcelain           common=
-info
+git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain           common=
-history
+git-tag                                 mainporcelain           histor=
y
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
--=20
2.4.0
