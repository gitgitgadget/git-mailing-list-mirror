Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2BD201A4
	for <e@80x24.org>; Sat, 13 May 2017 11:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbdEMLDV (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 07:03:21 -0400
Received: from srv1.79p.de ([213.239.234.118]:45890 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbdEMLDV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 07:03:21 -0400
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id A83B8220F61;
        Sat, 13 May 2017 13:03:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "Cc"
        occurs 3 times
Received: by srv1.79p.de (Postfix, from userid 0)
        id EF348221C2B; Sat, 13 May 2017 13:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2017; t=1494673398;
        bh=7v3ResPo4guESUP0S8RoDCV8I2fr4KX3ph8wSaFQxtU=;
        h=From:To:CC:CC:CC:In-Reply-To:References:Date:Subject;
        b=S2DiuiZx9aKjlsMzYxD/45xa80uvv5JMwtzZX3RMetLNP3yBgnuYLonf4LN84g7hK
         n72ie6a3MkwCc6BydsPq+pRTJ8EtmtduuzTbUP507uWJybCEdbl9rakGBxWXHRSjgE
         YQ4VA6Ts9Q1u3vrX4g7GA3etckUQTISgTOIBmXBlSbowtfEplcu1agZo9tVG0c5R+Z
         +KuEECDcu7gDVxisMdEVwRoVT1EhfvmDnh7sfwf6rCT1p2PS7JBgRlQTa1beyoMDkt
         9s4SqknlTmEA6Joz1L4LirGktY0E4Bo+ocIU3raZ3Tsx3vde9V4mU5ciOahRyqEvpG
         M75oXSdHGXv0Q==
From:   Sven Strickroth <email@cs-ware.de>
To:     Git List <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>
CC:     Jeff King <peff@peff.net>
CC:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <a38670f6-2d47-f455-c9d3-d887a58e1e29@cs-ware.de>
In-Reply-To: <CACBZZX6dcy9DEp8AZsdV5SPG-86ELOXUSuFkOaoUxjVreJXhDA@mail.gmail.com>
References: <20170513095716.C718E221C2B@srv1.79p.de>
 <CACBZZX6dcy9DEp8AZsdV5SPG-86ELOXUSuFkOaoUxjVreJXhDA@mail.gmail.com>
Date:   Sat, 13 May 2017 11:54:51 +0200
Subject: [PATCH] Use https links to Wikipedia to avoid http redirects
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 Documentation/gitweb.txt | 2 +-
 bisect.c                 | 2 +-
 gitweb/gitweb.perl       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/bisect.c b/bisect.c
index 08c9fb726..fa477a3e2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -546,7 +546,7 @@ static unsigned get_prn(unsigned count) {
 
 /*
  * Custom integer square root from
- * http://en.wikipedia.org/wiki/Integer_square_root
+ * https://en.wikipedia.org/wiki/Integer_square_root
  */
 static int sqrti(int val)
 {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7cf68f07b..d8209c7a0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8085,7 +8085,7 @@ sub git_search_help {
 <p><strong>Pattern</strong> is by default a normal string that is matched precisely (but without
 regard to case, except in the case of pickaxe). However, when you check the <em>re</em> checkbox,
 the pattern entered is recognized as the POSIX extended
-<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a> (also case
+<a href="https://en.wikipedia.org/wiki/Regular_expression">regular expression</a> (also case
 insensitive).</p>
 <dl>
 <dt><b>commit</b></dt>
-- 
2.12.1.windows.1

