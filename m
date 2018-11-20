Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3092C1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeKTUMs (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 15:12:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33454 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeKTUMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 15:12:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so677308pgu.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 01:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OfhlEXlGoXYSRYSi7u1DHgEzR4g1qFDtXsGkftwWXvo=;
        b=JKZ+QN23ZAj7NbCWWBCWYGRi59p8HRwMSUudEGzi5JUnTNcHhof3TMeH5VZz7LSAjY
         jGJ1hOfLrr0sSScC9DY5TTYp6eK8UAjsRcaAdJ7XmHI+OOWVw8epiG/ty61ghW7T72m8
         XW03OR1Om3w3QywWAQq6XqM5WIZkp0XsoC01tEMl2AuyxNHUFUJoLQV+EpbWr/lw4xdf
         1Vn9LDzlK1+Io+4ZuMwyFuqxX5t9PCGUPJa4A0Jy4OtMerPt6fzP82xvS04/oXnSVaXk
         7awzQ2UQEc5sg6mBVigrjLXkToDgQDh84Fzbzqlnrkpq0U5snFdfQVF/p0eOohrCwJ1l
         g07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OfhlEXlGoXYSRYSi7u1DHgEzR4g1qFDtXsGkftwWXvo=;
        b=YVIurMKc8BstnPJy8ELSQWivwB/lm/QrEkXfcqlcVzC/94EWGzZ4tnqkqyYXgSlv/U
         x18CyH20QvyBBjEX+3RxMDY1fDSHcyQT/O5sGZHmB9fGw611JrtFXWxz9znhjoD9rKVs
         kjpNZz2sOITNApXhcN9m2bmWkwQ5f8HUoPXbgLyu6Hs13P8ViN3tklZh4hrKD5N8xDPX
         U2kTH294Hrg1oZLjp6XYFYNivxadLJAo3M4f/Otmmo3JMxbF7IFiTjxSvud7eetl7xP8
         9pwmWiOidoaecHtGLnLaApWtevI8kE9CpfFzT5x0KG32h735nqyuoLCI2LbCnz/NRjJf
         TzJQ==
X-Gm-Message-State: AA+aEWbaFmbAKQpQk6o+NtStLycL6q5mLM8sBLtWuUVG4SH39zavu9zs
        PMQe0/artcUVTp7HaU1A8HX6BC5B
X-Google-Smtp-Source: AFSGD/WCJhbgVQfkhPaVgly1s2P0Jmlyt6l1R75PUTUbxgzE6ILIDCH2hTfXvztw7eWiYS79sDEjjQ==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr1265701pgc.165.1542707074536;
        Tue, 20 Nov 2018 01:44:34 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 79sm42604037pge.66.2018.11.20.01.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:44:33 -0800 (PST)
Date:   Tue, 20 Nov 2018 01:44:33 -0800 (PST)
X-Google-Original-Date: Tue, 20 Nov 2018 09:44:30 GMT
Message-Id: <d55ede7e4d46d67c070f87df9689ffe8af2d5737.1542707070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.85.git.gitgitgadget@gmail.com>
References: <pull.85.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] rebase: warn about the correct tree's OID
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

This was a simple copy/paste error, and an obvious one at that: if we
cannot fill the tree descriptor, we should show an error message about
*that* tree, not another one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1a2758756a..5b3e5baec8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,7 +582,8 @@ static int reset_head(struct object_id *oid, const char *action,
 	}
 
 	if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
-		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		ret = error(_("failed to find tree of %s"),
+			    oid_to_hex(&head_oid));
 		goto leave_reset_head;
 	}
 
-- 
gitgitgadget
