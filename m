From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 01 May 2015 16:51:14 +0200
Message-ID: <554392E2.8000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 16:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCHk-0001NB-IA
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 16:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbbEAOvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 10:51:20 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34025 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbbEAOvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 10:51:18 -0400
Received: by wgso17 with SMTP id o17so92832600wgs.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=7Ch3dI0GPOn1BFbuf9uVNCVXFj0YDIxg9BUM2d4DX7I=;
        b=uwRJd7XOnEDG3yFYlqrRs3MPt+TGT1WkwJvfASxwDUHSbONrF2pcHwVzLwXxGbHAwa
         zC4TEAzEJxmzW7ygeVTfx5Vsf/gcVNNe7fWkAGpazPWhAFhDCg+0hDryDG7DZhBFvjW8
         y7CebsC7OZJUQ5INLRLkAlRhW4tzr8dRUzKVeV7DwlpIzSU99JWJCZFHsdICH0ZeF7br
         OGqrytMzcbb8NiF2GDFHOHdiYjYoDN/wZJF3hYXHenevUTC52ZydpE1jhAhTVrjNvd7g
         skemTi4o2Jkle6drU9ZfdHgDPQQpBWWvjCFg/t/kJHjaJi3sN5nkkeAC0Z6/DYyrtyTs
         CuVA==
X-Received: by 10.180.7.133 with SMTP id j5mr15236748wia.84.1430491876959;
        Fri, 01 May 2015 07:51:16 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id v20sm7848631wjr.49.2015.05.01.07.51.15
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 07:51:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268136>

Hello everyone,

This is my first contribution to an open source project.

I tackled the issue found here:
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#improve_.22git=
_help.22

Namely, format the output of 'git help' so that
the commands are grouped by theme.

Author: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
Date:   Fri May 1 15:48:57 2015 +0200

     command-list.txt - added command groups to common commands

     groups are in the form: 'x_group',
     where x is a number used to order (ascending)
     commands in the displayed help.

     example:  git-add        mainporcelain common-2_worktree

diff --git a/command-list.txt b/command-list.txt
index f1eae08..b0730a2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,29 +1,29 @@
  # List of known git commands.
  # command name                category [deprecated] [common]
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
@@ -35,14 +35,14 @@ git-cvsimport foreignscminterface
  git-cvsserver                           foreignscminterface
  git-daemon                              synchingrepositories
  git-describe                            mainporcelain
-git-diff                                mainporcelain common
+git-diff                                mainporcelain common-5_history
  git-diff-files                          plumbinginterrogators
  git-diff-index                          plumbinginterrogators
  git-diff-tree                           plumbinginterrogators
  git-difftool                            ancillaryinterrogators
  git-fast-export                ancillarymanipulators
  git-fast-import                ancillarymanipulators
-git-fetch                               mainporcelain common
+git-fetch                               mainporcelain common-4_remote
  git-fetch-pack                          synchingrepositories
  git-filter-branch                       ancillarymanipulators
  git-fmt-merge-msg                       purehelpers
@@ -51,7 +51,7 @@ git-format-patch mainporcelain
  git-fsck                            ancillaryinterrogators
  git-gc                                  mainporcelain
  git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain common
+git-grep                                mainporcelain common-7_search
  git-gui                                 mainporcelain
  git-hash-object                         plumbingmanipulators
  git-help                ancillaryinterrogators
@@ -60,17 +60,17 @@ git-http-fetch synchelpers
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
@@ -79,7 +79,7 @@ git-mergetool ancillarymanipulators
  git-merge-tree                          ancillaryinterrogators
  git-mktag                               plumbingmanipulators
  git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain common
+git-mv                                  mainporcelain common-3_worktre=
e
  git-name-rev                            plumbinginterrogators
  git-notes                               mainporcelain
  git-p4                                  foreignscminterface
@@ -90,11 +90,11 @@ git-parse-remote synchelpers
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
@@ -103,28 +103,28 @@ git-repack ancillarymanipulators
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
