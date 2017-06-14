Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9CFF20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbdFNKYu (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:24:50 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:47765 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdFNKYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:24:46 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id L5TSdvCsT9tMzL5TgdjKhE; Wed, 14 Jun 2017 11:24:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497435885; bh=vOI51Pv1z2Pj1FRmIUHRz6/taAspO3r6BcwRFBZmgXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=tdkpqdbGSP8UPpE91XpclvRxQLNrsVp0hPzKSTTPZqtMqeCIEBuBcCutFlWToSavD
         jyJ/XmULP4XC0klntEmNqA8qgsJ8UNo28dnx3nY77W4UCmwJgkeeB4sZfLYKaxqdjy
         tZVN8obgerwtsrRqJ+lBJwbiVC1QnabU+KMPd3zU=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=WdZ7s7TZwzcFYY6_XVMA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
Date:   Wed, 14 Jun 2017 11:24:24 +0100
Message-Id: <20170614102427.5220-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170531104213.16944-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJA2RWSHx9Gg33mQqwBCoqxAd0EPNkKXEb07kz5/y5s6VbblyY8ghMryk9vFMXtfpviK4EQp0uLI9aLpqKaoB9MYFwFy9kcQmdM3UsIr01bZNlHwd7Un
 11I54JZDWQ+CjZIE6cmhwY+7xepGhqj8e9S41U77dfjV8/XHqjjELgHnzD1b9Myqo04LUrR+fUPtfblownmmByY3FtAQ7rW1iHCF79sqU5GhByhITI8HImbs
 /4iT4gbWs3ohDAUEk460LIwdVamFwbq7TL5b7yCwd00jbdT3/UFfSAeiE/ZaLFSwuflQ9qS3n2Zrl5BPU/ZJXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've revised the second two tests as Johannes suggested to drop the
sed script. The first one is unchanged.

Phillip Wood (3):
  rebase -i: Add test for reflog message
  rebase: Add regression tests for console output
  rebase: Add more regression tests for console output

 t/t3404-rebase-interactive.sh |   7 +++
 t/t3420-rebase-autostash.sh   | 138 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 4 deletions(-)

-- 
2.13.0

