Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B74920248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCNPdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:33:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45703 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCNPdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:33:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id d21so3553343edx.12
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9zGapRAnamy+C9pyPdGt9QUEjrCuM7OYFRpWVW48J9E=;
        b=quFH41KKYqGPqR+pDK8Yi13QseqmOlImVxQyelc3IBoGrwIebUO6fYk13axN3iIwnq
         yFRcjKU7U71HF5XS8dk9A8FZFIRjfgsuuTMqjSV2fupSB3gXumaBH6N6+oDdyRgPUMGY
         z91OJoA2sjgTXxu/rpkj+gkM5cxPGRhgHsUxMKAAulCTV3YboP4KqNNoGGjc0JvVHqPP
         1x7sqC1CwwRasmG4Qj59rdG6TtbAta9px6K/fXCMKN+PdFtZnbNcqZcdWwEuHY+vA7pu
         XshQbcxa3S9xUApe3fGnddgLk0GW6aY1qIwW2QE3YSqO6dvrqUi4LP6+E61LPXgmjS0q
         rQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9zGapRAnamy+C9pyPdGt9QUEjrCuM7OYFRpWVW48J9E=;
        b=n4VPfI6IW1ymiRp04wj5epr+usMzRIjoVEP+s3kYBgYgE1tEQcv3TpF5xk3Cm+PfFY
         Oq7OvRrCMMt/c9ey4fCMOrmDH0cOKxaO57SLbhl37QXQ03XVwa2SHVWiBq4tssa3rvl8
         9uIiC01yuZmjd4aCwQYCZIgohpPf4ERBJd8aioDfQaGhLgr4mQ4U06ZXdkhkT+1FgpXx
         hAW8uBRBXYvfxnJp+9npWEYQUhCQh4YMCeRh0WKPnLVc+6hDwlOff+9YRCW5sGZiF9Ai
         74j7PE8N9Vzyor9waYabzyXCApmcf73FzzqRtardInQiA6XD+vMn7dIxf7E9WZwJRovW
         dbwA==
X-Gm-Message-State: APjAAAXm1AuKbaOsehfbf8iHn/wtxKhIdpWGzv54c+BCSKqvuQEU+K9o
        h/X6olbhsDAe1hn59t9E9VzezZLi
X-Google-Smtp-Source: APXvYqw9v7OmYSNYDwO+pHEi9FcjaMCGTwfBERtqUkTjnGRcKmNvFBGRBUo3RAjEtuLeWGUXb/O9xw==
X-Received: by 2002:a17:906:15d4:: with SMTP id l20mr14751310ejd.11.1552577589043;
        Thu, 14 Mar 2019 08:33:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm1206229eds.45.2019.03.14.08.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:33:08 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:33:08 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 15:33:04 GMT
Message-Id: <f0cbfacf9ae54b73be58474e8cdf4cb262620b72.1552577586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.v2.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
        <pull.161.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/4] sequencer: improve error message when an OID could not
 be parsed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The interactive rebase simply complains about an "invalid line" when the
object hash of, say, a `pick` line could not be parsed.

Let's tell the user what happened in a little more detail.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 95dda23eee..f91062718d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2137,7 +2137,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	item->arg_len = (int)(eol - item->arg);
 
 	if (status < 0)
-		return -1;
+		return error(_("could not parse '%.*s'"),
+			     (int)(end_of_object_name - bol), bol);
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
 	return !item->commit;
-- 
gitgitgadget

