Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B08C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 13:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95002078B
	for <git@archiver.kernel.org>; Thu, 21 May 2020 13:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgEUNM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 09:12:27 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34787 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgEUNM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 09:12:26 -0400
Received: from localhost (unknown [42.109.204.137])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 577AB200009;
        Thu, 21 May 2020 13:12:23 +0000 (UTC)
Date:   Thu, 21 May 2020 18:42:20 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request
Message-ID: <20200521131220.t5lhw4e4qp4bpk3s@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the changes in git-gui for Git v2.27.0. Since there was some 
fallout on MacOS last time around, please merge it in -rc2 so the 
changes can get a bit more exposure, even though the changes this time 
around are fairly minimal.

Regards,
Pratyush Yadav

---
The following changes since commit 
a5728022e07c53e5ac91db0960870518e243b7c1:

  Merge branch 'py/remove-tcloo' (2020-03-19 21:29:19 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git 

for you to fetch changes up to c195247812f8cd38ba7e1c603112e6c1d8d8e71e:

  Merge branch 'il/ctrl-bs-del' (2020-05-21 18:25:32 +0530)

----------------------------------------------------------------
Ansgar Röber (1):
      Subject: git-gui: fix syntax error because of missing semicolon

Ismael Luceno (1):
      git-gui: Handle Ctrl + BS/Del in the commit msg

Pratyush Yadav (2):
      Merge branch 'ar/ui-ready-semicolon'
      Merge branch 'il/ctrl-bs-del'

 git-gui.sh        | 6 ++++--
 lib/index.tcl     | 6 +++---
 lib/mergetool.tcl | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)
