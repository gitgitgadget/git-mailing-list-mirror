Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AB11F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfAHVwo (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39593 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfAHVwm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so5979347wmd.4
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJMiClkkwBl/9tTdZW92xSpI49d9MQDh/vfopL+je8c=;
        b=cQN12+zTpaoxQKHKgtDcNuaCvfLBA2tFAmfYytWemCHte4GHRdsW2tpgc+IztWRFZH
         MqiB/BFus1dJ15ra1dTv8N7exZhZXKzMIc+4fHOqdbFDvDCgtrZOvvrQ3BHY5ZbR3ic6
         tY42Aq/Fkt8Fc/5c85ytoziTU/hd6kux9A/Pb8zTlH3VxalFg/LF8Mao0/PpMfyvbJys
         nw2Ppj8peL0B5M55WxqlZH1IjSnl4jTtM/vLrE9qvgBx4DZczCDU8QDeh8M/fy6mA/M7
         /FkbMWjTA45GtnGvszGWGwar2eD0Hx6+ScwJ/LmSmOWpT1Lc8HjdDNXZmiMht2aS0Kfm
         S2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJMiClkkwBl/9tTdZW92xSpI49d9MQDh/vfopL+je8c=;
        b=VycN/kYnnbNndWBXrZBfAHE9u+OHk4zGRtFPClxyetuaYk8to05v/mqPKmkl7UNtKa
         X2ePrd0NfrUkiHEHfh2777SmayvuIPLu2zeLLbwKiBNxko85g7167/Wo9NrF7HEBppkr
         nGVRIaTGSLJ43JCBjZZvoRtq/4iQpkwNjEeLZ92YjkZ77GgX6yG2CVEq/y+IsP0VCwI/
         orwlSBSKWtiZfGR0/pRiAcqZV+UaqP+Elz6QzXSS6p2uGidpWNeTIwh5T/bcnD1EEVpR
         SfFwXtt/xB4mejbVMQTNlbsOAgB9J7dHCc5cDMMHNW7iukRtZ7Zr/Quo3dRBlB51aRTS
         fZOA==
X-Gm-Message-State: AJcUukee9Hsbm6G9UALGSsVYHRpVJWsCOtBoahdaLQKfiR/nNtqgNUne
        ezWK2kDK5BiqNMOmui/ZWxekpsK7
X-Google-Smtp-Source: ALg8bN6QxE/I7tT/nzbbWGOnG8Dwvxg5yNNK8VBD7IX28bBANrD3TQMGwmnDMPpjs2aWfbCBCUmQOA==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr2890421wma.123.1546984360057;
        Tue, 08 Jan 2019 13:52:40 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id r77sm13489177wmd.22.2019.01.08.13.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:39 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 5/8] checkout: clarify comment
Date:   Tue,  8 Jan 2019 21:52:22 +0000
Message-Id: <20190108215225.3077-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190108215225.3077-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The key point for the if statement is that read_tree_some did not
update the entry, because either it doesn't exist in tree-ish or
doesn't match the pathspec.  Clarify that.

Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..cb166b2e07 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -304,10 +304,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 			continue;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			/*
-			 * "git checkout tree-ish -- path", but this entry
-			 * is in the original index; it will not be checked
-			 * out to the working tree and it does not matter
-			 * if pathspec matched this entry.  We will not do
+			 * "git checkout tree-ish -- path" and this entry
+			 * is in the original index, but is not in tree-ish
+			 * or does not match the pathspec; it will not be
+			 * checked out to the working tree.  We will not do
 			 * anything to this entry at all.
 			 */
 			continue;
-- 
2.20.1.153.gd81d796ee0

