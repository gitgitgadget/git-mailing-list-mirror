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
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8291F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFYKL3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:11:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40989 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfFYKL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:11:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so26286664eds.8
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EY6tU9siMOrAiIHAYDHWar+mt8+ESKb84MBIoxIGVtk=;
        b=tG+z5SU98laExUrItCz6CVByXUZMNnmIlKKs8fBr28ep/CIe1Vx3jA7MaK4S+w9bzx
         El1nbsjjp8m8O7NkajGKg45AkLzIym+sX/+lsnJqp+UAu53rBevT4SRx35kthioMj++V
         tse0elEyQGaFEulxbpvo9lq3lhF65Po86oY/YHWuky81PkaxJrtpt2EHRtVe3hRFmt2v
         XqutsbmXX88QsKUxnDCGIUY6tWgjwQ9fzG6b7P9RrpIYPjEMNEpC98lHWmA0ODLd0ax3
         UIQTyNBAlmSF4Q+6y4ULwzbK5t+rZKzMn0pZb/h7nfhH1Ki18MX9ophZ2ndsS2SjUi0o
         caYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EY6tU9siMOrAiIHAYDHWar+mt8+ESKb84MBIoxIGVtk=;
        b=geVkvpTdtROOsWCjYhpXcY17A+ESfUF0OUNCN1R5pwDBwYyPAR6LcqHmuWLUNwm/6l
         uzSnrkXIIN3TvQbYOCXTUTaPzBVLHoiTg/cRUEkkDfETmMWJesLCCG2ttnhbj1uA0xJ3
         UyQtEQNE+yadrCUlgzv2I8bjck0O2roSy53RrZ6j4I3WunZu4W16Wgj9iAVU04bfprGi
         /DUwlxlOEPWNdF9ab1/WOpdiXY0VGiNst60GRilejqFtXsNAexhqa8WcdCK/16MW8Bfb
         21bM3eP22gJS5FuHbhSPEq0fKZxN2rPnInHPxz5kviPt/XOstYXgC9aoj2W1f0vz8NPy
         3nbA==
X-Gm-Message-State: APjAAAVc0oQoauazMEpyJOd2Q5rQZcz4s0d5iOgaf4e19hdJ/3DP8Q68
        tgYfFXIXjJNM5ion9lx0MTD+d1qi
X-Google-Smtp-Source: APXvYqzflupK3osVxZAwkxNcSWMtCk+md9CpExUpFQLhoICaUeugUy0fQdvbxk6F8mlQ6yHawO4k4Q==
X-Received: by 2002:a50:86dc:: with SMTP id 28mr142951795edu.132.1561457486149;
        Tue, 25 Jun 2019 03:11:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d44sm4622836eda.75.2019.06.25.03.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:11:25 -0700 (PDT)
Date:   Tue, 25 Jun 2019 03:11:25 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 10:11:22 GMT
Message-Id: <ebe8a2b3a1638e8457b1b703b8c4890a9b8904a0.1561457483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.275.git.gitgitgadget@gmail.com>
References: <pull.275.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] sequencer: factor out todo command name parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Factor out the code that parses the name of the command at the start of
each line in the todo file into it's own function so that it can be used
in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 919e3153f5..793f86bf9a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2076,6 +2076,18 @@ const char *todo_item_get_arg(struct todo_list *todo_list,
 	return todo_list->buf.buf + item->arg_offset;
 }
 
+static int is_command(enum todo_command command, const char **bol)
+{
+	const char *str = todo_command_info[command].str;
+	const char nick = todo_command_info[command].c;
+	const char *p = *bol + 1;
+
+	return skip_prefix(*bol, str, bol) ||
+		((nick && **bol == nick) &&
+		 (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
+		 (*bol = p));
+}
+
 static int parse_insn_line(struct repository *r, struct todo_item *item,
 			   const char *buf, const char *bol, char *eol)
 {
@@ -2097,12 +2109,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	}
 
 	for (i = 0; i < TODO_COMMENT; i++)
-		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
-			item->command = i;
-			break;
-		} else if ((bol + 1 == eol || bol[1] == ' ' || bol[1] == '\t') &&
-			   *bol == todo_command_info[i].c) {
-			bol++;
+		if (is_command(i, &bol)) {
 			item->command = i;
 			break;
 		}
-- 
gitgitgadget

