Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE41C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E39207DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGJIr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:47:58 -0400
Received: from smtp01.domein-it.com ([92.48.232.134]:32837 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgGJIr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 04:47:58 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 4DF0E808699C; Fri, 10 Jul 2020 10:47:57 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id F15398086D07;
        Fri, 10 Jul 2020 10:47:39 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:49138 helo=ben.dynamic.ziggo.nl)
        by ferret.domein-it.nl with esmtpa (Exim 4.93)
        (envelope-from <ben@wijen.net>)
        id 1jtogv-0007Kb-O1; Fri, 10 Jul 2020 10:47:33 +0200
From:   Ben Wijen <ben@wijen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Ben Wijen <ben@wijen.net>
Subject: [PATCH v3 0/1] git clone: don't clone into non-empty directory
Date:   Fri, 10 Jul 2020 10:47:31 +0200
Message-Id: <20200710084732.5152-1-ben@wijen.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <xmqqv9j08dxo.fsf@gitster.c.googlers.com>
References: <xmqqv9j08dxo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1jtogv-0007Kb-O1
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I added a small note to the commit message.
Please let me know if you require more.

Thank you,


Ben Wijen (1):
  git clone: don't clone into non-empty directory

 builtin/clone.c  | 12 ++++++++++--
 t/t5601-clone.sh |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.27.0

