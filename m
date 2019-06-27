Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7859D1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 14:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfF0OMr (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 10:12:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41643 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfF0OMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 10:12:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so7221632eds.8
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Pp0pOh24JeXCDwML+8Tat+zy/xp3jjpopYGA5b9S1s=;
        b=bYRvP+CG1OtqsIqJdu+8Uuy8YBpVSkBMeltR1vBA1dj1LlCPJWigV40uSkdNDQ0xRC
         +R+1UORFLKDhERJkwUSzMbfm37FSGHo5Y9hkRPPUFUTktNieaAhAps/j74IndyGF2vPR
         /9cJRzPo/0Q4Qx3MkC/uIUIeGRjilOK8J+UVvlKP5WtB/iOnZ1XSFx3dc9MnR/Frt1Bm
         hTeTooTYDq9figI3kIyTgGfDg37PW+kTmoSEv4n2xFKSsfjuKJPugKJJxh6jdQRSS5Nc
         Qc3IaJVvGfIo2SHALDqKQF4HyN7hwIZjoqVclJ43iztLpF2VeGs0YqRnB5IrA9/Wi1ue
         7ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Pp0pOh24JeXCDwML+8Tat+zy/xp3jjpopYGA5b9S1s=;
        b=IB76t5KdXQQj5gOdSFp0pdBrd6Jgvrdb+Bf3BDH0EoHmXiRr/MOPHhxmus/FYxulzm
         oqe9dAMQDmWRR0rrrShX3l3whqG3jCFW/dOUlL8U5qGV6/YWdO3ydQaWYnaKeQCrgeZX
         DO5rXaFBYn6XUvPLskdPx5VFIJF158QHrZJSlBrrLqV4p6QcguXon9LhAk3dS615ZOZf
         JTGeq+fuFoiz7Jj6SyaYIt2nasb1HXv5qdPm8M24qT12tBVGdUn3yzDm6/hSCsERY498
         O09Drv58P7FazdBwiZ+kt5V4RSu45RHHH0YHS1vubHd58BdDRfWLf4LNkk9truCkPJOF
         JgyQ==
X-Gm-Message-State: APjAAAU3f90QP3J7k3v6XhLClAB8UBs2s+bqlTiAB7FA8XCp2xiw/VUx
        osBRtIC3uhJ0Rfui335j3M4FK0Il
X-Google-Smtp-Source: APXvYqxnGYv+HgvV/62A/KHFUdUK51JqJs2CyxBzX5SZLMz3LhGAYC4TEGOV5+NkD7kv2tOyC//nmg==
X-Received: by 2002:a17:906:6b53:: with SMTP id o19mr3458220ejs.27.1561644764745;
        Thu, 27 Jun 2019 07:12:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s52sm838469edm.55.2019.06.27.07.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 07:12:44 -0700 (PDT)
Date:   Thu, 27 Jun 2019 07:12:44 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 14:12:40 GMT
Message-Id: <a5bede1cf9cba89c354779e559e19d7a2fffa1eb.1561644762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.275.v2.git.gitgitgadget@gmail.com>
References: <pull.275.git.gitgitgadget@gmail.com>
        <pull.275.v2.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] sequencer: always allow tab after command name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The code that parses the todo list allows an unabbreviated command name
to be followed by a space or a tab, but if the command name is
abbreviated it only allows a space after it. Fix this inconsistency.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..919e3153f5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2100,7 +2100,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
 			item->command = i;
 			break;
-		} else if ((bol + 1 == eol || bol[1] == ' ') &&
+		} else if ((bol + 1 == eol || bol[1] == ' ' || bol[1] == '\t') &&
 			   *bol == todo_command_info[i].c) {
 			bol++;
 			item->command = i;
-- 
gitgitgadget

