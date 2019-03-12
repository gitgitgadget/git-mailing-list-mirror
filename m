Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A0720248
	for <e@80x24.org>; Tue, 12 Mar 2019 14:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfCLOiJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 10:38:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38988 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLOiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 10:38:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id p8so2979004wrq.6
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ivAnS04KBwaUVzlsXvc1KBrAw4/5S2rY11aCi18YJmg=;
        b=tNZkW3sGNsgpWvARqgX8IQO4U1COV0UbI2fYlwXsB4rtlpPjfW1RPoZauPiVaBaBqb
         KSBsoWRvTVAS38AI1y6PkekZhAxMK6jwrJNcVtCWBN0a+wH+kIS9SIRUR5oq/07C+U+g
         2r5lkwgeo/Kv+YYHyEWUqFZ9OWyIhPbAz3Tah/3EtB0zvkA7i7HX4ZpOORdIA7f7YI0L
         yX13Go014tRJNLzRwNg6AUKXZ4Z1malGhCwtI6cIkNSsS6f9rTtJpViz3TEskgvs8IpT
         CBuD3g86QX9o9QunzBD72STVpke/ZuSSW1S2pRYdXbCNufpaGxQrWRTvxjKhyD0zcEuB
         BTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ivAnS04KBwaUVzlsXvc1KBrAw4/5S2rY11aCi18YJmg=;
        b=jiU0lEChJYHdB55WZxdBxhLYlYl3cIiTOaaJZp975hMpRgKBZTAOv0udvbvh2dsvyS
         FG1iYtRz4YT/FkPHsrhE7z7icjsY4z3ZfX0kzBk2Pzm9OjELcTFaunMyfyZQHVOXzm4o
         8/0p/ZcpPZ7cGJXWKAdBVY+F0YLaFzBOpJW0lTo5PIaSAGMoWnIVXTIN8dQZDyo7flu6
         0Hi3iKKDPEGwy8uzTEj86H71RRku+VCOLJGoc0ek7QWJQnlSB9CW3EGvcZ6kYdB3QAtE
         3fzvzV3/McGjuAtYwN+AM7VmW1HiDg5wJmhli3KCwr05n4Ipi4pVH2yc2inHtD57lLYa
         1ndw==
X-Gm-Message-State: APjAAAWJnEdy3Tm/RrrvcbAXHLlG5oNLDpglBRCBoC5GDQpwnh3+XBX5
        jEj2huTKro/mC9Ba6tg4Bnk=
X-Google-Smtp-Source: APXvYqwejdfYt+8SE10HSRn1CycwzvijfyEfhUtWkz5m6rTy2uW7MF35UHXmfMPgUkuPB53JltY02g==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr9194947wru.175.1552401487107;
        Tue, 12 Mar 2019 07:38:07 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id x6sm5442463wmg.0.2019.03.12.07.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:38:06 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: [PATCH] t4150: remove unused variable
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, s-beyer@gmx.net,
        Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <36ad743f-8429-a6ff-7fad-15e5dba01483@gmail.com>
Date:   Tue, 12 Mar 2019 15:38:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 735285b403 ("am: fix signoff when other trailers are present",
2017-08-08) tests using variable $signoff were rewritten and it is no
longer used, so just remove it from the test setup.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4150-am.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 55b577d919..3f7f750cc8 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -77,14 +77,12 @@ test_expect_success 'setup: messages' '
 
 	printf "Subject: " >subject-prefix &&
 
-	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
+	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF
 	This line should not be included in the commit message with --scissors enabled.
 
 	 - - >8 - - remove everything above this line - - >8 - -
 
 	EOF
-
-	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 '
 
 test_expect_success setup '
-- 
2.20.1

