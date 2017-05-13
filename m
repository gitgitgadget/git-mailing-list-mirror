Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCBE201A4
	for <e@80x24.org>; Sat, 13 May 2017 10:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdEMKFH (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 06:05:07 -0400
Received: from srv1.79p.de ([213.239.234.118]:44304 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbdEMKFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 06:05:06 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 May 2017 06:05:06 EDT
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id 6B281220F61;
        Sat, 13 May 2017 11:57:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: by srv1.79p.de (Postfix, from userid 0)
        id C718E221C2B; Sat, 13 May 2017 11:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2017; t=1494669436;
        bh=ljYYLj8RwG8LxKa1FB1iRR06nj9WcviT1CjsLnlBRc8=;
        h=From:To:CC:CC:Date:Subject;
        b=PZrFMIWBrb/zeUv1l/mqFEQm7QbuYk5SiGCQDzbB71mUg0C3k4SwvSC9K0UPZ5c6G
         HuNxYKgHV06BU+EaHG5/NK2Uiu+scTfZX3mvEZxAwy+/dg4H4867MjDZaithlFrAze
         PR9kxQbaNkBhkK7LdNxRl2TmrEkILW0PhmbRbATEO5zWQDZ11QajATay/HlJauFrVF
         paSHl8Ddq0Bw2w2RSkA7AMCmZDiOmi5bJt/jduua85YHW+iRrzZs7jlW5M9WkPzKh4
         j5CfvoQwZSdBXCWOS7xC9oDgwXk5cAX/CI/1nh1RNu5k5cTpc3UfZzaJ9nMiJVf5ox
         Q+adHpcdZLiFg==
From:   Sven Strickroth <email@cs-ware.de>
To:     Git List <git@vger.kernel.org>
CC:     Jeff King <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>
Date:   Sat, 13 May 2017 11:54:51 +0200
Subject: [PATCH] doc: use https link to Wikipeai to avoid http redirect
Message-Id: <20170513095716.C718E221C2B@srv1.79p.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 Documentation/gitweb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 96156e5e1..88450589a 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -84,7 +84,7 @@ separator (rules for Perl's "`split(" ", $line)`").
 
 * Fields use modified URI encoding, defined in RFC 3986, section 2.1
 (Percent-Encoding), or rather "Query string encoding" (see
-http://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the difference
+https://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the difference
 being that SP (" ") can be encoded as "{plus}" (and therefore "{plus}" has to be
 also percent-encoded).
 +
-- 
2.12.1.windows.1

