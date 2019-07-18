Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91191F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390467AbfGRNTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38531 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390440AbfGRNTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so28683328wrr.5
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tou9s6+lKBEd+336v5AuGx7s+2YDAAuPHyoFqMGnXRQ=;
        b=WfhQ8RIckQrezGR2weIw4A0Hvt3FS/TENZ2wyuO1pkBeo7ypwEBypYXZ+o3GZAL30I
         TXBULrFGysmE9EJZ3CXKxbf0+ISz+XJCKluhMpxkcTBQXqQscZ8DzpaR4zDEZ57set/K
         Md/mJqzRbDtvY9Vsbf8N+Ij1LnmOlB/ZlhBlWrACFw3lXuhsvo/6vbTfB5I3B1o86BA1
         /FNIzLO1WskmzvZgj6RwLcp3+h4DSZwynEkLW5DZUJCeeogMjA7k8JwVZ5GGlN11aB8u
         c8lFFlxzrP75q7Mgqa5Vxs8JJ5thwvHdftd11l2ljGfN/1jBJVfZQ1YfdamdxFF5NKu8
         3+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tou9s6+lKBEd+336v5AuGx7s+2YDAAuPHyoFqMGnXRQ=;
        b=iileme3iYu0nULenZCOSDr0SYJ++QLMtwbr2JanBaRkEPRiMf3zmhuGNcvinu4Haj+
         niSDV0I91Ji2dil21IIJv5NXXEt7qk4/rfMgPlbNi8EAVc3i2h+LRAHEnshFQQDjvYBT
         xRB8eqPOu9KqYHwH06fs/mIIeUB7LxPqv4lCn5GD2///XImDZorlDkboSTUiHSWPJ3wb
         kN/GnExAGqN9XkTAEtmcHJJ4+Zbc3h3oZyExdFnFWtfzGnwWGZFDcKNEx6S4SleO+vJP
         cca/YzhT1SSU7DQ9FBG2CXVueMhQVKzN+SYneIPolff/iX4V0DY5MBere5m16/PGU8Ok
         /WUA==
X-Gm-Message-State: APjAAAW6EpNycu+biqX5pLNGteITY+hot7okWNaceo/mvKrLiGgi6iGr
        GZZIWIK0JztdSmEe2BuR+SEcRaD6
X-Google-Smtp-Source: APXvYqyKLdc667j5nK5IIuZUnHaztdvK+2Y62U2uED8Vq6tu+W4df2XQwc8NBDHT06SiHrIuBd7KLw==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr51219347wrq.29.1563455945336;
        Thu, 18 Jul 2019 06:19:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm31440792wrx.19.2019.07.18.06.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:04 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:04 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:41 GMT
Message-Id: <60a45f26948989f928ca439a2860433c0f08f412.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/24] contrib/buildsystems: ignore irrelevant files in
 Generators/
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

The Generators/ directory can contain spurious files such as editors'
backup files. Even worse, there could be .swp files which are not even
valid Perl scripts.

Let's just ignore anything but .pm files in said directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/Generators.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/Generators.pm b/contrib/buildsystems/Generators.pm
index 408ef714b8..aa4cbaa2ad 100644
--- a/contrib/buildsystems/Generators.pm
+++ b/contrib/buildsystems/Generators.pm
@@ -17,7 +17,7 @@ BEGIN
     $me = dirname($me);
     if (opendir(D,"$me/Generators")) {
         foreach my $gen (readdir(D)) {
-            next if ($gen  =~ /^\.\.?$/);
+            next unless ($gen  =~ /\.pm$/);
             require "${me}/Generators/$gen";
             $gen =~ s,\.pm,,;
             push(@AVAILABLE, $gen);
-- 
gitgitgadget

