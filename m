Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C291F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfAXVv6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:51:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34960 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfAXVv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:51:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so5850146edx.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=Ss+fVjLDIgnGbjXVxNJczC5roD/KoKIaoIP4BqWf4b2/K9C1tUnKYX+qjWL3Ndl5+A
         7sRU6VEg8vnxD+/ECXOHnvqzsXXM3PpKjEeUcseqwIebFY5nud04a3OYnZ9nmoS8bhrX
         unKTNFZjyqa3vS+kewcmbR1aKHsgRCnMvC7Ll1HQ6m+f8kp1dCvlSRrWRrCGfqpccbct
         zT+rXnh/bG8H6PMX9BT0SE/VJ5yc/6tf3pKEZbsTIfpeBj0OKe99VLJDSjQQyCwadORG
         1DPqrmhNTj35ZIOLj5D0MMYPlquPfjHWs5QiluhzNH7wu0bI7S6lFAOniYVcnUUXda/m
         Ea6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=eIJCptqz8CGGnFUoRympm55zXEjVpgnEODoT7nxf0lFle/lt5PcgtZS/NB9fRMRt/X
         arGvkqu6kR5nLHMVrCy8yw+teqB8oDms3IDjV8GQUth/pX/oNu7arxAVAMXRjADU+YPP
         7hjmOTmyEuHKv1+4zA/e1g/jRN5VbDswYlSrjp6OwdZp3m7JSFR5m8fg5nNbM59Qk7kM
         PRGXdvFmSFGuwnSZhKgGe1esAFUIUlG7tT6xWk2SCT4WdqrbROLBNEFVp5w3/lo8xvpq
         +sao9uk60hr3yiTfN9oDrlQNYSmcEncFuPNSNIAFNUcHhg8sOU+XuWD4dRpquROKTU7S
         zquw==
X-Gm-Message-State: AJcUukf7k+/rt+1fdI4RoST2txt0F8Zhml0Ra8tdm/r8NJF/FO0DWEvX
        8+p8lLO11R+Q3PaGw/iPFUtQnVDx
X-Google-Smtp-Source: ALg8bN4ZvYQ6Sz9q7fwACeniPnUdk7Te/IvZgi2S/Qx+kU7FRZBe3KSYOBBi1RjRuU4S4D8Mtj9x/g==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr8077079edr.203.1548366716055;
        Thu, 24 Jan 2019 13:51:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p30sm11183101eda.68.2019.01.24.13.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:51:55 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:51:55 -0800 (PST)
X-Google-Original-Date: Thu, 24 Jan 2019 21:51:45 GMT
Message-Id: <78867859042eea6318da65e236f903d6102ed93b.1548366713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 02/10] Docs: rearrange subcommands for multi-pack-index
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

