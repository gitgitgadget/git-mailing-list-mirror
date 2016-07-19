Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940B220195
	for <e@80x24.org>; Tue, 19 Jul 2016 23:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbcGSXpV (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 19:45:21 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35439 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbcGSXpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 19:45:18 -0400
Received: by mail-pf0-f170.google.com with SMTP id x72so12130116pfd.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 16:45:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eCM7K8fN/uk7TP3zm9BLIgadXzubwFe++9EfIScTVRk=;
        b=PuCISpw+cYscOWdkcE9932VD/yjR6iiqVPOzdY3wSgiIBk/WxaxgmN+/R6G3buoufp
         NCp7nZiYky/Tus+jR14+L3fcGSZKlZ6IGOsns6aZlti7ONifoNxg07yFWhjjVOKRwQA1
         qVyC5BIreUk5ZmQpnOydzD1QE39Iz3Qf+YYy7vpRfiZtO6dWOQnhgTFoyohMq2L/UX/F
         WApEQtv0RPDTWdJgUoxQg0hVNjjDhurIyfW9hZASRftJ9N6QBgYkRWnpU3DEIjADGz0v
         RFHUybZwLTJvaXA4t+TClQvvb6ewFh92Rvih7ZJmMRUBUHjMZId8h5/+jWVLtB/oqe8X
         2q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eCM7K8fN/uk7TP3zm9BLIgadXzubwFe++9EfIScTVRk=;
        b=jwawMFTr3x+J8ADfFcWRcOo+Q0Z71dGIQI6htVZOPwbOR2tx5BtocqJBob4z/Mgq1V
         mnvv/Eny7VJGZo6HoiCQsx3dxidbQ/QyIHHS34EAtserSeVf7a8dYg62cRlnIRLfaX7i
         nti/nEXMxIlR3BTsHKF6xnL8be+ZlUHfBpxIXVftmmZpwjkxVIy1mthphQ9Pyt3SKcjU
         NqBNe1VJkaNNlnwgR3d2ZXoTYkLrg9loZFnGjvy0mCWZ5/ufdlhVvRvpSDo/fkcw3R9O
         g4exD5irWGoYvcWi8iWHgL+3A+uLqwWmNqEC+oEll7dTw1aVc8RR2oMF39ejWSoEwqbv
         IMUQ==
X-Gm-Message-State: ALyK8tJ+5MHvuHzwdvq9Hm6eQcD3gC2/qyDW0EpMscYR1D7PrcQV0RWMQOdIfmuyDUa7uXse
X-Received: by 10.98.87.138 with SMTP id i10mr55486199pfj.16.1468971917100;
        Tue, 19 Jul 2016 16:45:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a840:2a83:b798:f277])
        by smtp.gmail.com with ESMTPSA id 18sm7331864pfn.33.2016.07.19.16.45.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jul 2016 16:45:16 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, larsxschneider@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation, git submodule: Note about --reference
Date:	Tue, 19 Jul 2016 16:45:08 -0700
Message-Id: <20160719234508.7717-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.800.g213104a
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Is it too obvious?
 I was approached off list and this was only obvious after some discussion,
 so I think it is a valid warning.
 
 On the other hand this might show that we want to get worktree working with
 submodules.

 Documentation/git-submodule.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bf3bb37..dcbd460 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -373,6 +373,10 @@ the submodule itself.
 +
 *NOTE*: Do *not* use this option unless you have read the note
 for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
++
+*NOTE*: This gives the same reference to all submodules, so it is only useful
+if you are tracking different versions of a project in submodules instead
+of different projects.
 
 --recursive::
 	This option is only valid for foreach, update, status and sync commands.
-- 
2.9.2.800.g213104a

