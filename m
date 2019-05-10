Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4241F45F
	for <e@80x24.org>; Fri, 10 May 2019 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfEJShH (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 14:37:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38275 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEJShG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 14:37:06 -0400
Received: by mail-io1-f68.google.com with SMTP id y6so5283675ior.5
        for <git@vger.kernel.org>; Fri, 10 May 2019 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqBa/A8KQ9SQDHOYHmHjxeXA+N94N3CocdRQbsTHBzs=;
        b=QFPdpodJ08hA87FqXO+Ch/kpFXAUe8jhw4QrHSayPQBm3Rc10rdjE7Q8GYFAfDMXY5
         MzbIKWT7Y3l2CSjypIUxO11/KFtqS+CzD0M+Z/peki6sjvTk4nJEXKNQ8A9nRaeoXsGB
         RFHMjiaedlVbfZwIcuZnkcZ/C8RSaFGnC/eL4CKXpXFWwDBODn4Cxx3LfbmFaNtMJTid
         NKSyRBjPCJIztNxrIFElWOwV0AdOqWwzsvzOJZy3JZzCKlZ2XkgSSM5BixK+NyrHdQP0
         XiG15MkqEItMs1n839puO1dnS7sEgBlSK4KkK0nbqPb3PP9Pw/1LC3bC5ugdqBmidSZG
         MFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqBa/A8KQ9SQDHOYHmHjxeXA+N94N3CocdRQbsTHBzs=;
        b=bbZne16ZUob7uhpDCNsvLC2yA0iG8obNm8WA97h0PDB7vdL9XJAZJA9XfzM7rm1tNs
         o065C7cveMMj3pwl8HnZz+K8D1NM9XtJV7KKwZn2YP8sQTBthhzZEoXKJyynHI2+Hyvt
         mLmsKnRSo8XRzTajv/tEfb1/bx+5x42zfaX7nLYF3RdRunXQju9krDOWvIttohWf82la
         ZIUtF8WTfpvWthqGKWECBoZAwuwu2WEnNLwwYmw+qREfZGNYkoVS4BLUmxzwh1/179Q2
         fC2QexLSmtD8HEYWYdG1Q2O8Eos1M/PIqteVeap7Rar4H6RaJ4lfHIbaiyVaYfQf5pfn
         fXkg==
X-Gm-Message-State: APjAAAVCxcIhehkpNzfoxSsR/RbD/cBDqYc+4MSt07nVvKg+tiyCKSK9
        jAHp9vE64K9OUx3JaDhmuJJP9Lkk
X-Google-Smtp-Source: APXvYqz7Ei0vVcPZChMD0b/G8tdXoOQU5/35oGvplB8r1FXLoga1vKPcptfIcbJBD9LPuHugCLzfug==
X-Received: by 2002:a6b:fb03:: with SMTP id h3mr7810309iog.248.1557513425622;
        Fri, 10 May 2019 11:37:05 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id q10sm641573ioi.52.2019.05.10.11.37.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 11:37:04 -0700 (PDT)
Date:   Fri, 10 May 2019 14:37:03 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 1/2] git-format-patch.txt: document --no-notes option
Message-ID: <4c3535f25bdffc8d94617c74f7c078cce59a044f.1557513353.git.liu.denton@gmail.com>
References: <cover.1557327652.git.liu.denton@gmail.com>
 <cover.1557513353.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557513353.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally, git-format-patch uses the `handle_revision_opt` parser. The
parser handles the `--no-notes` option to negate an earlier `--notes`
option, but it isn't documented. Document this option so that users are
aware of it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..2c3971390e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -22,7 +22,8 @@ SYNOPSIS
 		   [--rfc] [--subject-prefix=Subject-Prefix]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
-		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--[no-]cover-letter] [--quiet]
+		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--progress]
@@ -263,6 +264,7 @@ material (this may change in the future).
 	for details.
 
 --notes[=<ref>]::
+--no-notes::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
 +
-- 
2.21.0.1049.geb646f7864

