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
	by dcvr.yhbt.net (Postfix) with ESMTP id C27C61F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 13:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfJ1NFu (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 09:05:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35570 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfJ1NFu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 09:05:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so9809178wrb.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VGqYcXIcTL9Sir/TrpJhgTI680UpEeN7NyqzMTgvVvw=;
        b=GTAzELOPbgQK9FNcd1P46BGG18T8opc1M9mf/NW6VXXa0OkntKfFkqZpfxPMVPgFWy
         Nv6YIUWlg56DI83R8k58TN1XNtPxoSyQMm9Ve1/EFHqKDOOmfTtKVi3u9thzowwAvaBl
         pFtPEiMBKHheWzZKlIkbl5SXKGToVfalack5pbte4wH13IpOY7Nz6nZ4t3Ysp+dUGbM3
         PRh7iUIRB9pl+nuzwiMdn3Zl7u1ZQp8mU6iZnirxhPGUlG1CnzIOmWaMxsdJd0IME/QS
         B/s/nCIiH1aBe+OSMcWDV6KaCed3ogl1Am7Q4LGqj4920FTifPJZiz1Q3AFAjrXTx8k+
         gauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VGqYcXIcTL9Sir/TrpJhgTI680UpEeN7NyqzMTgvVvw=;
        b=P2y3ij5jDmz2PBslzpnO9boJdDK0CoFdoMCckBBQjplDDvN+f9/3ZNf2R1//m+zNT1
         J6xfa3CobCGYD5MYWyQsazN90EA5ePUMaWe3yvSCJ66AOpyBWijbM+X0wMbsDZ2ljXYW
         YFOzlNYTiGjdyqjLqWp6HvK+yWJCAXr77ZqM9lDpCv5KqS7tbdxUWDDy5SrHeBUP+yF/
         O6G4Uxp3qEvxEaIYPG3iQEpuKouCvxVIxJWIGx/UgKTq4HTyaDTHnBJkHXI6VC0R9R4y
         rBBd8qqvphL8xf6GNCZWYpM91MQuzrdpxvVP2gn0Q7s//oH+9BsH+sulD7QvNPbbmz2H
         EzrA==
X-Gm-Message-State: APjAAAUjsjMCK8DJ1EkjtRBxoqz9svA66g/TQePMTCLdm/FGIWOFlbW1
        mhKV02FBd2FjY/UE8fmetBudrl6F
X-Google-Smtp-Source: APXvYqyAHYezrt1lSN0x217YCn7KQ5EP93T+bk3ZYJaYQ/FUur1P66eT6vgRZDbTszvdT/MIAfoRxw==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr15954594wrq.385.1572267948320;
        Mon, 28 Oct 2019 06:05:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a23sm4983840wmj.2.2019.10.28.06.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 06:05:47 -0700 (PDT)
Message-Id: <8026c7e9ab2f60af770fa66097d3220259201d8f.1572267946.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.433.git.1572267946.gitgitgadget@gmail.com>
References: <pull.433.git.1572267946.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 13:05:46 +0000
Subject: [PATCH 1/1] help: add gitsubmodules to the list of guides
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The guide "gitsubmodules" was added in d480345 (submodules: overhaul
documentation, 2017-06-22), but it was not added to
command-list.txt when commit 1b81d8c (help: use command-list.txt
for the source of guides, 2018-05-20) taught "git help" to obtain the
guide list from this file.

Add it now, and capitalize the first word of the description of
gitsubmodules, as was done in 1b81d8c (help: use command-list.txt
for the source of guides, 2018-05-20) for the other guides.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/gitsubmodules.txt | 2 +-
 command-list.txt                | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 0a890205b8..c476f891b5 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -3,7 +3,7 @@ gitsubmodules(7)
 
 NAME
 ----
-gitsubmodules - mounting one repository inside another
+gitsubmodules - Mounting one repository inside another
 
 SYNOPSIS
 --------
diff --git a/command-list.txt b/command-list.txt
index a9ac72bef4..72e435c5a3 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -203,6 +203,7 @@ gitmodules                              guide
 gitnamespaces                           guide
 gitrepository-layout                    guide
 gitrevisions                            guide
+gitsubmodules                           guide
 gittutorial-2                           guide
 gittutorial                             guide
 gitworkflows                            guide
-- 
gitgitgadget
