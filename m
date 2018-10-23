Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54241F453
	for <e@80x24.org>; Tue, 23 Oct 2018 01:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeJWJxK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 05:53:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41035 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeJWJxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 05:53:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id p5-v6so4977323plq.8
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 18:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nNQtiuNZMdiUkvsPaSnlxwux6JsX/mvI+mTJcyWJPNI=;
        b=0U4j9STPCu0Cj0bgHXkKSlz/8ANwE0kVhBTibQQsjmRH+wxi1UvT8izLOTG+wTAAVJ
         0WNn5B5KssL7bXbwcvNBIrf/UTztovbel6vK2pKQSBYuLJ0l6HPmykBu0H2ZTdd+bQU5
         xUs9eOIrETETSvavqtyK5MgudOGA1JTFZIJeuqk2wA6fzvf2AbUUZLv6SXkIJGE3Z6MA
         RZmb7tHokrstWW0qAaMkuNQBrAZK05dT+ynRrPXlYDq/OHhIKtt9JtEitoHVo6COHV8H
         BZxIrmTTi5awk4WL5nMJ4h9CzGhF+JPhrmF9gbGsi3caAgqfgyhKTLWqafIjNdbNU48a
         FLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nNQtiuNZMdiUkvsPaSnlxwux6JsX/mvI+mTJcyWJPNI=;
        b=EG9H03AQswfA0TNmT8mROkANjFdQWbZOARNYeJApD1Kf+wj5ahAQ8t51rBTZ9x1CSN
         hTx6EGcfnKgu2xAmpssa0THBmBJoyjXNy8ppqH6/XeDtzqzNS/6C2v7XOYWL0tRBLvoU
         VwhafyyIaohKxQFuECfRWycAw1AxGbPRHiuSYIFfZRCRVvkKLCX0D6cU/bRmy/UvZE2T
         knmjrlbHz2I0TAuMD1yGxD/S/lui0HIDRuFCd3w4MXsvfQUufc1mrwffFI8RAWXDI40o
         NUlPj5PdvsIHG4jawaDyfxu35pjqeFGxkDPOisDQC4Up4Sj0NU956ge45fAOC2UHlMTa
         bDMw==
X-Gm-Message-State: ABuFfohYsfQlYRG9PH2pJGjBioRe3j62GYVYV2a6eBOK68it5qS/uuoi
        mCeR7e5co3x2ZDr3v7m/eLnUSAscFcw=
X-Google-Smtp-Source: ACcGV61Vc67PGZIWSLK8bTejCeeOCdvW8utOksz+0ZjqLa32z+Ai6Am2Fz/RlBTAKNjKkw3Jx0tr+A==
X-Received: by 2002:a17:902:744a:: with SMTP id e10-v6mr13523258plt.61.1540258326529;
        Mon, 22 Oct 2018 18:32:06 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:6428:e3a4:a944:bf94])
        by smtp.gmail.com with ESMTPSA id x13-v6sm51912764pge.13.2018.10.22.18.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 18:32:05 -0700 (PDT)
Date:   Mon, 22 Oct 2018 18:32:04 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH] Documentation/config.txt: fix typo in
 core.alternateRefsCommand
Message-ID: <6aabe7201dc81b98e404010b441fef8d582b0232.1540258140.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] Git learned about 'core.alternateRefsCommand', and with it, the
accompanying documentation. However, this documentation included a typo
involving the verb tense of "produced".

Match the tense of the surrounding bits by correcting this typo.

[1]: 89284c1d6c (transport.c: introduce core.alternateRefsCommand,
     2018-10-08)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---

Note: this can be applied as a fixup to the commit [1] mentioned above.
I'm sending it as a separate series, since the patches have already
landed on 'next'.

They were originally introduced in:

  7451b4872a0fd66d84cbe492fdfe7a9a8e81eab7.1539021825.git.me@ttaylorr.com

I think that these will ultimately conflict with Duy's patches to move
Documentation/config.txt out to separate files. It seems, however, that
he may re-roll the series beforehand, so I can either:

  1. Resend this once he has landed his changes, or,

  2. He can re-roll with this version of Documentation/config.txt.

 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 552827935a..09e95e9e98 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -620,7 +620,7 @@ core.alternateRefsCommand::
 	When advertising tips of available history from an alternate, use the shell to
 	execute the specified command instead of linkgit:git-for-each-ref[1]. The
 	first argument is the absolute path of the alternate. Output must contain one
-	hex object id per line (i.e., the same as produce by `git for-each-ref
+	hex object id per line (i.e., the same as produced by `git for-each-ref
 	--format='%(objectname)'`).
 +
 Note that you cannot generally put `git for-each-ref` directly into the config
--
2.19.0.221.g150f307af
