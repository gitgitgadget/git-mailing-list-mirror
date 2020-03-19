Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52335C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAEC2072C
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCSQPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:15:20 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56423 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgCSQPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:15:20 -0400
X-Originating-IP: 103.227.96.119
Received: from localhost (unknown [103.227.96.119])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C18E520003;
        Thu, 19 Mar 2020 16:15:17 +0000 (UTC)
Date:   Thu, 19 Mar 2020 21:45:15 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request
Message-ID: <20200319161515.ol64anhjoi6r44de@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the changes in git-gui for the Git v2.26.0 release.

Regards,
Pratyush Yadav

---
The following changes since commit 0d2116c6441079a5a1091e4cf152fd9d5fa9811b:

  Merge branch 'zs/open-current-file' (2020-01-05 02:38:03 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git

for you to fetch changes up to a5728022e07c53e5ac91db0960870518e243b7c1:

  Merge branch 'py/remove-tcloo' (2020-03-19 21:29:19 +0530)

----------------------------------------------------------------
Christian Stimming (3):
      git-gui: update pot template and German translation to current source code
      git-gui: extend translation glossary template with more terms
      git-gui: update German translation

Luke Bonanomi (1):
      git-gui--askpass: coerce answers to UTF-8 on Windows

Pratyush Yadav (9):
      Merge branch 'cs/german-translation'
      git-gui: add missing close bracket
      Merge branch 'py/missing-bracket'
      git-gui: fix error popup when doing blame -> "Show History Context"
      Merge branch 'py/blame-status-error'
      Merge branch 'js/askpass-coerce-utf8'
      git-gui: reduce Tcl version requirement from 8.6 to 8.5
      git-gui: create a new namespace for chord script evaluation
      Merge branch 'py/remove-tcloo'

 git-gui--askpass                 |    5 +
 git-gui.sh                       |   14 +-
 lib/chord.tcl                    |   56 +-
 lib/index.tcl                    |   10 +-
 lib/merge.tcl                    |    2 +-
 po/de.po                         | 3622 ++++++++++++++++++++------------------
 po/git-gui.pot                   | 2526 ++++++++++++++------------
 po/glossary/de.po                |  315 +++-
 po/glossary/git-gui-glossary.pot |  250 ++-
 po/glossary/git-gui-glossary.txt |  101 +-
 10 files changed, 3981 insertions(+), 2920 deletions(-)
