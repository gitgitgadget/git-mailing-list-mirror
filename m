Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31CCB1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbeHPJuP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:50:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43183 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHPJuP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:50:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id f135-v6so2598137lfg.10
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=73IFiXs6WN0VhWGtH0sBSONLr/pkRu/BrhxLxwMxSi4=;
        b=qDmnYmnYTDAAeerAibVS0S73nIQX8nqkXadbtGtLYAHG3eny7P8vMMliPUc49vdVtC
         6roq4+lRvbmP5t1Oyr/Sq+a/yeDngnBKxtjP2zewPhZen/NQYUdQypnjr7T8or5ioKX8
         vPt6UhI7mzCwZ5ca2KLKiPfpfWrNccqiJ4USHbWvMsIba7LemwL14FFIs93zSONbevk+
         TkGUZyBjpby48do1aaN7S4yHKe3dcl0Qkg6y20AzFarQCTKgmEJhGaANm3R7rD1bssej
         6lGkjoCzWx6AydjmMYCucjct1v/hJ+3WtEQ1D9cIwpIee0iocxVujs6UbcH1v20LzS/9
         6uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=73IFiXs6WN0VhWGtH0sBSONLr/pkRu/BrhxLxwMxSi4=;
        b=XDfYe/833WU6YCWuQF8koUIsadgxtgvQlKwFJMyvCV76T8LC7DDRZAfG3jftrPwGzn
         LQgMmqnV/iJOALmLxjDeGHLhM3l1swKHg19dsV8L71v0sSOZAS+KUMP+Gle1bfO4zvT2
         cjZEsntzAjC3wcD7dVbV9lpb/HgVd0z/Ns2O1cgwAjRtxMLq7DJQ79u41QD3sIQXB2nL
         0E91vKLByUTIgoj9bV6uh15VcZ5jxpu5XCTdEnhHy9k6rwem3lstJAM8ZYSH+8Dbr7jo
         XkBGVUiZC8KCDPgU3fbvSt0C/7np8tNhLkI7k5LrMES4lLo29xG0y8KMzfms20vO7pXM
         mKSg==
X-Gm-Message-State: AOUpUlFSOQVh1/gBjIsyMXa62OKrJAeEhrW/6Tpn2vzEy9rpqWkjQZ6q
        Th0YAuA0EgZos0UUoUPETLI=
X-Google-Smtp-Source: AA+uWPzIcBGgUG3VWI9AWkryaicy52hFijFp86d1PxrGCb6c2YHDNdapjUPZUnbwt7QorFnGwtvJ4w==
X-Received: by 2002:a19:5509:: with SMTP id n9-v6mr19674432lfe.133.1534402434239;
        Wed, 15 Aug 2018 23:53:54 -0700 (PDT)
Received: from [192.168.2.2] ([213.21.46.206])
        by smtp.googlemail.com with ESMTPSA id j10-v6sm4294085ljb.33.2018.08.15.23.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:53:53 -0700 (PDT)
From:   Basin Ilya <basinilya@gmail.com>
Subject: [PATCH] l10n: ru.po: fix misguiding translations
To:     git@vger.kernel.org
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Message-ID: <766e1929-1852-4121-5602-73dccf744d5d@gmail.com>
Date:   Thu, 16 Aug 2018 09:53:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: ru
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The removed word suggested that there was nothing to do while it's not
always the case.
---
 po/ru.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 9dd5dfb14..77690c8b3 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -14110,22 +14110,22 @@ msgstr "Сделайте коммит или спрячьте их."
 #: git-rebase.sh:607
 #, sh-format
 msgid "HEAD is up to date."
-msgstr "HEAD уже в актуальном состоянии."
+msgstr "HEAD в актуальном состоянии."
 
 #: git-rebase.sh:609
 #, sh-format
 msgid "Current branch $branch_name is up to date."
-msgstr "Текущая ветка $branch_name уже в актуальном состоянии."
+msgstr "Текущая ветка $branch_name в актуальном состоянии."
 
 #: git-rebase.sh:617
 #, sh-format
 msgid "HEAD is up to date, rebase forced."
-msgstr "HEAD уже в актуальном состоянии, принудительное перемещение."
+msgstr "HEAD в актуальном состоянии, принудительное перемещение."
 
 #: git-rebase.sh:619
 #, sh-format
 msgid "Current branch $branch_name is up to date, rebase forced."
-msgstr "Текущая ветка $branch_name уже в актуальном состоянии, принудительное перемещение."
+msgstr "Текущая ветка $branch_name в актуальном состоянии, принудительное перемещение."
 
 #: git-rebase.sh:631
 #, sh-format
-- 
2.17.0



