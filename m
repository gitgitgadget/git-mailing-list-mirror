Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F3C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D512065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgG1U06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:26:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:40246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgG1U06 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:26:58 -0400
Received: (qmail 29778 invoked by uid 109); 28 Jul 2020 20:26:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:26:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28661 invoked by uid 111); 28 Jul 2020 20:26:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:26:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:26:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/11] strvec: update documention to avoid argv_array
Message-ID: <20200728202657.GI1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were a few mentions of argv_array in a non-code file which didn't
get picked up in the previous commits (note that even comments in code
files were already covered because of the mechanical conversion via
perl).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-parse-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 2e2e7c10c6..5a60bbfa7f 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -232,9 +232,9 @@ There are some macros to easily define options:
 	will be overwritten, so this should only be used for options where
 	the last one specified on the command line wins.
 
-`OPT_PASSTHRU_ARGV(short, long, &argv_array_var, arg_str, description, flags)`::
+`OPT_PASSTHRU_ARGV(short, long, &strvec_var, arg_str, description, flags)`::
 	Introduce an option where all instances of it on the command-line will
-	be reconstructed into an argv_array. This is useful when you need to
+	be reconstructed into a strvec. This is useful when you need to
 	pass the command-line option, which can be specified multiple times,
 	to another command.
 
-- 
2.28.0.rc2.475.g53c7e1c7f4

