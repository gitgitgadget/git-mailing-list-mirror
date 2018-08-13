Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809931F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeHMOPC (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39221 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so7530148pff.6
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gymr5nZTv2yDBamb3oI/1q5JNZhmUitEG/IQH2WJHpU=;
        b=cGLAPz6d3u4dPOQ28P+GUNstX4cnjPYfBp0qZHRIIM37cK2cKYRQg8jzCjbvyZxM/U
         f7fRe7qCMsBhi1np3A7265v5902UHout4YJ2UHW4QhF9ww22Hqf0e7WWBoYzFDiMLj1S
         2Xj4jmc/D5jsmBZ6p7T0N0BN1GN+Kn47d7yPKKyUp/ejKktlKDNPsjKZpB/TQRSTsucG
         LUAwuwi0eTnJt9+hdzb3edCBEmqiAfhw7Thav7z1g6DwuarAGvH3xmz1npNQpMqTfKcq
         wlBjS8tqYUyute6kH2z1abM76/WirYnwO1W6kZoYWuH8SLBm6KEZmDEqDo4FFiwZ+mUX
         IwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gymr5nZTv2yDBamb3oI/1q5JNZhmUitEG/IQH2WJHpU=;
        b=f22OzevzLtESFT3vpdNv4rE1vH1vyIm6ilQ1Xs/wrkUaD9a1pnI5dGcm+HrrzWok+F
         l7f3vEGN7AvwIOctKgBsKRza245lDjmQLOBjic2tEktdM8drph9CHNbYyjQdgI63ak4x
         06PmH4JITPc2JFUfAUN2JeI551iEOX0rTvq/p8pJG2/fYmwfQTeuIzQOOKE84ndgnBgP
         fMltJ2bu91amI5256hNvn8EJx1t+TCnf9M0npVbYiVAJktWMw3v9SlH3eK5FP4xm1E6F
         zzLxvG0u53coOUJ5A1msKmGcH1AateMLXp52WXoCy/yzDpOGJVHLq5+91z7r3Rx5mobj
         zF1w==
X-Gm-Message-State: AOUpUlE6eMBIraYUK6D6oobJBpYaPsbrl+VzWOqXKOptzfhCLwBM97HG
        eEEF4CrikY1UIAEV3Gy2rRMH5tfe
X-Google-Smtp-Source: AA+uWPziVLQUpdog4GOpSyrUK3cdauGZmtpp200zwjw4Cu3TlpgC6ZeP1o1rxW2WIe0fn6OWAEYpAg==
X-Received: by 2002:a63:a745:: with SMTP id w5-v6mr17039951pgo.374.1534159989665;
        Mon, 13 Aug 2018 04:33:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id c1-v6sm20324313pfi.142.2018.08.13.04.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:08 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:08 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:41 GMT
Message-Id: <a10ca01633c65bdae66f10af93075fe0400ccb5b.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 06/21] range-diff: right-trim commit messages
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

When comparing commit messages, we need to keep in mind that they are
indented by four spaces. That is, empty lines are no longer empty, but
have "trailing whitespace". When displaying them in color, that results
in those nagging red lines.

Let's just right-trim the lines in the commit message, it's not like
trailing white-space in the commit messages are important enough to care
about in `git range-diff`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/range-diff.c b/range-diff.c
index 71883a4b7..1ecee2c09 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -85,6 +85,7 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addbuf(&buf, &line);
 				strbuf_addstr(&buf, "\n\n");
 			} else if (starts_with(line.buf, "    ")) {
+				strbuf_rtrim(&line);
 				strbuf_addbuf(&buf, &line);
 				strbuf_addch(&buf, '\n');
 			}
-- 
gitgitgadget

