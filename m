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
	by dcvr.yhbt.net (Postfix) with ESMTP id E35361F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfFYKL2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:11:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40986 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfFYKL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:11:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so26286611eds.8
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Pp0pOh24JeXCDwML+8Tat+zy/xp3jjpopYGA5b9S1s=;
        b=PYUUPvmB8mKwRshZWlMQfu5Mj7egMWVTj/xtaN9YpBxgiVQVX4EZsAj4SKs9N/JNiC
         qdq532Xbm8KA/KcjghW1KZK0sxwzb3bFblmkJJz8f/RDRLsuzi+ehdm2LAmPt+0e5eMH
         yhyIL5kQUH+cMx1yJkI/tGlrQ8oDdZli7VRQRuEibUil4z+ETHQx69Nhg/iVC6G+tL7N
         VYf0Rip4vO+GrjCJKHb8NFXKbrjnqgkGyr+wIC4NrJRjtbwtatboYHN/zHNJmiVFyArL
         gGQnMhBXHwTVaYn8GHsQ9VHPkC0CArBJRxRQ6dvuaTOnlghkAIkW9OsC/dOTLISNiebQ
         PVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Pp0pOh24JeXCDwML+8Tat+zy/xp3jjpopYGA5b9S1s=;
        b=DpuGSlKHN5q0qjAtLK7OPSVmNLm/vsPg/NiotS9wzsnNFpVPyiHXuDpyrkl+TAWCUw
         75SrYhG1kdvKPTnMxYEOyWFMjS2jCigHsZca3QvDwW82Vr/vhT9jwbfta2vt/YJVjyW5
         GyJWsBTW/UG4JZONyobMmS/lHdMFluu03ag4Ho/KnBFkB8FitsDH23qm6aT2Js4pFewM
         AEX+6XN/ilMBGKvmDHyPe6uzCTxqNJJuSF0afX6S6oxwX51r63ScHg55T88oeEHmnCCE
         7ixcmAvjpGrIm9BLgwR5LzRVgkayU9SL3S6e6bcvVfJEcew2+CYINVJ8nrCXdTW6C/ym
         yRbw==
X-Gm-Message-State: APjAAAVDVHBAoJqamGvJOt5oFc9CUzSoBDeXz82nC9GBlfoNPm+6UsMg
        ns2iIYmHyP+2hxzgOul4Fvd02kgm
X-Google-Smtp-Source: APXvYqxD1szYvU1rKWVJzLMrVD1V8dkcW4bqg62zfdaFARCSTXf5wj/CnsATg9EUF6oKUe7IZ8PeVQ==
X-Received: by 2002:a50:b7a7:: with SMTP id h36mr54532641ede.234.1561457485557;
        Tue, 25 Jun 2019 03:11:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm2367684ejb.6.2019.06.25.03.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:11:25 -0700 (PDT)
Date:   Tue, 25 Jun 2019 03:11:25 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 10:11:21 GMT
Message-Id: <a5bede1cf9cba89c354779e559e19d7a2fffa1eb.1561457483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.275.git.gitgitgadget@gmail.com>
References: <pull.275.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] sequencer: always allow tab after command name
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

