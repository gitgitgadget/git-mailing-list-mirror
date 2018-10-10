Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067CD1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 11:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJJSfq (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:35:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44763 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJSfq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:35:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so4532922edb.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEeYCHJ0/sOxKB2348WvjzSm3xUrWiiQDDIhRAWGsok=;
        b=QaS1jMI8+ye+a4QhVG0NUP6VsLULG0ZLsR397mKXtVdumOyIKDcSt1v3EOs4HlsaKP
         2Mdk06RKdjnpyTwAxnL6+CACFuHJThMJJeYUlOIRMcWyrNem8x1c8KAuKc1OEMx3A1v8
         X899/dKd9Mz7NOgzEVEEWI9+eCksSDwq9mI24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEeYCHJ0/sOxKB2348WvjzSm3xUrWiiQDDIhRAWGsok=;
        b=SHYHfxGSRAvQKrXFxrdM8GkFsVcC5huH7HegDEys469bhFDXXZQ3yhlCXxEw27L//l
         BIow2k3bOLHrSjL4UI+0aXI7x2/aT/SsJQA8qOkaOBy237X5ZmgmHerm+g/icNt3fk6Q
         4NnNUj1255+x4jGwGqNbav+Eh9BpC2CMM92zUceyWQyr5mRUkCxK4Rz7q5Ia0kSSz/Uz
         sNZGoO2jv1Z85aXUkBw7lP+dvfZr6Fpdxu7yXR5Ag7Tw0MRCcQZXns+XkTndJe0EdU+A
         13t8hx/z/3y6bFlI6bBiVGT+YIBCK5127B2s6Ah/u8R61X9FuIgYjWyD+G/WjIdg0WRd
         ggWg==
X-Gm-Message-State: ABuFfojNIw7edUH1dklu3yEuljwpLmeUZJQz9IElaEjVVh1r4mCw6zdZ
        UiyhVemAybYEK26BBH0uy2DXZr1a89w=
X-Google-Smtp-Source: ACcGV60qfEu2qAvFkL2V6Ff+Viq7sXTsduuFopttZ7Wt2KMY4say0MmSaLx1Cr2l/awD2aO4+71jrA==
X-Received: by 2002:a17:906:c28f:: with SMTP id r15-v6mr32539521ejz.188.1539170044505;
        Wed, 10 Oct 2018 04:14:04 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id e10-v6sm4154596ejl.25.2018.10.10.04.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 04:14:03 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 1/3] Documentation/git-send-email.txt: style fixes
Date:   Wed, 10 Oct 2018 13:13:49 +0200
Message-Id: <20181010111351.5045-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.g084f1d7761
In-Reply-To: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For consistency, add full stops in a few places and outdent a line by
one space.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 Documentation/git-send-email.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 465a4ecbed..ea6ea512fe 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -321,16 +321,16 @@ Automating
 	auto-cc of:
 +
 --
-- 'author' will avoid including the patch author
-- 'self' will avoid including the sender
+- 'author' will avoid including the patch author.
+- 'self' will avoid including the sender.
 - 'cc' will avoid including anyone mentioned in Cc lines in the patch header
   except for self (use 'self' for that).
 - 'bodycc' will avoid including anyone mentioned in Cc lines in the
   patch body (commit message) except for self (use 'self' for that).
 - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
-   for self (use 'self' for that).
+  for self (use 'self' for that).
 - 'cccmd' will avoid running the --cc-cmd.
-- 'body' is equivalent to 'sob' + 'bodycc'
+- 'body' is equivalent to 'sob' + 'bodycc'.
 - 'all' will suppress all auto cc values.
 --
 +
-- 
2.19.1.6.g084f1d7761

