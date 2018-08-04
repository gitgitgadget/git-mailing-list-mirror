Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07ED21F597
	for <e@80x24.org>; Sat,  4 Aug 2018 22:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbeHEAUf (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 20:20:35 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:42584 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeHEAUf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 20:20:35 -0400
Received: by mail-pf1-f169.google.com with SMTP id l9-v6so5001716pff.9
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BlZ1abNdXAB/QP6Io/ieon1HzxHmkmJ/m8Pk1I8Bq8Q=;
        b=A+PiP/vcRuvM2PLausk0EhKBeP3ocAET/1D77bW3yQIimUHYkJA4sCZuiTcsNSIpaQ
         e1HUc0g0mKMkDlf9gSQfCtkWSXNVmJkgfwfNJ94+TtVpgUb1asxS03xe1u5JoW0hM4th
         zEVNgIkaGfhDJwbwwK+JJ/YLV4aP/iEsi653SfQtsOiIaaYXbZWFj5l4oXvksdOV1jky
         DAE0FtBhH4Pbhm8sxsQMQeN69p+YN7DcgAHPf3cK+AOqYpg99OB2Bwh7NmzYEmhRw5Ns
         Hgg3AnSMaQkqM0MMMSUMnZ3pphuarq9uf2PxalCYviIQjCyr8Jv9adi6GWVF8pHOvgZL
         COxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BlZ1abNdXAB/QP6Io/ieon1HzxHmkmJ/m8Pk1I8Bq8Q=;
        b=AbnC0HNc2exV690rW0TRrfqH+Zs9/FpqLNYgIy6QtEIHeTXkTN9KAyuQO6pAbxkh5o
         JuVCfgS36nbXvhapOAL7VPzDyY108DhRuXrcHuwSXfSd8fjOVPvjctiCmnE7zhMXdEsk
         wFO+5CA5+sOawV7voqeKPTsmhxmcEmJzqXmUW3sIdrQMmzrlTnkiSbZaZEMnhii0CYmh
         SyAyTmvwPlFSsUqzaPFsiMYNDhBvnDWwazwYkvHv54c5zKUmVXgb1N+ghsqNuz6m3D2N
         QNwO4i3i9DeKIeGJiMdc8Y/5bGdRXL63mwJnUpishggVv6n/8f9fUBT/DgF1mFbCYUSI
         WyOQ==
X-Gm-Message-State: AOUpUlHdySTN63EPuL+MU8F7sJ6gRnARhMaapyD6Tz4zVSGxkXQM74LD
        +BylZCYdX5sZOhWCkNQq7AvTEf5V
X-Google-Smtp-Source: AAOMgpdvQGTQvxWHyYRoBs2i83iqP6FEVGg0aw1fD9OwG2DHubh7ChegS6BtAI8f69F+b51XDKE05w==
X-Received: by 2002:a65:6398:: with SMTP id h24-v6mr8955842pgv.245.1533421104688;
        Sat, 04 Aug 2018 15:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u83-v6sm30160673pfj.37.2018.08.04.15.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 15:18:23 -0700 (PDT)
Date:   Sat, 04 Aug 2018 15:18:23 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Aug 2018 22:18:17 GMT
Message-Id: <cab7bb36eb85dbe38ad95ee02b083f11f0820e24.1533421100.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.15.git.gitgitgadget@gmail.com>
References: <pull.15.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] line-log: demonstrate a bug with nearly-overlapping
 ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, this test case throws an assertion:

	Assertion failed!

	Program: git.exe
	File: line-log.c, Line 71

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4211-line-log.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 436b13ad2..61ff37430 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -115,4 +115,21 @@ test_expect_success 'range_set_union' '
 	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
 '
 
+q_to_lf () {
+	tr Q '\012'
+}
+
+test_expect_failure 'close to overlapping ranges' '
+	test_seq 5 >a1.c &&
+	git add a1.c &&
+	git commit -m "5 lines" a1.c &&
+	sed s/3/3QaQb/ <a1.c | q_to_lf >tmp &&
+	mv tmp a1.c &&
+	git commit -m "2 more lines" a1.c &&
+	sed s/4/cQ4/ <a1.c | q_to_lf >tmp &&
+	mv tmp a1.c &&
+	git commit -m "1 more line" a1.c &&
+	git --no-pager log -L 1,3:a1.c -L 5,8:a1.c
+'
+
 test_done
-- 
gitgitgadget

