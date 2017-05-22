Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7C12023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbdEVOSO (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:14 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44001 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934620AbdEVOSK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:10 -0400
X-AuditID: 12074412-a4fff70000003a21-4c-5922f321d64a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8B.67.14881.123F2295; Mon, 22 May 2017 10:18:09 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24A023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/25] t3600: clean up permissions test properly
Date:   Mon, 22 May 2017 16:17:31 +0200
Message-Id: <adea7027b2ff5248100742130fedff4cde961fb9.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqKv4WSnSoGGdlsXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoErY/vlOcwFu9kr
        pu7/wdrA+I+1i5GTQ0LAROLa6p9MXYxcHEICO5gkTt4+ywLhnAJy9nWBVbEJ6Eos6mlmArFF
        BNQkJrYdAitiFtjALPFm+mqwhLCAs8Trx9vAGlgEVCXmT94JZHNw8ApEScycWwGxTV5iV9tF
        sBJOAQuJ37MOgLUKCZhL9P5bzTKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzM
        Er3UlNJNjJBAFNrBuP6k3CFGAQ5GJR7ehqdKkUKsiWXFlbmHGCU5mJREeY++AQrxJeWnVGYk
        FmfEF5XmpBYfYpTgYFYS4dW+C5TjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgST
        leHgUJLg1fsE1ChYlJqeWpGWmVOCkGbi4AQZzgM0fM0HkOHFBYm5xZnpEPlTjLocc+59fc8k
        xJKXn5cqJc5rADJIAKQoozQPbg4sgbxiFAd6S5i3EKSKB5h84Ca9AlrCBLTE+pk8yJKSRISU
        VANjxbnJq99VveF69slWc6akuqjz2oAH3CGpu9dMYM7ZdSSn6veBW+pT3Z1rFfleHqxoDzS9
        /vjMLF0Gf+Y0z+5bVhfbrp1IPc51PNQllrvhxSX9sFM/XYsuz3hoavCbc3ruhmUGuvNaWNX4
        3A4WfWRymfPInnG69+c3N3pso67Wp97g/yoj7TZHiaU4I9FQi7moOBEAcbeNN/sCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test of failing `git rm -f` removes the write permissions on the
test directory, but fails to restore them if the test fails. This
means that the test temporary directory cannot be cleaned up, which
means that subsequent attempts to run the test fail mysteriously.

Instead, do the cleanup in a `test_when_finished` block so that it
can't be skipped.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3600-rm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5f9913ba33..f8568f8841 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -97,9 +97,9 @@ test_expect_success FUNNYNAMES \
 embedded'"
 
 test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
+	test_when_finished "chmod 775 ." &&
 	chmod a-w . &&
-	test_must_fail git rm -f baz &&
-	chmod 775 .
+	test_must_fail git rm -f baz
 '
 
 test_expect_success \
-- 
2.11.0

