Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2471F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfD2WGQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:06:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33473 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfD2WGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:06:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so1888705edb.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=fJfRb/OjNO2VysV1p2BT4uetAdnPlmldDZnmzuJ0hTg=;
        b=pDCv28AcRABT+2EwelHTIyf0dQxL7vkYKOHJsmta9sRf+2Apknr+umSb9cqDfyJ/PL
         VPxGlwZa4IL9jiKRm+lXnNZuRNo3z+uPA3NyidUPXgC5PU4fx5TLx0TjSGEnFc0y9e10
         IOSs7ZIEgEg1nxCGFOCA+vPRv9+vUkjI2P1l7yCw9aJvsqUOLnUcAcRXdTwrEmEXf2If
         spjwrq1/CYBnzMeqKo82pbNvCdxka/9HRIpgX+42qCsQPWzPLUbTGRh2F8ORx0HOsVZX
         AH24NpDa9KQvGqbdghOvi2TMJ/eqRty1kad1GLIN2ixdEzUUuLxQabamDF+3fhKeuYP6
         gZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=fJfRb/OjNO2VysV1p2BT4uetAdnPlmldDZnmzuJ0hTg=;
        b=FqOUhkDVm7VWVaSAvvrUXoT9lPJ/9VZNQ49seWJhQLsy/VoChEviF1UFRiyL9xFKIX
         O7f4jbngqK8Qkyul6FhwZsA50r1rd16SVfA6QdbM+Gm1wnbkBhl8XDGEaRsEZBYspXGu
         +4zsCbTnaN2E3jvN6PhbmGr3iVabrzbRqEsCbOAGdEV9+PN5VDJSJ4FXv2OLyq7nyKm8
         4HLiEkGdvkpQbUCqoITaqmK8A8lkaptsjdcmM60CcsCCNyOpHZy3wzBMD4wqoQncVV3j
         JqqjYE3uDUwmOE4jXbsK9Fzy4H/HPHxUPkfHdU4bZ7KbMpUecVoXGVBRnHDQLb1i+xfD
         ouLQ==
X-Gm-Message-State: APjAAAUACqjHSGajtkz7s9KBBrR3fTCyq2AlR1dYOMMRolZko/eVSkcB
        K7AbZjNSV2umR3Jom89WZepNz7J0
X-Google-Smtp-Source: APXvYqzx1/UKrIKwc5xFcUjfOim0RQpGh7lX4Am1EIluoPWpyrSdvnwDyfM9fiXke5PO6XzQDRK7gw==
X-Received: by 2002:a50:b7e4:: with SMTP id i33mr26317315ede.32.1556575572137;
        Mon, 29 Apr 2019 15:06:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm9347247edt.93.2019.04.29.15.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:06:11 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:06:11 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 22:06:10 GMT
Message-Id: <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.138.git.gitgitgadget@gmail.com>
References: <pull.138.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jaros=C5=82aw=20Honkis?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] credential: do not mask the username
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jaros=C5=82aw=20Honkis?= <yaras6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jaros=C5=82aw=20Honkis?= <yaras6@gmail.com>

When a user is asked for credentials there is no need to mask the
username, so the PROMPT_ASKPASS flag on calling credential_ask_one for
login is unnecessary.

The `credential_ask_one()` function internally uses `git_prompt()` which
in case it is given the flag PROMPT_ASKPASS uses masked input method
instead of git_terminal_prompt, which does not mask user input.

This fixes https://github.com/git-for-windows/git/issue/675

Signed-off-by: Jarosław Honkis <yaras6@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 62be651b03..e9108a9e8a 100644
--- a/credential.c
+++ b/credential.c
@@ -136,7 +136,9 @@ static void credential_getpass(struct credential *c)
 {
 	if (!c->username)
 		c->username = credential_ask_one("Username", c,
-						 PROMPT_ASKPASS|PROMPT_ECHO);
+						 (getenv("GIT_ASKPASS") ?
+						  PROMPT_ASKPASS : 0) |
+						 PROMPT_ECHO);
 	if (!c->password)
 		c->password = credential_ask_one("Password", c,
 						 PROMPT_ASKPASS);
-- 
gitgitgadget
