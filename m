Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725161FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbdEKJOd (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:14:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:49267 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdEKJOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:14:32 -0400
Received: (qmail 1585 invoked by uid 109); 11 May 2017 09:14:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 09:14:32 +0000
Received: (qmail 10255 invoked by uid 111); 11 May 2017 09:15:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 05:15:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 05:14:30 -0400
Date:   Thu, 11 May 2017 05:14:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 4/4] docs/config: consistify include.path examples
Message-ID: <20170511091430.jwpbyca3m32wterq@sigill.intra.peff.net>
References: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the include examples use "foo.inc", but some use
"foo". Since the string of examples are meant to show
variations and how they differ, it's a good idea to change
only one thing at a time. The filename differences are not
relevant to what we're trying to show.

Signed-off-by: Jeff King <peff@peff.net>
---
And yes, I just invented the word consistify. "make X consistent" hides
the meaning at the end, and I couldn't think of a more concise verb.
Prescriptivists beware. :)

 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 70f79ac39..7b08df732 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -172,8 +172,8 @@ Example
 
 	[include]
 		path = /path/to/foo.inc ; include by absolute path
-		path = foo ; find "foo" relative to the current file
-		path = ~/foo ; find "foo" in your `$HOME` directory
+		path = foo.inc ; find "foo.inc" relative to the current file
+		path = ~/foo.inc ; find "foo.inc" in your `$HOME` directory
 
 	; include if $GIT_DIR is /path/to/foo/.git
 	[includeIf "gitdir:/path/to/foo/.git"]
-- 
2.13.0.447.g4d26bc97c
