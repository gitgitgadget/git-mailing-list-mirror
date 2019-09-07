Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49441F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405992AbfIGON2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40845 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404502AbfIGON2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so8577831ljw.7
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3MU+Sr1k0h3hnv2InjelCQagHzlzo9aUgj0bMVobdk=;
        b=U8jTiDmmAHMWnURYwjsS0jShUQZYeKLVaDTfVRn8jOP8ZtufpOf2S3/FayKtZ5nx0R
         LUNtp9+pDEUpmxwL+wPgFrsfyQrPHCAR/e0H+6m10IX3WAUqUUohOJw4rcqyxxwDxYm7
         FTWv4IhLLZhFk/c0X1RtYq16T1aqhCUGo5UnG1pirXG2jyq8FW4FxESIr+m+wbItbHrU
         sROKW+ttOhIbFRUgbtjK2TTriv+7kb2ms8HZaorA79AkJffoWome8s86ksWlw0NxSELz
         Up0Jan1qmc4a2LiY7ACG5I9pwyUq0X4mMyfQLl6evcte1bRKgd4YWzbHOXmLBPjvelSX
         VKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3MU+Sr1k0h3hnv2InjelCQagHzlzo9aUgj0bMVobdk=;
        b=bAydqpqXoCuRe+8l0SmNJJvjDN8TxwcmRUi3J7+XilK8ANC31yr9ImLuWpjmKm/OoA
         pV/vDefriDQ7c8pnvnzE5yA6q1dpiiqJxATiamhI+Ng4G7zrfmBCaA0XUx1Qvqeo1UUL
         38BIKHh6lxx3/mrdYqo+MHsieMx7n3XE3Lt8ODhXvvE7Dri1u69VjJbZgBj6w+FcSNTl
         feP4Vtt6VHkfBueQSvCmZ5WAf45dblycg1b1+5GJiUmBaLg+MobHXrgZ+VfT250eXvab
         x58CoO3HIbd6LRcPxbJuuBWMt4FTPaVFU7B1FDochQIWtU10tDhxvvGeClZgqpi2xmxD
         Xh+g==
X-Gm-Message-State: APjAAAVn/1GIzCgiEMPSJQQa286LJVp0uCxxzAqpkc6W2tsc4zc+VPO3
        E5z08An0YaDQ4mLBLvC6r36qfqhD
X-Google-Smtp-Source: APXvYqxBPkFZy40TVE7Jh0z7pF94UCsLeE9VeNaKYhUCEryYgY4QVzioqEmjXNLn0LdSlwNJTU+e7A==
X-Received: by 2002:a2e:9145:: with SMTP id q5mr301604ljg.76.1567865605292;
        Sat, 07 Sep 2019 07:13:25 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:24 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 7/7] gitweb.conf.txt: switch pluses to backticks to help Asciidoctor
Date:   Sat,  7 Sep 2019 16:12:53 +0200
Message-Id: <19c355cbe5e39f48bba30e84e655100be62119d4.1567707999.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567707999.git.martin.agren@gmail.com>
References: <cover.1567707999.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This paragraph uses a lot of +pluses+ to render text as monospace. That
works fine with AsciiDoc (8.6.10), and almost fine with Asciidoctor
(1.5.5), which renders the third of these literally ("+$projname+"). The
reason seems to be that Asciidoctor trips on the lone plus a bit
earlier, even though it is escaped.

Switch +$projname+ to `$projname`, and change the next, similar instance
too (+$projname/+), because otherwise, we'd trip on /that one/ instead.
If we would stop there, we would now start falling over on the escaped
plus ('\+') mentioned earlier, rendering /it/ literally. So change that
too...

In other words, unescape the lone '+' and change all the pluses that
follow it to backticks.

AsciiDoc renders this paragraph identically before and after this
commit, and Asciidoctor now renders this the same as AsciiDoc.

I did try to switch the whole paragraph to using backticks rather than
pluses. That worked great with Asciidoctor, but confused AsciiDoc...
Let's go with this rather surgical change instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/gitweb.conf.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 35317e71c8..7963a79ba9 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -786,9 +786,9 @@ forks::
 	subdirectories of project root (basename) to be forks of existing
 	projects.  For each project +$projname.git+, projects in the
 	+$projname/+ directory and its subdirectories will not be
-	shown in the main projects list.  Instead, a \'\+' mark is shown
-	next to +$projname+, which links to a "forks" view that lists all
-	the forks (all projects in +$projname/+ subdirectory).  Additionally
+	shown in the main projects list.  Instead, a \'+' mark is shown
+	next to `$projname`, which links to a "forks" view that lists all
+	the forks (all projects in `$projname/` subdirectory).  Additionally
 	a "forks" view for a project is linked from project summary page.
 +
 If the project list is taken from a file (+$projects_list+ points to a
-- 
2.23.0

