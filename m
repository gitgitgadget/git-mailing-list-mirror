Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDD91F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJPP2l (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:28:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37284 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPP2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:28:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id c22-v6so20313741edc.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gbRzLEm5Vnu9GUpKJ6505F5LBVI1wi7wTqzsEOyec4=;
        b=dIpVPNXD79wePMjGnAUFJkvFNaWy3q/t7wvRWLxvc7f6JObe4JxTGFVNP2vw5GHt7B
         L8jTI4K+ocdo9qZMWc81Psr5hZPRQJ3z2vivGV8fDcJ+HcsBuw6Yv6ic9N3H07UZATp0
         ccHYOHCHzoWth3NMQLCrvU4cllXdJnShQByxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gbRzLEm5Vnu9GUpKJ6505F5LBVI1wi7wTqzsEOyec4=;
        b=WX8uvjvBXJzJudoT5G35OEgjZCqyoOaTMQ9FgNtVwfnAXX+LXE0og5tijAJschHSKC
         qVbXLNZ5+Rs4rOjoJeOa64fs8H9CFAm+/dTIJLgu+aZW5tYw0Fr8+3Cha0CJsLjYA5Su
         jpAEjrBXXvMe9VuyNr7wUsguEPcT7ULi4b7C1LWsocGsXY0FB4dqatPOzqNXbKpTWuhQ
         m3Jpxyv6tGwyW9EWvdQOOBwJ2ws97r5nvS12+DhP2KaDr2hyZp4l62u+6TcxybVY9P3j
         OjaynMEXiF2rSzSav4jpmHIkEiiftx6sp7ZjlXmWyKtAB1R4/uNngHrFEG0pdGxtzPFd
         hI2g==
X-Gm-Message-State: ABuFfoiViEcfP+6rYPOiwkWM1yaYlF+nX4ThYzpTEiqgb23Ow5Z2bQUy
        n5ZcDzK50PSHxSo1I8WJEgO13nvjVrI=
X-Google-Smtp-Source: ACcGV63/cXZHoN1KsJHaK8s3AwEo1RFw6LrktmD7ChuA+UMtLDKnMhxbZ83N49C0zWmAT28zIeSXew==
X-Received: by 2002:a17:906:c19:: with SMTP id s25-v6mr15401777ejf.140.1539675572604;
        Tue, 16 Oct 2018 00:39:32 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id q18-v6sm2774661ejr.8.2018.10.16.00.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:39:32 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 1/3] Documentation/git-send-email.txt: style fixes
Date:   Tue, 16 Oct 2018 09:39:21 +0200
Message-Id: <20181016073923.28134-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181016073923.28134-1-rv@rasmusvillemoes.dk>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
 <20181016073923.28134-1-rv@rasmusvillemoes.dk>
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
2.19.1.6.gbde171bbf5

