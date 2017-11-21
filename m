Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730CE2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdKUX1q (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:27:46 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38175 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdKUX1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:27:45 -0500
Received: by mail-pg0-f68.google.com with SMTP id s11so11440443pgc.5
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWzkhNZNkScMiEZwxi8htCjIrC1tKhr9lXu/78x8nTY=;
        b=ufIkrYtH5V2zTgberQAhXmmg3qZ/kyKz/haeNLqU0FKO6WgyD7MXfztN4U4KfRxyFb
         bHxolT3ngzlgZk8KGLNNUZF70O1MJbdDA8Sx4EODnhRXsuaD3LUMFL290NukWbnbQAjJ
         U0aSmWPyoeNNj1RBdAvrAIuaQHj0x+u7x28VnkfCc2b8kLX4JWUTMhPDIv12oa/Hb9IA
         m/rdcgLYDgn+TprQXU0kR+iCZ2DNAF99BhndgHqyq/kYl85DnH+ktUZXtv67+ULqDC1T
         3PXGSEl0/pxzDpNtlqB2V3fPx9MraJRuIT6Axm14GahmHjgB4ql24NcU3PQW1kY8/q89
         9/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWzkhNZNkScMiEZwxi8htCjIrC1tKhr9lXu/78x8nTY=;
        b=QBh9UIO4Itomb5xwiX936yiCDxf+ffbXa8SwZBvF6dqx2gwMKfNw7KMf0jnpcpyHhr
         6rpo3jfgEWvJH+mog3/QlELMRlVZbq25FO+X39sue/e+xIwDh0aU8c9mS0KLLbexZg9n
         0AY6TiqNqg5gqAZIGYsu2RMUPQH1YaIWvybs2ZvSfZXxUaAWcTd4m45gyliKeEjQ9Q86
         6gxKSphdL4PMi/mNqbY+oEBUKbzP+89Y6Fyxi16o2RYwgkRjpyc2lRxYPEYKj4nwzD5r
         y5ssU/Clly39PAx+26AANGcF9jKmMI1cJV9HYtia3rYyyeZxhMwp08ZMYMaTVdOwir3j
         gmXA==
X-Gm-Message-State: AJaThX7WZ/ivv6rBdklV3EEF2/dutlLYMuTzq6PO2mjiQh9OFieBgQCl
        MtJkF3XIJvUibE6JU15MqqUw/4hy
X-Google-Smtp-Source: AGs4zMbYAQV59mvtrm7qvxO6ukAsP84/zpqbMQQJcSY68Ne8Kfxw036WRC1TJjOZC4Ii+EEl7MAyRw==
X-Received: by 10.84.174.129 with SMTP id r1mr19669324plb.337.1511306864641;
        Tue, 21 Nov 2017 15:27:44 -0800 (PST)
Received: from phord-x1.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id r18sm22829004pge.87.2017.11.21.15.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 15:27:43 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
To:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>
Subject: [PATCH] doc: prefer 'stash push' instead of 'stash save'
Date:   Tue, 21 Nov 2017 15:26:43 -0800
Message-Id: <20171121232643.8380-2-phil.hord@gmail.com>
X-Mailer: git-send-email 2.15.0.471.g17a719cfe.dirty
In-Reply-To: <20171121232643.8380-1-phil.hord@gmail.com>
References: <20171121232643.8380-1-phil.hord@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `git stash save` was deprecated recently, some parts of the
documentation still refer to it.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 8be661007..056dfb866 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -175,14 +175,14 @@ create::
 	return its object name, without storing it anywhere in the ref
 	namespace.
 	This is intended to be useful for scripts.  It is probably not
-	the command you want to use; see "save" above.
+	the command you want to use; see "push" above.
 
 store::
 
 	Store a given stash created via 'git stash create' (which is a
 	dangling merge commit) in the stash ref, updating the stash
 	reflog.  This is intended to be useful for scripts.  It is
-	probably not the command you want to use; see "save" above.
+	probably not the command you want to use; see "push" above.
 
 DISCUSSION
 ----------
-- 
2.15.0.471.g17a719cfe.dirty

