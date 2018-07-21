Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D691F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeGUW7K (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41960 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeGUW7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so9546836pgu.8
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gymr5nZTv2yDBamb3oI/1q5JNZhmUitEG/IQH2WJHpU=;
        b=avpO0yvab+1uuQAXV1TE1P5qDTcYaA0hfE877xQ/fTBZ8h94RHY0lJJMf9NTwSX7CQ
         AIwxjMIHdxutjat5TL+lmUjByy+zIO/+7fkVLIOhEJsSMyCXh07LGSyB2XeP80lhuLXu
         86entV0zL5lJxe4VDZjxzsxMMxN2UWrkk/fDUJG8Xnuamuw5m2/bZ9bK+JxnQfJpp3Rh
         AW2pw9x2VaHj/DynyUoBBUvULl0pYXbxfTaam5l6HXV8nK+bNOMWt557MkpgauKzMh61
         9IMPUckCEN5kYvCYk7oGwjobO8KMGE2cWf+DuPEtF+MDKGqj7eGK0dZBfvIH2UNWjBbZ
         4abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gymr5nZTv2yDBamb3oI/1q5JNZhmUitEG/IQH2WJHpU=;
        b=B+1HGB/KhzrBFK1aI10ibFrzA92C0oBMZD45sVshGBIufqElksFX6draicNZBNKxFN
         oCNq6/E1AdSvZf6wSl+4sJIr3iZEqKMjk5fAmXmtHFqeqFVdFOPw725gbecatf13kGC0
         hPBVttJAbXGEY1vvM6plzUbygWzdz9S7EkzUarx29Ww/6662CjBKX45p5t9R426R8dfH
         LViIWJ49qR5zbzeoQuH/6RG8mVoffrvIBLHxzcRTG6DqtfoXdbKJ+0yVIcX4A6A536Ay
         aQwp4OF+UAVc196uzGi+KKpgj4EYs7x26pO25oECBiiPejcdXHOj6M8CUlODjFQt3aul
         XbNA==
X-Gm-Message-State: AOUpUlElCyPhoMele/WVV8EWxseQXFrgxo7+179rGojn5hDhR8vCeDnM
        pL73SW6TzYWD8Uh9h3PbomLq7JvL
X-Google-Smtp-Source: AAOMgpcgSsjFP7/MZPkSddRSLfmexYeeVm9oKRv573HyaxbBA8USRqB20EAsLv9V49y/q9ha7xKGjA==
X-Received: by 2002:a63:6188:: with SMTP id v130-v6mr6852442pgb.100.1532210694027;
        Sat, 21 Jul 2018 15:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id j83-v6sm8215379pfj.71.2018.07.21.15.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:53 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:53 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:27 GMT
Message-Id: <41ab875a39f86fe1f386f0f4fd4e52f95e03cc76.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 06/21] range-diff: right-trim commit messages
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

