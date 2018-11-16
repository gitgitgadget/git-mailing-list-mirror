Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681141F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbeKPVQG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:06 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:24683 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeKPVQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:06 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv2gYs1r; Fri, 16 Nov 2018 11:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366253;
        bh=Pqv3eqBOFY23DvNGAVtUwCrc7ZrH7dEIQ36jGF+hM78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=RXKZ0ws6yiK7irOKeLCqxJhMAuzfuln/qKerQxZ7t3puhj2jKmFjM+EWxWth0dAHO
         KT+qOphqMtnuJP3Ypkce/UlCiPOvjdHudN3Rcho18vtRLYH+QtxTp8XXp3OuHMuUXg
         JW/2EwXgFstGXsFBnGaxkO6w/eUZpUdizB5ihnMA=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=sgcJ5tVGo-PX1bOlNW4A:9
 a=aPqGf9fwU8MMLC3g:21 a=2vQo7RDd6zDzV5U6:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 1/9] diff: document --no-color-moved
Date:   Fri, 16 Nov 2018 11:03:48 +0000
Message-Id: <20181116110356.12311-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116110356.12311-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLjH6KXhI4NEGJyMkK5HiGiHMMJkoHDLt8J2mUqouZhWlXil29pFKDf1HTRAb6lLhuBRH1iSPHGoeD8LVc1D5J4Xo8LM2oVzLacmZnOVKtrkMjypPFdv
 Vq5iQhz/r/bh4d2hJaWxU45NM1rId2EuPHNqF67vwpi7LqOUfQQq5EgLvcrJJrvAQ57ooEhIJ0ybimL9Iwy8RKglaYqcmMs3CQ3ItSQx9AjAlImrQSI8j8Co
 o/thJ4paG7j+tcSxnQ7/dA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add documentation for --no-color-moved.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/diff-options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0378cd574e..151690f814 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -293,6 +293,10 @@ dimmed-zebra::
 	`dimmed_zebra` is a deprecated synonym.
 --
 
+--no-color-moved::
+	Turn off move detection. This can be used to override configuration
+	settings. It is the same as `--color-moved=no`.
+
 --color-moved-ws=<modes>::
 	This configures how white spaces are ignored when performing the
 	move detection for `--color-moved`.
-- 
2.19.1

