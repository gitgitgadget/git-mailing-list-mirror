From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v3 1/4] command-list.txt: group common commands by themes
Date: Sun, 03 May 2015 02:21:05 +0200
Message-ID: <554569F1.4020108@gmail.com>
References: <554405D5.9080702@gmail.com> <55456990.6000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 02:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yohem-0007L4-AJ
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 02:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbbECAVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2015 20:21:12 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34025 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbECAVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 20:21:10 -0400
Received: by wgso17 with SMTP id o17so119780731wgs.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=t7yFca6c5zR7mBqeeWxhRLcbI9vJhDDJkcOg6et4s3E=;
        b=hTDlzSnRW2arJdccSKaSShCO+tcMDcPprATQ2maVOSvfYCaxxyJNNlt8d6BnOeRO+v
         0qTmniLO82NCfBdZt9aXBLWwSeBlC2Dlt7+mu2FOv8GJiI7NmrbuXKcOhRZOd0pQQQ4G
         5Cgxn0ueaPfBzNSOuVcv/JdVAaso1qjs3Qd3S3Hkc2ZrGQuSzazVkirVF8JwM5epowSF
         ooOzBmeteWMY61bxzFuLYYkI+E15LxnxFfy+lrA3GSlDGJ8cf/cED6bwTR1sXM14yCIz
         jlIrGNWI1NzhGZR8QEBOb4OfZQZ4iGsksr4AxfkFjoKfQSaLH51SNE2tqeH+MYxh360/
         l7QA==
X-Received: by 10.180.90.236 with SMTP id bz12mr7975764wib.33.1430612468936;
        Sat, 02 May 2015 17:21:08 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id gs7sm4389689wib.10.2015.05.02.17.21.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2015 17:21:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <55456990.6000509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268242>

Add a group identifier in the form {x}_{name}, where {x} is a digit
identifying the group, and {name} the group name. The digit is used
to sort the common commands by groups instead of the less useful
alphabetical order.

before the patch:
git-add			mainporcelain common

after:
git-add			mainporcelain common-3_worktree

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
  command-list.txt | 42 +++++++++++++++++++++---------------------
  1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index f1eae08..b0730a2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,29 +1,29 @@
  # List of known git commands.
  # command name				category [deprecated] [common]
-git-add                                 mainporcelain common
+git-add                                 mainporcelain common-3_worktre=
e
  git-am                                  mainporcelain
  git-annotate                            ancillaryinterrogators
  git-apply                               plumbingmanipulators
  git-archimport                          foreignscminterface
  git-archive                             mainporcelain
-git-bisect                              mainporcelain common
+git-bisect                              mainporcelain common-7_search
  git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain common
+git-branch                              mainporcelain common-6_branchi=
ng
  git-bundle                              mainporcelain
  git-cat-file                            plumbinginterrogators
  git-check-attr                          purehelpers
  git-check-ignore                        purehelpers
  git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain common
+git-checkout                            mainporcelain common-6_branchi=
ng
  git-checkout-index                      plumbingmanipulators
  git-check-ref-format                    purehelpers
  git-cherry                              ancillaryinterrogators
  git-cherry-pick                         mainporcelain
  git-citool                              mainporcelain
  git-clean                               mainporcelain
-git-clone                               mainporcelain common
+git-clone                               mainporcelain common-1_init
  git-column                              purehelpers
-git-commit                              mainporcelain common
+git-commit                              mainporcelain common-5_history
  git-commit-tree                         plumbingmanipulators
  git-config                              ancillarymanipulators
  git-count-objects                       ancillaryinterrogators
@@ -35,14 +35,14 @@ git-cvsimport                           foreignscmi=
nterface
  git-cvsserver                           foreignscminterface
  git-daemon                              synchingrepositories
  git-describe                            mainporcelain
-git-diff                                mainporcelain common
+git-diff                                mainporcelain common-5_history
  git-diff-files                          plumbinginterrogators
  git-diff-index                          plumbinginterrogators
  git-diff-tree                           plumbinginterrogators
  git-difftool                            ancillaryinterrogators
  git-fast-export				ancillarymanipulators
  git-fast-import				ancillarymanipulators
-git-fetch                               mainporcelain common
+git-fetch                               mainporcelain common-4_remote
  git-fetch-pack                          synchingrepositories
  git-filter-branch                       ancillarymanipulators
  git-fmt-merge-msg                       purehelpers
@@ -51,7 +51,7 @@ git-format-patch                        mainporcelain
  git-fsck	                        ancillaryinterrogators
  git-gc                                  mainporcelain
  git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain common
+git-grep                                mainporcelain common-7_search
  git-gui                                 mainporcelain
  git-hash-object                         plumbingmanipulators
  git-help				ancillaryinterrogators
@@ -60,17 +60,17 @@ git-http-fetch                          synchelpers
  git-http-push                           synchelpers
  git-imap-send                           foreignscminterface
  git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain common
+git-init                                mainporcelain common-1_init
  git-instaweb                            ancillaryinterrogators
  git-interpret-trailers                  purehelpers
  gitk                                    mainporcelain
-git-log                                 mainporcelain common
+git-log                                 mainporcelain common-2_info
  git-ls-files                            plumbinginterrogators
  git-ls-remote                           plumbinginterrogators
  git-ls-tree                             plumbinginterrogators
  git-mailinfo                            purehelpers
  git-mailsplit                           purehelpers
-git-merge                               mainporcelain common
+git-merge                               mainporcelain common-6_branchi=
ng
  git-merge-base                          plumbinginterrogators
  git-merge-file                          plumbingmanipulators
  git-merge-index                         plumbingmanipulators
@@ -79,7 +79,7 @@ git-mergetool                           ancillarymani=
pulators
  git-merge-tree                          ancillaryinterrogators
  git-mktag                               plumbingmanipulators
  git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain common
+git-mv                                  mainporcelain common-3_worktre=
e
  git-name-rev                            plumbinginterrogators
  git-notes                               mainporcelain
  git-p4                                  foreignscminterface
@@ -90,11 +90,11 @@ git-parse-remote                        synchelpers
  git-patch-id                            purehelpers
  git-prune                               ancillarymanipulators
  git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain common
-git-push                                mainporcelain common
+git-pull                                mainporcelain common-4_remote
+git-push                                mainporcelain common-4_remote
  git-quiltimport                         foreignscminterface
  git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain common
+git-rebase                              mainporcelain common-5_history
  git-receive-pack                        synchelpers
  git-reflog                              ancillarymanipulators
  git-relink                              ancillarymanipulators
@@ -103,28 +103,28 @@ git-repack                              ancillary=
manipulators
  git-replace                             ancillarymanipulators
  git-request-pull                        foreignscminterface
  git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain common
+git-reset                               mainporcelain common-3_worktre=
e
  git-revert                              mainporcelain
  git-rev-list                            plumbinginterrogators
  git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain common
+git-rm                                  mainporcelain common-3_worktre=
e
  git-send-email                          foreignscminterface
  git-send-pack                           synchingrepositories
  git-shell                               synchelpers
  git-shortlog                            mainporcelain
-git-show                                mainporcelain common
+git-show                                mainporcelain common-2_info
  git-show-branch                         ancillaryinterrogators
  git-show-index                          plumbinginterrogators
  git-show-ref                            plumbinginterrogators
  git-sh-i18n                             purehelpers
  git-sh-setup                            purehelpers
  git-stash                               mainporcelain
-git-status                              mainporcelain common
+git-status                              mainporcelain common-2_info
  git-stripspace                          purehelpers
  git-submodule                           mainporcelain
  git-svn                                 foreignscminterface
  git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain common
+git-tag                                 mainporcelain common-5_history
  git-unpack-file                         plumbinginterrogators
  git-unpack-objects                      plumbingmanipulators
  git-update-index                        plumbingmanipulators
--=20
2.4.0
