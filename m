Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AAAB1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHKAqV (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36912 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeHKAqU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id d5-v6so4582702pll.4
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gymr5nZTv2yDBamb3oI/1q5JNZhmUitEG/IQH2WJHpU=;
        b=SigIuLPKIas6mf0j1OAZ3/yiCNsLun5wfAsnmkWCIaiFW5StrSm63JbAdVLeXtc+sD
         uFYHxMxuWaGt9g55SGr38pd6tRo0DYyxX7MKo4VKOah9kaeLuwQSVF3OJHxUCn8HINFn
         DgyRw/7B/iGzHpdbM31yQ+jZjNtukQYtmrERWXrZSWS43vCF7IClz9toYPiu1bpysRPl
         kYlVhJlwc/Tuj1KmbA2Rq6YSU2PF4kfOKXBTYmghwo2ncvPZ6vmuoDOpMuQiSLHbbH2c
         bjNrmr7SUbnmRAKqOxQ6Vp8JrD7biksbnER4cbBllCagYqLE6QnGas0VhRmadL9539UU
         jSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gymr5nZTv2yDBamb3oI/1q5JNZhmUitEG/IQH2WJHpU=;
        b=bp72JK7Bt8pMfRV0oCkqIz1XMfZogIcm3Lt1wM5NYR1myL8NrL30AQ4wuuBbo6YySx
         sCby2Yi9gwdAmxUwZH+ygBNNBc7XmUWOw/U7LdB98vHtekHr8JNwL+lhgaAsw10fekSQ
         Uvos52NND31FuMDF7pKSEMkRmLoiEc7yndULqB/UsHsGwON5/EbNxclkm5kyc4S88XAe
         Pz4X80Wcm73yaK8xm7K1SHDs9zVvch1fE+QcBw/eCJLll3mOZ2fw96FBuW8lJvONblkM
         8rUlpEKb2NF++xUgHCmdJRxlvfTnRRTB7osIKJXz+tHgwJRLrLZhEPh3Fm5W/EI7jwTT
         8B8g==
X-Gm-Message-State: AOUpUlH0wgAM8tPErmV4fR/LBGDNYrGE9Umwfv5DMWMGMe0vKaRaBwDe
        kfRd2t3ZPG8S8nEHlIt52ouI1rxY
X-Google-Smtp-Source: AA+uWPzHquhp1L2nYyK5ofs29hWg5ECBYkqunxGZudUKnauMFCzQcQ9m7LBOnL5oM5awLmdUhHn/RQ==
X-Received: by 2002:a17:902:227:: with SMTP id 36-v6mr7827959plc.103.1533939275139;
        Fri, 10 Aug 2018 15:14:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id j22-v6sm12831071pfh.45.2018.08.10.15.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:34 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:34 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:08 GMT
Message-Id: <167ca02a35551e48a8ba1ca65d5c46ba78134fcb.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 06/21] range-diff: right-trim commit messages
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

