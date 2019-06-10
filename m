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
	by dcvr.yhbt.net (Postfix) with ESMTP id 148BE1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbfFJXfc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32903 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390662AbfFJXfb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id h9so17007711edr.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W5w8rS4sCM3WmqZuB0Oa69IMUfsWAR/eAtBqwbM0CqM=;
        b=SkC3Q4nNbtCW3gKcemc2Cr6FzRld74y/VyGz6pwW3FVdMCWkLYfaD4gZ8YpCugtYHW
         qRvR9trTvaTAcs6PiC01n5q/3l3sLyZtab5rWTx4UxscFWH4S+VMphk/H6d2zDP7Kpt8
         5w3AiYa1q6+nnYji3u2v5PbdGcRE7oRYzXDogBgKh1+aUbemSgjeQzTaUOIwcbR7Moe5
         shLxoNQk6weHuW3PJWP3AgNqb8hj+0imY1NkYUvZcrddtRB+/rkUVY4JFSyexCnRfmRW
         OpvSm7oBfgONZc4Zv8IbnhcpXEzkRlXl+gIQsH3SjJv6Wu87xolXXpPz3gH0LnH/pKHz
         4//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W5w8rS4sCM3WmqZuB0Oa69IMUfsWAR/eAtBqwbM0CqM=;
        b=AbSzkGjTRplCBOFp0FKMCFmNT1MwRBJ3RuNZiAkPzNDgTUtMKz4vQFxpI6et55q54B
         mZp6elTWJEpbezT4nTCHReYhciginHqpZzIPmXk3TRGKhP2HLejUgsQmWIyJxmaj0C8e
         mf47MuZGC430bCORfqcmgn8CELLQ7tKrhskQfYPcEQUt1Ig95YZUWYgZz9qVwdNMruI/
         228A4aivQ4IBUA2I+6w+/jUYP+A8m+NSsW1Hd1v98Mcnj0u/qJy638G0XoYRV83XKFpd
         6ycvv7SuXOys36+U1Bbrzxcgu6BPKpIa2a/OP00vtN7bq0ij3xdL7VM7PHUxsXTZtdfA
         MV/Q==
X-Gm-Message-State: APjAAAXPxQOmFnzJplT7CcxyIp8ERKq5i7YYsLt8rJvlbSS5QrE6RygC
        tTX1TD5hpFLxj3GxzL3vBg3Wugwd
X-Google-Smtp-Source: APXvYqyt1u63B4dBRomx3qy0S3pRPaiYtjH3kKX+VuSeg9ezFgnhtjbHH65yqpzauib4bDWPysq35A==
X-Received: by 2002:a17:906:1e8a:: with SMTP id e10mr23422759ejj.261.1560209729659;
        Mon, 10 Jun 2019 16:35:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm1991113ejk.49.2019.06.10.16.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:29 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:29 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:20 GMT
Message-Id: <3ed388f0a8295c504da5d0a39887f246ec532aaa.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/11] t5319-multi-pack-index.sh: test batch size zero
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git multi-pack-index repack' command can take a batch size of
zero, which creates a new pack-file containing all objects in the
multi-pack-index. The first 'repack' command will create one new
pack-file, and an 'expire' command after that will delete the old
pack-files, as they no longer contain any referenced objects in the
multi-pack-index.

We must remove the .keep file that was added in the previous test
in order to expire that pack-file.

Also test that a 'repack' will do nothing if there is only one
pack-file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c288901401..79bfaeafa9 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -527,5 +527,24 @@ test_expect_success 'expire respects .keep files' '
 	)
 '
 
+test_expect_success 'repack --batch-size=0 repacks everything' '
+	(
+		cd dup &&
+		rm .git/objects/pack/*.keep &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 2 idx-list &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 3 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 3 midx-list &&
+		git multi-pack-index expire &&
+		ls -al .git/objects/pack/*idx >idx-list &&
+		test_line_count = 1 idx-list &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls -al .git/objects/pack/*idx >new-idx-list &&
+		test_cmp idx-list new-idx-list
+	)
+'
 
 test_done
-- 
gitgitgadget
