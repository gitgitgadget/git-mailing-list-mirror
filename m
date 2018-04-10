Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F2531F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeDJMaM (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:30:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:43111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbeDJMaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:30:10 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MQ2Wx-1fB7LL1xkB-005IUt; Tue, 10 Apr 2018 14:30:04 +0200
Date:   Tue, 10 Apr 2018 14:30:03 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 09/15] rebase --rebase-merges: add test for --keep-empty
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <4e12058ce815a4b6c780c0c907f819861459be1d.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ve2sd1Ec7toaHB/us1ZGA35FIsCitKln8ggBairPQ6EsLj0jgF2
 G1t0wX6cJBx6UCiSMy/DhVLQR770ul6kkgqRDxOdoOvi/yLHphXpL7qC6lX6qF6Zu3mGqME
 Lz84Wg7XNGf8MjBNnY0jYcCuoYmVqJJwYjs9q5Hoz3wBPsBR5av9O4tCTJemo9AkPZNCVAX
 Ad5WE0zKDoM2fvb3iRoaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ez9/gLSYCss=:spxKY7qH/eIB3QTI+LO+sq
 qqQgcTYAKapI5AcowlqIq8+diVWe/7IQjSRpH+aahweQKc3JJv8iDyfvw4uh7W/8TPGLgDTye
 QD19pkNoxfaAD/Z7WMomcBhCGslZIyilL7m6/jzws6DrtMbBHzPcDMfvoVv1vhbTUDZ7piouB
 /o7pRfmupfiae9YacZogwa46yZxB6l/ot3VssFgU1exuSKuU/Lp2uHXeRSFerWH+zrRbMOZ6E
 fM6dXkt66sH/UEupXujjNYCDu9trrRN6v5itK+UUKtRhaEgq85ySJPWDSou0HdC2liaFrbq8j
 CuVmYKAUZAfhGO6LdWN+wjsx8ElmVpjXANWAOTSGMYUJd6pHr+6YOfI/WblDWLGxeh3I1sQi/
 hH7hh82fpdxRGqJ00N9T1jQ8u+DRrbqiqpGVy7O4sZFSRNsNRjB56x6TU4C+khPqor7WgA93p
 aSrR3IAGaLonKh2ARXJ0HfN4pAkG6SqFpwPcXOmmdq2yBW8um1TAG5H/jWiOSj0t2QL/jnbgD
 +TVGL18Mr4H8y+Dhp92rL6LGqqnQNz+BTLjGD0ijdos8eAYJfuFMfdW5xSW25qv8g2JMai4mV
 tflGsQSjoK5wIPmN7aFEEWP6ZoX2lGzycSn+XADyZLLbnNGlO4z7+LiBhxRYw3h1DnnuZC7Zj
 ipI8c98bFayN7eJVDxUtsOVnKfoqy7kUmzuUMOmjhxZWkmUqDPhPR5Vbu8MP3c+jdDWxNOh2U
 xlIfE2dl3vxA71mlWH3C6PBKbkCtY6n7OHV4G6Lm1+D82Wo/rLY5dN58YB5VbDlWW/t50kLQn
 AaZGGEblUk+HpI0OuF3RwUchqFQj1MVSbsHZJ8iYhu5qAMnAqg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are empty commits on the left hand side of $upstream...HEAD
then the empty commits on the right hand side that we want to keep are
being pruned.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3421-rebase-topology-linear.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 68fe2003ef5..fbae5dab7e2 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -217,6 +217,7 @@ test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase failure -i
 test_run_rebase failure -p
+test_run_rebase success --rebase-merges
 
 #       m
 #      /
-- 
2.17.0.windows.1.4.g7e4058d72e3


