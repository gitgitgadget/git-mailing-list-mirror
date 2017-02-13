Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255061FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbdBMUik (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:38:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:54414 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753225AbdBMUii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:38:38 -0500
Received: (qmail 3486 invoked by uid 109); 13 Feb 2017 20:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 20:38:37 +0000
Received: (qmail 23752 invoked by uid 111); 13 Feb 2017 20:38:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 15:38:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 15:38:35 -0500
Date:   Mon, 13 Feb 2017 15:38:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] docs/gitremote-helpers: fix unbalanced quotes
Message-ID: <20170213203835.vssj64tcvuq35dny@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each of these options is missing the closing single-quote on
the option name. This understandably confuses asciidoc,
which ends up rendering a stray quote, like:

  option cloning {'true|false}

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitremote-helpers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 9e8681f9e..7e59c50b1 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -452,14 +452,14 @@ set by Git if the remote helper has the 'option' capability.
 	Request the helper to perform a force update.  Defaults to
 	'false'.
 
-'option cloning {'true'|'false'}::
+'option cloning' {'true'|'false'}::
 	Notify the helper this is a clone request (i.e. the current
 	repository is guaranteed empty).
 
-'option update-shallow {'true'|'false'}::
+'option update-shallow' {'true'|'false'}::
 	Allow to extend .git/shallow if the new refs require it.
 
-'option pushcert {'true'|'false'}::
+'option pushcert' {'true'|'false'}::
 	GPG sign pushes.
 
 SEE ALSO
-- 
2.12.0.rc1.466.g70234cfd8
