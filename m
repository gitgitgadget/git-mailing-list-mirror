Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD94C433E2
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 22:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BE82087E
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 22:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fvH4xwn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgH0Wfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:35:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48670 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgH0Wfn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Aug 2020 18:35:43 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1CA7660426;
        Thu, 27 Aug 2020 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1598567739;
        bh=H0hnwtRGgnW2AM+phzmOnZpI7SqudT3sZU9raaL2mmA=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=fvH4xwn/s9Rz0WDoBweMKqBnw9H0/6q/0bXoVysDhjWJ4WBkWxayTG4bPqVUJYjuy
         dFUuZMchuCX8OYlFtCb3U9Tf8pNAtU1s2960xDl1oGWEf+Aj6xISqjEsM1WTtNoZe5
         eLyZbvp2aI/kEhbAgsW5O7h/fp32aCZziGpU16wW7t728FwNHeyi0xNSBD9KMupxwi
         K1t9ISjRnhgPgm2LOWbFTzawgOK3McudFjnnfohoOhigpipkywjT3Hh4D5ezaosFaH
         I8rtJnWyBLC6gkwyh2P07JIytb1py91wrJR4xeTk+vDrn3j1MUzmfaGzh1f+gMh/lS
         6YtR/rnmGs4vK8XeK7l4RTeFG6Ofy12m2nCzgiH8OjOr5hzOQb3ZPj9fuT4OACBJUI
         5gFxx6MSFGmkbxNCUdrWxz0AHgpgUhm3tI+dNHI5hlSw6mWCFtkYy+vXZQh2PnuT1s
         xIWhpZa39X8ItY5UzxDbzdOXXQhiAn2muIwYoKMySoDbEiJogTX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] po: add missing letter for French message
Date:   Thu, 27 Aug 2020 22:35:27 +0000
Message-Id: <20200827223527.36788-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing "e" in "de".  While it is possible in French to omit it,
that only occurs with an apostrophe and only when the next word starts
with a vowel or mute h, which is not the case here.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I noticed this the other day when trying to delete a remote branch that
I'd already deleted.  I'm not sure what the preferred approach is for
this, whether Junio should pick it up or whether Jean-Noël will want to
incorporate it first, but I've CC'd both so y'all can fight it out.

 po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/fr.po b/po/fr.po
index d20fc440ab..75b1e75f6a 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -6503,7 +6503,7 @@ msgstr "'%s' ne peut pas être résolue comme une branche"
 #: remote.c:1088
 #, c-format
 msgid "unable to delete '%s': remote ref does not exist"
-msgstr "suppression d '%s' impossible : la référence distante n'existe pas"
+msgstr "suppression de '%s' impossible : la référence distante n'existe pas"
 
 #: remote.c:1100
 #, c-format
