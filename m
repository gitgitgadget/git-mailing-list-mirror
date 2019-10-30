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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF6B1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJ3UVZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:21:25 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37460 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ3UVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:21:23 -0400
Received: by mail-wr1-f50.google.com with SMTP id e11so3804775wrv.4
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pyGbAJvzgx8m7LwlK/SliRNpk3nu7o4avnoxVygbQxM=;
        b=YnQ7ly7QLMaPHJWuHROsUnEnbPHiMjfQzYp9LBFjUk5wQjsUel+ysqWQeYqdEeQyhZ
         nINfrfxyf2kz43Bvz0/Slr9Cas/KGpjKn5L0TMMv0u7Mj/L7EUF0ZH0INppP4F7JVnkR
         2gKfU9PCXTIW0EfhCsZJ1+Gvm5+5GNBIgi3AGZCRVaWf6JU354Ua0jNFQHXTkafBbzzz
         mTA4l9Eskj5/Rlp/ca/tynfbxGnwtzdbGnAnBxWEWgy7fkF8f4dMxrlIn0az6ycuW9Kd
         07AYxkntWwMdOy3g8ISwyhZoyJi8KXh8QZth6wQGIzupHwnh5Ojp1nKnKraXZXwbhseb
         OSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pyGbAJvzgx8m7LwlK/SliRNpk3nu7o4avnoxVygbQxM=;
        b=GMWp4cbGn/8XVh1yb11z521SvadLmRc5Utk4FYkvg13++Im4h8yFahZYEUENfvHEz3
         UNrYvj9/Nn5sM9VOdU/V2wwMiB+ZYVb/0jJO1bCUG9224l/zSokrG2Abf3BVf6Y62Q51
         KJ619Pxqd4b6Gvkrs7p321r584hdInoo0gcX/OKTiXxUcDnSqqKFI9vvEKdECWZVD0Z3
         NcVmcF1DkBsfq4Zeq+8jSuwyyu8kNMg+0YVsY92TDwpokEAcHDel118G/mvhNXCmOefV
         5LFwzeWfdE8mCLczHcFb/e2RQsjCjAoj/Fq48KHqwkWCTb2q/ZZtdgrjLrK/U5or2kxp
         UVug==
X-Gm-Message-State: APjAAAVR7YnJYCPDbv5St9twH81XT+wEU2OXwMk5r79T7NWx+GpymBiG
        cSRXvqanRtSZQ5A5MExZaub2ZSSQ
X-Google-Smtp-Source: APXvYqwqRGRKANTnEOdwCtSe05mT1O2lWf7USrpJekBeix4Re82KtycsNbCqaAPMk7tVRMTYTg+jOw==
X-Received: by 2002:a5d:6747:: with SMTP id l7mr1613093wrw.328.1572466881242;
        Wed, 30 Oct 2019 13:21:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm1440965wmd.11.2019.10.30.13.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 13:21:20 -0700 (PDT)
Message-Id: <0f3aa67e4aafbb7befd37d83a8c0d53a0a186259.1572466878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.440.git.1572466878.gitgitgadget@gmail.com>
References: <pull.440.git.1572466878.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 20:21:18 +0000
Subject: [PATCH 2/2] RelNotes/2.24.0: fix self-contradictory note
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As per Wikipedia, "In current technical usage, for one to state that a
feature is deprecated is merely a recommendation against using it."  It
is thus contradictory to claim that something is not "officially
deprecated" and then to immediately state that we are both discouraging
its use and pointing people elsewhere.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/RelNotes/2.24.0.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.txt
index 26e018078d..bde154124c 100644
--- a/Documentation/RelNotes/2.24.0.txt
+++ b/Documentation/RelNotes/2.24.0.txt
@@ -6,10 +6,9 @@ Updates since v2.23
 
 Backward compatibility note
 
- * Although it is not officially deprecated, "filter-branch" is
-   showing its age and alternatives are available.  From this release,
-   we started to discourage its uses and hint people about
-   filter-repo.
+ * "filter-branch" is showing its age and alternatives are available.
+   From this release, we started to discourage its use and hint
+   people about filter-repo.
 
 UI, Workflows & Features
 
-- 
gitgitgadget
