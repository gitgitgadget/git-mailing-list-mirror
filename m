Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804971F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeACDFi (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:05:38 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37623 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeACDFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:05:35 -0500
Received: by mail-pg0-f67.google.com with SMTP id o13so204839pgp.4
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDdJdMKaO0J5nWRJ7FsBZ1i9Kw9mljQLbDuu0BIBW/M=;
        b=JGnBQjKrAMldWjWHeBSfrAX+bes1sX+Z4Ck8uYZpTXFE33PIpvgIKdsn9Gzao1/aoz
         bEiE5Iod5S0ysGQpMN2xOBq77gpVdT9kFBrcrW4DKR6bbmRJjGZRiU7qDMtAIcgvojCv
         0GahDwMOBuNI3JK69WN5FAbFHw9B3BgLKTcNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDdJdMKaO0J5nWRJ7FsBZ1i9Kw9mljQLbDuu0BIBW/M=;
        b=c8d2/2J8mjhpsnYbW3VtHY1grOo6ZqbIlAJaxfKLHsE8nLRPWfnOCGOUr8A5y+6xns
         zziKhSJM5GAo6uAisqfB6+Q7emAsqzslBW93XBWUiuPdAtIb8YHN6lNdD0/yooeGQwRf
         Fy0Jeo+i6hB/GQjLoAl560GuGNkjSjcFe+9HFXtG/sKPlN41M851oMaCyStAQ014wIUu
         5LKf+daaeG16w4bwuFgRDojVjv8Xv6UMh1Ptitz0CzVU6YpOjc7D5QBOmkHny9KmocmI
         T30XQ/iatA6esheoH3EA3Fed11aLDNIzC2hswvbUOoty07Ewpy83d/poDUsvN2OzsEgp
         AQYQ==
X-Gm-Message-State: AKGB3mImy5wXydK0p+ieLZ1bBRbUkscZ+3TC+zeFDGTG4cO5swmcidli
        WhVr3DBoD1QYSYcIz8AqXNeQoqf/kpI=
X-Google-Smtp-Source: ACJfBou1N4aN+wj8tesvE91ifJ8fl+ohqynifA3B5wdimCWuHwrTxa6+eqbRMnAt5lQfaiuz/txiqw==
X-Received: by 10.98.11.71 with SMTP id t68mr100497pfi.79.1514948734220;
        Tue, 02 Jan 2018 19:05:34 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id 82sm107742pfm.136.2018.01.02.19.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 19:05:33 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 1/6] Fix comments to agree with argument name
Date:   Tue,  2 Jan 2018 19:04:51 -0800
Message-Id: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.31.gddce0adfe
In-Reply-To: <20180103030456.8181-1-alexmv@dropbox.com>
References: <20180103030456.8181-1-alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30..cf05b1da0 100644
--- a/dir.c
+++ b/dir.c
@@ -790,9 +790,9 @@ static int add_excludes_from_buffer(char *buf, size_t size,
  * an index if 'istate' is non-null), parse it and store the
  * exclude rules in "el".
  *
- * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
+ * If sha1_stat is not NULL, compute SHA-1 of the exclude file and fill
  * stat data from disk (only valid if add_excludes returns zero). If
- * ss_valid is non-zero, "ss" must contain good value as input.
+ * sha1_stat.valid is non-zero, sha1_stat must contain good value as input.
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
 			struct exclude_list *el,
-- 
2.15.1.31.gddce0adfe

