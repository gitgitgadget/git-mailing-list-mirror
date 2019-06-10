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
	by dcvr.yhbt.net (Postfix) with ESMTP id 486F11F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbfFJXf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32881 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390524AbfFJXfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9so17007298edr.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=Lbuhg5/0PFmm9mNAtCmTIxiS5DkTCQiiLa43xRoD2h1kGiXPhy6fgxdZjDxD5xFkQ8
         D8DjU5n3aAGcRs781GN/aqzOtpvoewsFio1vOll9sVmXITkIAQ8Z8iQICj57gA9GKpsk
         yLvuSbFN5ULlL+s4t5dppqj6AlX0xIs2VwlZNRIZyftBxWHV2xPXiVDqVkOqDeSJ0Lbv
         KdhExin5FA1KhmLVL1qH/cdXE0TvcNu9VCfzEYLiUr50EcDbsOrfm8QKE9flMlTZq/hz
         t5LxNNcdeVgKRN5KfQ8IM3eXyi8ar+JUPf4r5NWvkgPkTmB1B0JKdEJv8Hrdlu3Da5o3
         /51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=FHF+Mu73VW+ci4rALmOvavygQsZsMUYL3aSByp9h5tdi9GnZudU3FAFleI7wAGcii3
         TpY5VIeC6ZJVT3KThO6VujC4PkUIZNHussLU+6NHukM6fP5q9wu5YJmDxAyd3zgmTb+F
         21BdbxIO8AR5QY6cdK7LMMX2A+D75SyDxKhcJwruYVA3TNIfm+dha5+0hZbFTqQ08hZC
         rN8lSX/FsMhYSgbbTMEMEvRHy2Sh/evI2Z66dQ3DRL8aPGXPa+XxxuE56W63Nt1n822+
         P8xQXFg9sg94OtKBYWsvpThvrSivSbmsrlXlSu5VNDK28lk558pGiC9js2d01H/rFhoc
         OA6g==
X-Gm-Message-State: APjAAAX7qPezW+zeK2ewuapvoab8NbxHkLNPNrxOANoPc7ZcMuzyw3Bd
        zNJB67F8g/81XF/JoYsQWIvRXMcL
X-Google-Smtp-Source: APXvYqzHCsrRt0wDyZWUgyfPrd4t8xgTt77HqG5yvCq7e/m7VBGM/SLdg7dCRh4OSihZG9CVU9YVhg==
X-Received: by 2002:a50:95ae:: with SMTP id w43mr48301492eda.115.1560209723163;
        Mon, 10 Jun 2019 16:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm3224948edt.63.2019.06.10.16.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:22 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:22 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:11 GMT
Message-Id: <fe047db57064a2d8dafe5eb1268768cf5c441945.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/11] Docs: rearrange subcommands for multi-pack-index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We will add new subcommands to the multi-pack-index, and that will
make the documentation a bit messier. Clean up the 'verb'
descriptions by renaming the concept to 'subcommand' and removing
the reference to the object directory.

Helped-by: Stefan Beller <sbeller@google.com>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index f7778a2c85..1af406aca2 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] <verb>
+'git multi-pack-index' [--object-dir=<dir>] <subcommand>
 
 DESCRIPTION
 -----------
@@ -23,13 +23,13 @@ OPTIONS
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
 
+The following subcommands are available:
+
 write::
-	When given as the verb, write a new MIDX file to
-	`<dir>/packs/multi-pack-index`.
+	Write a new MIDX file.
 
 verify::
-	When given as the verb, verify the contents of the MIDX file
-	at `<dir>/packs/multi-pack-index`.
+	Verify the contents of the MIDX file.
 
 
 EXAMPLES
-- 
gitgitgadget

