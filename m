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
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B4C1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 18:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfKFSvp (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 13:51:45 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:52020 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKFSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 13:51:45 -0500
Received: by mail-wm1-f41.google.com with SMTP id q70so5009220wme.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 10:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u5aIQL1obfylvb82XDx6BIT7vHYpcS4b2QZUWAuUFRM=;
        b=msb73YZnHxR2s8Tf5mYOUBS32tnKy1puyORIcN1D7h0yWLFtWaADkHm+ZOfY83N9ry
         cHuakjnSpDZ/LDoPvtzp3nUT5NdyDe/8YzJTlTas6ZF0ZC/VA/nJVpeZQyL9CgC1MA+h
         ZebrkKjmKMJ4/tq9HTa5mW44F5f0aAKrQFuHTx5bBUvSRnPFfsXfofkMuwgxx8Xlhi4c
         cuvwPKq31Lj7Y8CSKgHHExTwHndOFY1RiFPaNavKiUraLqi0gRFDrPKeti8O1A/wPHxa
         vPOl//u8e05HC2MOxb6nwxraYN5lOI0iLoFAPTiFq9VrbfUU5jDbdB51sXzffdotT6lO
         FchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u5aIQL1obfylvb82XDx6BIT7vHYpcS4b2QZUWAuUFRM=;
        b=FRexgRo5MVyv9uzKQ6IEqAdwxIoOUjqVA9AnpNhQhcPfpC+phqrMU6yiWr9PLLApIW
         38GdDGYBp36+F+XC/USu1NGw4NIrty/bShGdwPpGFPuNBh57sjm6//rN/MKpQE7B7mo9
         7YjePZeZnaXY3WPC8cTaDaC5M36GFCDhzwLhLXoUKYda6Cq7X458QCCsUVEJuwh92cNS
         sipXTnQfZFy8WP3+xB9SkzAG4WBikvw3p3fYEoUPTguTyq4DSPBpVsnynUllFACyGO6Y
         XONiTSE/n2G3kV4iBzNS0CFr0plTJ4i2LbZXEqsiHHgyzN2+hkWOOFB95J4niZ0G/dj5
         xuwA==
X-Gm-Message-State: APjAAAV/yQ5s2JvW+E5oHRBQKSRXdQt2J6qIIbMytKj+Shg5TvVgjqxO
        5BarA1C4tasJOyMjj1+5RBg8an6/
X-Google-Smtp-Source: APXvYqyqJfMb8FCQp6pn+O6WApfJ7CY5wDiF51GQMLPrLRQLsxsFXzK5aTyctPuEIfTze8GygGsawA==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr3821969wma.166.1573066303128;
        Wed, 06 Nov 2019 10:51:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b196sm4206302wmd.24.2019.11.06.10.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:51:42 -0800 (PST)
Message-Id: <606756d7db834b8c16df6bad9a90c559a2fde1f3.1573066300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
References: <pull.451.git.1572981981.gitgitgadget@gmail.com>
        <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
From:   "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 18:51:40 +0000
Subject: [PATCH v2 2/2] add whitespace
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Erik Chen <erikchen@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Erik Chen <erikchen@chromium.org>

Signed-off-by: Erik Chen <erikchen@chromium.org>
---
 fetch-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index f2f3365bbe..5e3eee0477 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -666,6 +666,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	struct ref *ref;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
+
 	save_commit_buffer = 0;
 
 	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
-- 
gitgitgadget
