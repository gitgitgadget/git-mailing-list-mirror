Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCF320987
	for <e@80x24.org>; Thu, 20 Oct 2016 11:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbcJTLkH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 20 Oct 2016 07:40:07 -0400
Received: from know-smtprelay-omc-4.server.virginmedia.net ([80.0.253.68]:50000
        "EHLO know-smtprelay-omc-4.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbcJTLkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 07:40:05 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-4-imp with bizsmtp
        id xng21t00S4fw4HN01ng2Jn; Thu, 20 Oct 2016 12:40:02 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=KbMvylsD c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10
 a=CH0kA5CcgfcA:10 a=ZZnuYtJkoWoA:10 a=XaLoG6Yh2RhfHgP-Qn0A:9 a=wPNLvfGTeEIA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id BAD04196F6D4;
        Thu, 20 Oct 2016 12:40:00 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "GitList" <git@vger.kernel.org>
Subject: [REQUEST PULL] git-gui 0.20.0 to 0.21.0
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Thu, 20 Oct 2016 12:39:58 +0100
Message-ID: <878ttji701.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following changes since commit 4498b3a50a0e839788682f672df267cbc1ba9292:

  git-gui: set version 0.20 (2015-04-18 12:15:32 +0100)

are available in the git repository at:

  git://repo.or.cz/git-gui.git tags/gitgui-0.21.0

for you to fetch changes up to ccc985126f23ff5d9ac610cb820bca48405ff5ef:

  git-gui: set version 0.21 (2016-10-20 11:19:43 +0100)

----------------------------------------------------------------
git-gui 0.21.0

----------------------------------------------------------------
Alex Riesen (2):
      git-gui: support for $FILENAMES in tool definitions
      git-gui: ensure the file in the diff pane is in the list of selected files

Alexander Shopov (2):
      git-gui i18n: Updated Bulgarian translation (565,0f,0u)
      git-gui: Mark 'All' in remote.tcl for translation

Dimitriy Ryazantcev (1):
      git-gui: Update Russian translation

Elia Pinto (1):
      git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for command substitution

Johannes Schindelin (1):
      git-gui: respect commit.gpgsign again

Karsten Blees (2):
      git-gui: unicode file name support on windows
      git-gui: handle the encoding of Git's output correctly

Olaf Hering (1):
      git-gui: sort entries in tclIndex

Orgad Shaneh (1):
      git-gui: Do not reset author details on amend

Pat Thoyts (19):
      Allow keyboard control to work in the staging widgets.
      Amend tab ordering and text widget border and highlighting.
      git-gui: fix detection of Cygwin
      git-gui (Windows): use git-gui.exe in `Create Desktop Shortcut`
      Merge branch 'sy/i18n' into pu
      Merge branch 'js/commit-gpgsign' into pu
      Merge branch 'rs/use-modern-git-merge-syntax' into pu
      Merge branch 'va/i18n' into pu
      Merge branch 'patches' into pu
      Merge branch 'pt/git4win-mods' into pu
      Merge branch 'pt/non-mouse-usage' into pu
      Merge branch 'va/i18n_2' into pu
      git-gui: maintain backwards compatibility for merge syntax
      Merge branch 'dr/ru' into pu
      git-gui: avoid persisting modified author identity
      Merge branch 'kb/unicode' into pu
      Merge branch 'os/preserve-author' into pu
      Merge branch 'as/bulgarian' into pu
      git-gui: set version 0.21

René Scharfe (1):
      git-gui: stop using deprecated merge syntax

Satoshi Yasushima (6):
      git-gui: consistently use the same word for "remote" in Japanese
      git-gui: consistently use the same word for "blame" in Japanese
      git-gui: apply po template to Japanese translation
      git-gui: add Japanese language code
      git-gui: update Japanese translation
      git-gui: update Japanese information

Vasco Almeida (6):
      git-gui i18n: mark strings for translation
      git-gui: l10n: add Portuguese translation
      git-gui i18n: internationalize use of colon punctuation
      git-gui i18n: mark "usage:" strings for translation
      git-gui: fix incorrect use of Tcl append command
      git-gui i18n: mark string in lib/error.tcl for translation

yaras (1):
      git-gui: fix initial git gui message encoding

 GIT-VERSION-GEN              |    2 +-
 Makefile                     |    2 +-
 git-gui.sh                   |  154 +-
 lib/blame.tcl                |    2 +-
 lib/branch_checkout.tcl      |    2 +-
 lib/branch_create.tcl        |    2 +-
 lib/branch_delete.tcl        |    4 +-
 lib/branch_rename.tcl        |    2 +-
 lib/browser.tcl              |    6 +-
 lib/commit.tcl               |   39 +-
 lib/database.tcl             |    4 +-
 lib/diff.tcl                 |   14 +-
 lib/error.tcl                |    8 +-
 lib/index.tcl                |   12 +-
 lib/merge.tcl                |   18 +-
 lib/option.tcl               |    8 +-
 lib/remote.tcl               |    8 +-
 lib/remote_add.tcl           |    2 +-
 lib/remote_branch_delete.tcl |    2 +-
 lib/shortcut.tcl             |   17 +-
 lib/themed.tcl               |   87 +-
 lib/tools.tcl                |    3 +
 lib/tools_dlg.tcl            |    6 +-
 lib/transport.tcl            |    2 +-
 po/bg.po                     | 3543 ++++++++++++++++++++++--------------------
 po/glossary/pt_pt.po         |  293 ++++
 po/glossary/txt-to-pot.sh    |    4 +-
 po/ja.po                     | 3077 ++++++++++++++++++------------------
 po/pt_pt.po                  | 2716 ++++++++++++++++++++++++++++++++
 po/ru.po                     |  680 +++-----
 30 files changed, 6957 insertions(+), 3762 deletions(-)
 create mode 100644 po/glossary/pt_pt.po
 create mode 100644 po/pt_pt.po
