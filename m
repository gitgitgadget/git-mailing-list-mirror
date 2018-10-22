Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828761F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJWFGc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:06:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeJWFGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:06:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so11685502wma.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xb1l50mqw7I3J68/EmgVaqjceKjiiJ3BYlNQY6GvrPw=;
        b=vhm0NiGoIzevpRIsozzoCgyaXVj/DiBxx7AqrWQCrjeJQYdYvMKC7QrSKyE/VC/S0F
         kQS+FuFwje/e2DuiO0n/6WyKCtF/IjVsdlqFdKDhGGmTRkLrVhX0BuQc9PITcrEqS2MN
         67INUmobtv7hUxam4RAwQjdhXY3zoeSy+AT0q1wIDeo1SxjFICDk3r0G2Z5qTlZ3JKSP
         L1wmvv6ms4CDlC8VzrJrhYIAsLccUIV37X6ySf80r/YWQERjHGcOU0b5/D4ReYPt8lgY
         yfb1+0vsApxm8m7eVJq9+FFbhrZYTmWM587RivunTbo9d4epBDdFuBbmnX6byc5dwo3A
         bhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xb1l50mqw7I3J68/EmgVaqjceKjiiJ3BYlNQY6GvrPw=;
        b=js8UDmyNeZulkquHWPt/AuKm+rh/4Tztky+UB37TXeD7WR/ndX1m5RHt01zWWck1sM
         TQNxAvWzogmLIIXlijpjbB/WH9NXcd7Jzu7WU6aHj7BAdMWiroxixWpK4zO/1UdWq0pV
         hjwgwM4TI3KstsZCp90MBRUvge0oYxBRP78Uzpe5QcUkh790xUwLllbleVbnBMQoIFNT
         eMKCC5H3WClkeMOEeQv1Ed4scXOunSCuMS5J2ubfZ6zklb5BGchxoFNgMglwRBEOG9f4
         7oPpTwhJTRHAfQg+L4tJlaWZzU7AnFoZV94DbSKBjvir9fnHdZ42vdSzv084dqMWbFwn
         JIBA==
X-Gm-Message-State: ABuFfoguilc+IA9cbMyqCDMdLRyXu18f4Y6QTQZDgTfQmZGKvo6OGPRz
        ZPkdvlorN7FB6urob9Zt5g9DPuAp
X-Google-Smtp-Source: ACcGV625LWOwNOMxy/VRL4gHIjFr3krWH6OrvEwsIMdkvpVmO6INnnTBnYDZAtzg5SKPg9V9igMt/w==
X-Received: by 2002:a1c:1507:: with SMTP id 7-v6mr16683650wmv.6.1540241184983;
        Mon, 22 Oct 2018 13:46:24 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:4936:e72c:acbd:e1bd])
        by smtp.gmail.com with ESMTPSA id r134-v6sm9526526wmg.9.2018.10.22.13.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:24 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 5/6] doc: fix indentation of listing blocks in gitweb.conf.txt
Date:   Mon, 22 Oct 2018 22:45:45 +0200
Message-Id: <20181022204546.20354-6-asheiduk@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022204546.20354-1-asheiduk@gmail.com>
References: <20181022204546.20354-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'gitweb.conf.txt' uses inconsistent indentation in listing blocks and a mix
of listing blocks and literal paragraphs. Both didn't look pretty in the
rendered HTML page.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/gitweb.conf.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 9c8982ec98..c0a326e388 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -19,10 +19,12 @@ end of a line is ignored.  See *perlsyn*(1) for details.
 
 An example:
 
-    # gitweb configuration file for http://git.example.org
-    #
-    our $projectroot = "/srv/git"; # FHS recommendation
-    our $site_name = 'Example.org >> Repos';
+------------------------------------------------
+# gitweb configuration file for http://git.example.org
+#
+our $projectroot = "/srv/git"; # FHS recommendation
+our $site_name = 'Example.org >> Repos';
+------------------------------------------------
 
 
 The configuration file is used to override the default settings that
@@ -357,6 +359,7 @@ $home_link_str::
 +
 For example, the following setting produces a breadcrumb trail like
 "home / dev / projects / ..." where "projects" is the home link.
++
 ----------------------------------------------------------------------------
     our @extra_breadcrumbs = (
       [ 'home' => 'https://www.example.org/' ],
@@ -901,14 +904,16 @@ To enable blame, pickaxe search, and snapshot support (allowing "tar.gz" and
 "zip" snapshots), while allowing individual projects to turn them off, put
 the following in your GITWEB_CONFIG file:
 
-	$feature{'blame'}{'default'} = [1];
-	$feature{'blame'}{'override'} = 1;
+--------------------------------------------------------------------------------
+$feature{'blame'}{'default'} = [1];
+$feature{'blame'}{'override'} = 1;
 
-	$feature{'pickaxe'}{'default'} = [1];
-	$feature{'pickaxe'}{'override'} = 1;
+$feature{'pickaxe'}{'default'} = [1];
+$feature{'pickaxe'}{'override'} = 1;
 
-	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
-	$feature{'snapshot'}{'override'} = 1;
+$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
+$feature{'snapshot'}{'override'} = 1;
+--------------------------------------------------------------------------------
 
 If you allow overriding for the snapshot feature, you can specify which
 snapshot formats are globally disabled. You can also add any command-line
-- 
2.19.1

