Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B96820C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbdLCWSF (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:05 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40471 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdLCWSA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:18:00 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so2266972ita.5
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gz3xiVv3ISny7uecT9Un1VWPgaDxV6S0PNjIfuAyhBk=;
        b=JB18zvLKwW7DZkw+wKL1JX3S1E5ZF+LT5yV98qUH10F0yHSkxEehwJEKKhgO8pRU9o
         W75vh9IzAbiVVJNNmCfmo/wi4jn3MOKb+e5LGuoa8JUuV8nn9WKW/WUVJH9IYvhNV5y4
         5avY3/ugSbu2Mh9LRJrzKsutvloSsVBqi1egAyzou4JEtmIPE5rrruRzouWhPx6jAH1b
         itHqkFX+xR0e1vAKv/xvk/zaeeIMch5tUpqtedpJk+U2ASWulsaDn880AvYmegpENzLj
         NbzsgzYOIRmQXLByDV2z5h3ceMP8DXKozEfh7fHAcWwOUeA+xmeMHUFBD6f97qyw2YFd
         GNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gz3xiVv3ISny7uecT9Un1VWPgaDxV6S0PNjIfuAyhBk=;
        b=VBPjBiE621Lo5/y8kiuxdwegHIW0r91pXMYb61jOMEq3hjsEyJQ42EWsp5STQbd0Si
         Gv/5/fgo+7YxXBGQxgtsQrRT7KVZmW3zG+pvQvgy9Eg7Y9G385IVbR4mkLWmHXkO9A0d
         NFfT2m8Swj09ztwxmTGjs3fD9OenSUGiZoaUucENW53Rf47qow1rij7Y+QMNlxTC4Tob
         FQiCl9zvZg3WsCpt5PsSfVJmPq81BTalQXHeQLkIL9H2gdnOnM60a2ld0mo6+oGD81MD
         euG9RVO3Nfxr1dBCjHWDckpTzHlvOBQGeR562ksUzB+Cx51wKKmHg6NLdje2khk23d7r
         eLCQ==
X-Gm-Message-State: AJaThX657Kor6ZuxDxTbHVyjxe/TcLQlaiezBzUhmhgMiDad3MeNecuO
        AcYPqieK1JMcylDMEq+4xuwHl3bM
X-Google-Smtp-Source: AGs4zMYZtv12jAmfMgex6xGxvBbOv5w7jBVbnqzUaYya6YEeEALs5JSJbCaaGotFCOHrXCacNzl4jw==
X-Received: by 10.107.180.23 with SMTP id d23mr22278005iof.44.1512339479492;
        Sun, 03 Dec 2017 14:17:59 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:17:59 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 2/9] Documentation: use preferred name for the 'todo list' script
Date:   Sun,  3 Dec 2017 17:17:14 -0500
Message-Id: <20171203221721.16462-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use "todo list" instead of "instruction list" or "todo-list" to
reduce further confusion regarding the name of this script.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/rebase-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index dba088d7c68f..30ae08cb5a4b 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -23,10 +23,10 @@ rebase.missingCommitsCheck::
 	--edit-todo' can then be used to correct the error. If set to
 	"ignore", no checking is done.
 	To drop a commit without warning or error, use the `drop`
-	command in the todo-list.
+	command in the todo list.
 	Defaults to "ignore".
 
 rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for the
-	instruction list during an interactive rebase.  The format will
+	todo list during an interactive rebase.  The format will
 	automatically have the long commit hash prepended to the format.
-- 
2.15.1.280.g10402c1f5b5c

