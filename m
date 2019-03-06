Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5CB1202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 06:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfCFGao (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 01:30:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34492 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfCFGam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so9823823lje.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 22:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vl8jmySiWfe9420tqborbSybYzbKR31LT+s6o1XDrPI=;
        b=ZJa79ll+Na/2hExvA3GGJnV+5KtFpttOu+HfPXmrTFOHbPUiC8ltH7Eaf6VRKPnIYV
         AZu3bxxu9cnwPHR20jNndjy6Lg5gboyzKGno0NbrqBFgk8HmeNBZG1UlaSsUChs06dyZ
         NF1eDPFvBcASCXOiuRCcGdGCeebCEXACUblSkDf9NFeJ5Y7FAlmyxCOqZLq1LGAWBwGo
         dQMz3FTEE11JEMIv62h7Q1OL/6Jx32zxr+kr5hGKMmAarFCmoHUBSItxD370/aGXdK2C
         IrI2qbpNfQNOR4butvcAPX/u8BUDM8g3yx6M1zMYfZRKgba7fpMWyHvpbtrawApF6+1O
         MIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vl8jmySiWfe9420tqborbSybYzbKR31LT+s6o1XDrPI=;
        b=D1NYo8nOb/PoMslXKeiJ+jFXUft3J2gcQLoY1HmUPjxj8QdALqW8ATQMOPkLTVI5zS
         hlNTHwGn1dozPcH4bmrxvbRhiqnopnxLuTscJAfHH5EODhaRsqr17CBDLfQZIo1lm9ga
         DjxbudVUhabrasrU+tNXAQ5af3de37ZqwTk/aLeuaUBvU4fU6A7UkAHeAVaj2AwFShke
         HvIIYEdHBD5/qrXm4F0Jh+hXGQwu1g4BXnnsVSxro0e2PSoMwHewyxxER8S17TS92T6X
         zQkntjFTGat/5zRritfl546GMmYXvryq2KRGYr3HETOD4P0pKQivZfh+Hm+uTPKrdfEC
         A7cQ==
X-Gm-Message-State: APjAAAVYxvBY4exHxlx8RmXMHH/WPT6lWSdh8HVHn0e1zRfZbbBsz3YZ
        bTqo0lSScGu9ieMkkwDKSZHIhC1E
X-Google-Smtp-Source: APXvYqzUpBIECQ/J10y0R6SZl+oLF2fLHmw5SKqpQdegNoQ+XVEQ0ct2H2wDf2NLss4rgkvuYDazPw==
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr1358969ljj.171.1551853839921;
        Tue, 05 Mar 2019 22:30:39 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u29sm149715ljd.84.2019.03.05.22.30.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 22:30:39 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] git.txt: remove empty line before list continuation
Date:   Wed,  6 Mar 2019 07:30:16 +0100
Message-Id: <a7f9e9be5fb169e8f67fc91f62e17648535b64cd.1551853194.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551853194.git.martin.agren@gmail.com>
References: <cover.1551853194.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is a no-op for Asciidoctor, but makes AsciiDoc render this as
intended.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 00156d64aa..6d1f2fd9ae 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -536,7 +536,6 @@ other
 	The command-line parameters passed to the configured command are
 	determined by the ssh variant.  See `ssh.variant` option in
 	linkgit:git-config[1] for details.
-
 +
 `$GIT_SSH_COMMAND` takes precedence over `$GIT_SSH`, and is interpreted
 by the shell, which allows additional arguments to be included.
-- 
2.21.0

