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
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B7B1F4B6
	for <e@80x24.org>; Thu, 27 Jun 2019 14:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfF0OMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 10:12:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39439 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfF0OMr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 10:12:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so7223692edv.6
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v0asLOoVnW44InY+FfVIVFUVkGA00MdiKgUa4QA8Xw0=;
        b=Z09IbEcW+6ituJQL8cdf6YOZglu+HazCG/nQE58XVSnUhG0EdsZaEk7iL5NYwIuSzn
         YdsTNciAnoGyu6T7p2WHespwPt22ZhmENFfMAvwZV6pvwiyq2CokmxAZbom5FDIDMXhh
         hoLSRo+lDMTvY7BBqAcc9SQ6CGr46fGxwFqxfD3eho86k/1MmkcKXWJOEYF0MxDcArhM
         9QI9uENLwyqta9veM9whWISMWbr5pbQjaAs7RSp/croYTR1PoBFFSYzYtxCjxDcE6+ZG
         va81/LK1si981p+vlSIk5DmhKD9nlj+p1h83G4heGpxiv2hGWdp7wbQXAfWDL/skki3b
         BJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v0asLOoVnW44InY+FfVIVFUVkGA00MdiKgUa4QA8Xw0=;
        b=fAGb7p90+ODu9gBU7ZHBWzBGrKTTW6ZeYIjyJYlFQEnYmkqIw2cMeeoAuXJW9z/GN9
         w2jElYmUt52CbbKQtbFaBxe3x7+L73nOeyNRFJ+PVc3njoWzGWx6IW1wy4jzlw5qQxCR
         +C7kpkdP3hvYjilLwe8LCmOSpmC2Ig6iKtE5qeos1dDzqnt5BMEKWho/eQyLPKKad7/W
         tcdV+ZMQzTDal85q8rXPYZPBwO2ZFq/OBFktMVMKFxgDAClt4/d/S1Kd4BqijcVah5fJ
         Xkp1/kx5pR2cEf9D5hBL+3ZHtf6FqN/mzcWEca9ILSZEjLghukS6Gcqk2fQ+RoC24NFE
         6UYw==
X-Gm-Message-State: APjAAAWObh5VbWPmnYzhcyeEHd7iXpWNgpmiEy5Yhni3AhZHrqY6gelS
        a2EvHRijTaHiBSYD7/Q0+NYKrdzS
X-Google-Smtp-Source: APXvYqw0voIES++yUnt+NL+wBF4pL77GHEaKvbY0F1gvOVLxZ2kEiXzPjZ9QtKVYlNetmmnLGGMNSw==
X-Received: by 2002:a17:906:6c19:: with SMTP id j25mr3319163ejr.21.1561644765694;
        Thu, 27 Jun 2019 07:12:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e33sm763044eda.83.2019.06.27.07.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 07:12:45 -0700 (PDT)
Date:   Thu, 27 Jun 2019 07:12:45 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 14:12:41 GMT
Message-Id: <c3885c0b8f55957695650c2d1e25f9036d7e80dd.1561644762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.275.v2.git.gitgitgadget@gmail.com>
References: <pull.275.git.gitgitgadget@gmail.com>
        <pull.275.v2.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] sequencer: factor out todo command name parsing
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

Factor out the code that parses the name of the command at the start of
each line in the todo file into its own function so that it can be used
in the next commit.

As I don't want to burden other callers with having to pass in a pointer
to the end of the line the test for an abbreviated command is
changed. This change should not affect the behavior. Instead of testing
`eol == bol + 1` the new code checks for the end of the line by testing
for '\n', '\r' or '\0' following the abbreviated name. To avoid reading
past the end of an empty string it also checks that there is actually a
single character abbreviation before testing if it matches. This
prevents it from matching '\0' as the abbreviated name and then trying
to read another character.

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

