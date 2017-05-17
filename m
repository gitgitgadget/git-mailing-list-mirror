Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D5C201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbdEQMGA (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:00 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63160 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752038AbdEQMF6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:05:58 -0400
X-AuditID: 1207440c-9c1ff70000001412-67-591c3ca568aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FC.9B.05138.5AC3C195; Wed, 17 May 2017 08:05:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfq000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:05:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/23] t3600: clean up permissions test properly
Date:   Wed, 17 May 2017 14:05:24 +0200
Message-Id: <bb244c72ec6e6ab56171d82f7379a75c4eb5481f.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqLvURibSoPm4gsXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugSvjYV8nY8EU9oqTj4+wNDDeYe1i5OSQEDCR
        WPzvBksXIxeHkMAOJokpd36wQzgnmCSezlwAVsUmoCuxqKeZCcQWEVCTmNh2CKyDWeAxk8Tf
        Zd0sIAlhAQeJzt332EFsFgFViV+HLzGC2LwCURJXunazQ6yTl9jVdhFsKKeAhcT994+A4hxA
        28wltl+vnMDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSKjx7GD8
        tk7mEKMAB6MSD+8ELulIIdbEsuLK3EOMkhxMSqK8+x8AhfiS8lMqMxKLM+KLSnNSiw8xSnAw
        K4nw3jSViRTiTUmsrEotyodJSXOwKInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnwClkDNQoW
        paanVqRl5pQgpJk4OEGG8wAN5wKp4S0uSMwtzkyHyJ9i1OWYc+/reyYhlrz8vFQpcd5YK6Ai
        AZCijNI8uDmwFPGKURzoLWHePJBRPMD0AjfpFdASJqAlzSDf8RaXJCKkpBoYpzxbKTTV+WKd
        S6rRnOrQyoMcc81abi34WOe1zebLJZusezbX4uTW/pu67NlKFaGVlyRl+a48mbA8xXxhzLUO
        6VeyG5b9MpHqLOW5/VVAMHnqxdjgB0u6onx+pX7YI7Tsy4Ep55qDhFedj9Di51/H79x67CNX
        HVfdzzfpDf8F5ed9n7e6/O+FPiWW4oxEQy3mouJEANQxPsnsAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test of failing `git rm -f` removes the write permissions on the
test directory, but fails to restore them if the test fails. This
means that the test temporary directory cannot be cleaned up, which
means that subsequent attempts to run the test fail mysteriously.

Instead, do the cleanup in a `test_must_fail` block so that it can't
be skipped.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3600-rm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5f9913ba33..4a35c378c8 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -98,8 +98,8 @@ embedded'"
 
 test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
 	chmod a-w . &&
-	test_must_fail git rm -f baz &&
-	chmod 775 .
+	test_when_finished "chmod 775 ." &&
+	test_must_fail git rm -f baz
 '
 
 test_expect_success \
-- 
2.11.0

