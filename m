Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E271F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeHMOPE (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40305 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:04 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so6769692plp.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=falq5Z94qzypoDAmri3SvO6RKASPuIBfM5Q62dx4oWA=;
        b=gtCg68t+5Ms+OlYCY91dWkm2vqX29UooCsSKlxSiGASey+7Yx6psHy3GF24uRspYjm
         leqskP6fJLs1ZBdnTWD0vicgFr0NEtshwoGvhv6gtTYTJOLXMalLPNuIh1/2zkzMNP1t
         LEPcQO160Aleog2M/rz9P5IJ4D3FzpETKrqgmTov5iz0Ie5XWlB2F2amZFHa1pGbQA2O
         ZwSd8OkzcoPOx2sXcn/XVbHXN7OgarMBNM9kH15KHCmIa/mIM2qEYp0XLB1uhGydY8TL
         bA/iaVNGXHqmQY+wvnqQw4D1a563V15boVGGTMK3kCNOvQoMmV3XDkS8lQFLfoT8Kg1l
         TxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=falq5Z94qzypoDAmri3SvO6RKASPuIBfM5Q62dx4oWA=;
        b=eVR0InIoMH2P5IPN5AbdpD9Q/IJLL/vbH9lKtraP+hifIGeE+t8WPYFXdB2xtkZXRu
         IRIMQXRTQbfaEUc5MxmUsb4wn1qNinrtQ+iusb/VdW/UfKvsLUxyxzz7QTOy3BwG/XjQ
         /zqOysAKRCN67jX4vsB3x59Xj++kPvSGE7QxJFFyney06pXlWRBuwXYVdO+0lzE0kT71
         yHYkjQncjIABrEm9C8r46kvti/PZ0wv+ecgcwxb+YnP7itmqN6ucdvN2L2uCUX1+txuL
         ae5qMLP0XDc5GJUjxSKJU+hgeKyBP07r66pFGp7OhL/ACgqaQLaYagrlAt7zsTf3HXLb
         CfUw==
X-Gm-Message-State: AOUpUlFp0lj/qvIzxo25SA5G7UluyaIenTtfEx9RDtI/2yKqV9v6LxB7
        4XvlCvyru/R1fjpt4Tcgy+h/Pqy/
X-Google-Smtp-Source: AA+uWPx+HLHL0EDgFT9X+rfTUPkwQA7Gwo9WTeP0BEKm8+mbUXFxMq95OdWOFJXjPhvB4HIOZH41dA==
X-Received: by 2002:a17:902:3204:: with SMTP id y4-v6mr16323799plb.195.1534159991115;
        Mon, 13 Aug 2018 04:33:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h18-v6sm56735311pfa.173.2018.08.13.04.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:10 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:10 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:42 GMT
Message-Id: <f81cbef2c7946bac5e3f6c08a9b937eb05450cae.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 07/21] range-diff: indent the diffs just like tbdiff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The main information in the `range-diff` view comes from the list of
matching and non-matching commits, the diffs are additional information.
Indenting them helps with the reading flow.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 3b06ed944..f0598005a 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -11,6 +11,11 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
+static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
@@ -21,12 +26,16 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int i, j, res = 0;
+	struct strbuf four_spaces = STRBUF_INIT;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	git_config(git_diff_ui_config, NULL);
 
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
+	diffopt.output_prefix = output_prefix_cb;
+	strbuf_addstr(&four_spaces, "    ");
+	diffopt.output_prefix_data = &four_spaces;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
@@ -90,6 +99,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
+	strbuf_release(&four_spaces);
 
 	return res;
 }
-- 
gitgitgadget

