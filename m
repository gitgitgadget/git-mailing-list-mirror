Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0EF1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 23:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfKBXuM (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 19:50:12 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42933 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfKBXuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 19:50:12 -0400
X-Originating-IP: 1.186.12.57
Received: from localhost (unknown [1.186.12.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 55BCFC0004;
        Sat,  2 Nov 2019 23:50:08 +0000 (UTC)
Date:   Sun, 3 Nov 2019 05:20:07 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request
Message-ID: <20191102235006.rpguewvbbpfv4wi5@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

There are some changes in git-gui since your last pull. With the 2.24
release coming up, I figure it is a good time to sync up.

The list of changes is a bit misleading. A lot of these changes are 
already in Git's tree, and I retroactively pulled them back in my tree, 
since these bypassed the "main" git-gui tree. Effectively, the merge of 
the commit 60c60b6 should be a no-op. [0] for a reminder.

Sorry for being so late. I didn't realize the release was so close. So
if this pull request is too much trouble for 2.24, I'm fine if you don't 
pull it now. We can sync up in 2.25 :).

[0] https://public-inbox.org/git/CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com/

---
The following changes since commit f7a8834ba4aa20ec750833cf8d30d9a9fed5eade:

  Merge branch 'bp/amend-toggle-bind' (2019-09-14 23:23:12 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git

for you to fetch changes up to b524f6b399c77b40c8bf2b6217585fde4731472a:

  Merge branch 'ka/japanese-translation' (2019-10-14 23:22:50 +0530)

----------------------------------------------------------------
Anders Kaseorg (1):
      git-gui: sort entries in optimized tclIndex

Beat Bolli (1):
      git-gui: search for all current SSH key types

Bert Wesarg (2):
      git-gui: use existing interface to query a path's attribute
      git-gui: support for diff3 conflict style

Birger Skogeng Pedersen (1):
      git-gui: bind CTRL/CMD+numpad ENTER to do_commit

Clemens Buchacher (1):
      git-gui: workaround ttk:style theme use

Johannes Schindelin (6):
      git-gui (MinGW): make use of MSys2's msgfmt
      git gui: fix staging a second line to a 1-line file
      git-gui: avoid exception upon Ctrl+T in an empty list
      git-gui: fix exception when trying to stage with empty file list
      git-gui: allow Ctrl+T to toggle multiple paths
      Fix build with core.autocrlf=true

Martin Ågren (1):
      treewide: correct several "up-to-date" to "up to date"

Pratyush Yadav (8):
      git-gui: call do_quit before destroying the main window
      Merge branches 'js/msgfmt-on-windows', 'tz/fsf-address-update', 'jn/reproducible-build', 'ls/no-double-utf8-author-name', 'js/misc-git-gui-stuff', 'bb/ssh-key-files', 'bp/bind-kp-enter', 'cb/ttk-style' and 'py/call-do-quit-before-exit' of ../git into py/git-git-extra-stuff
      Merge branch 'py/git-git-extra-stuff'
      Merge branch 'js/git-bash-if-available'
      Merge branch 'bw/diff3-conflict-style'
      git-gui: add a readme
      Merge branch 'py/readme'
      Merge branch 'ka/japanese-translation'

Thomas Klaeger (1):
      git-gui (Windows): use git-bash.exe if it is available

Todd Zullinger (1):
      Replace Free Software Foundation address in license notices

kdnakt (1):
      git-gui: improve Japanese translation

Łukasz Stelmach (1):
      git-gui: prevent double UTF-8 conversion

 .gitattributes |   1 +
 Makefile       |   4 +-
 README.md      | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-gui.sh     |  65 ++++++++++++++++++---
 lib/commit.tcl |  12 +++-
 lib/diff.tcl   |  34 ++++++-----
 lib/sshkey.tcl |   5 +-
 lib/themed.tcl |  15 +++--
 po/README      |   2 +-
 po/ja.po       |   9 +--
 10 files changed, 284 insertions(+), 37 deletions(-)
 create mode 100644 README.md

-- 
Regards,
Pratyush Yadav
