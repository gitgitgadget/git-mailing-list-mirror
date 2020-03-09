Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF97DC10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 12:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BA208C3
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 12:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCIMKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:10:10 -0400
Received: from mta-07-4.privateemail.com ([68.65.122.27]:6504 "EHLO
        MTA-07-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIMKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 08:10:10 -0400
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id 3002F60034;
        Mon,  9 Mar 2020 08:10:09 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.246])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id 23F5260049;
        Mon,  9 Mar 2020 12:10:07 +0000 (UTC)
From:   "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Subject: [RFC PATCH v2 0/2] git-merge: update default commit message
Date:   Mon,  9 Mar 2020 15:07:20 +0300
Message-Id: <20200309120722.4987-1-darktemplar@dark-templar-archives.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <2f0417b3-9e9e-f0db-ab11-92dd7cd2b29a@dark-templar-archives.net>
References: <2f0417b3-9e9e-f0db-ab11-92dd7cd2b29a@dark-templar-archives.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches updates default commit message for git-merge command.

First patch adds alternative commit message formatting where
each merged object is printed on new line
and adds configuration option to enable new message formatting
when specified number of merged commits is detected.

This feature is turned off by default in first patch.
Second patch is optional and enables new behaviour
when at least two additional commits are merged.

i.Dark_Templar (2):
  git-merge: add option to format default message using multiple lines
  Enable multiline merge commit message by default

 Documentation/config/fmt-merge-msg.txt |   9 ++
 builtin/fmt-merge-msg.c                | 115 ++++++++++++++++++++++++-
 2 files changed, 122 insertions(+), 2 deletions(-)

--
2.24.1

