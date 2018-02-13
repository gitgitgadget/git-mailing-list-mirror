Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E170D1F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeBMKdJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:33:09 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:2691 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934092AbeBMKc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:32:58 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lXtIeSz2sr5N9lXtPeMEfC; Tue, 13 Feb 2018 10:32:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518517975;
        bh=GCUsTMOlwKgb5dd5TL0zVUTOxuanC78fCsXa5f285Dk=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=klQE2zAMPo5o8S3RCc9FJOoNa1JmUJOyQ5pRppHRVbY4sdzFgDcJ8nEQLlxQoUelV
         8e1UGCZa4BgzvLt63ZKzutKupu8TinQ4ybR7/mh2/QZUiV2LIeAl9rcYsoEeMDlzRd
         eGPcj/0+ytOvYWuEtagGFFVjg8vX93CxTzz3naGY=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=Ez_ekZzLWpTIzk8iKHQA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/3] add -p: improve help messages
Date:   Tue, 13 Feb 2018 10:32:38 +0000
Message-Id: <20180213103241.6789-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBgUUCYateR1eBo11nXP4ysQXF6Xam17Xo7WSz+NYCB6p/cZQ6Z6exk2Pd63NAigVp9kGHxkEp7BaBYpNkZhVq/dpjYT/pS5gzUjb5XrM/CI+c024Apl
 WylB7jEaBBAyGakPSLBekXJ5CsZf2w+fAPbXqINVh44vlgyE57f/NsjyaYT2Afi0DjaC84B8qz+kbFw4yqzMO4vEHAqdncqD9PhhwX5nEfVIwrz3ToQrklSy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Improve the help displayed if the user presses an inactive key by only
listing active keys and printing specific messages for some keys. Also
disable search if there's only a single hunk.

Phillip Wood (3):
  add -p: only display help for active keys
  add -p: Only bind search key if there's more than one hunk
  add -p: improve error messages

 git-add--interactive.perl | 74 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

-- 
2.16.1

