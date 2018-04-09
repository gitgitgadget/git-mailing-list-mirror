Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607611F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeDIIbo (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:31:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:52151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbeDIIbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:31:41 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ7sF-1f937C41kB-005E7p; Mon, 09
 Apr 2018 10:31:30 +0200
Date:   Mon, 9 Apr 2018 10:31:29 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 02/15] t1300: rename it to reflect that `repo-config` was
 deprecated
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <083953bc0d5c7f497722a1b42b0e0be884fd1a4c.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VolfaIgK5vTHAdDO9WQIHgvgDmplSYjY3tG2FH5l+sOjar9s3TQ
 3tzacFWp8cPTUbJyRzEUDfx2XxCv8gfTIE+j1aQsNWo8XSMGnlf6rbMUYu9rSk6iOLe6bhR
 xIAikrXSt0r8qFT+t/ehdvhU2BOC+tJMrFqO2KZLEnG2elp1STxQjIARsKWLaY/t+PYniOl
 cmoHYmqRv8a0h7Uppuhqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:byCSZen/Ma0=:xBLXT3wyhThj/ff7uRgag1
 i7nb6VSWVeTphYxJ4rFLn2Wi4cPHvB+KPue1X7zLW/l+IBWiFxaRJkami3F+m9QIvnwXNDFKC
 Dt/cinG4+hTLFbE9PEqQXgQ9F6s2u5r17zY8//RupZi6f5Cv5RHDy9ZxAAM/1Tm0rlu4msR33
 /RZa6stCiBZCxERR3ImjJRJK4GKWpVTGe0O8p04kL4Y8Ky042Y7V6XxDLQ/jOIdlb9atkxlcO
 Fb2N1mlU0YXnqlAK9+u7X5/LyNzn/YrB/UMcNYCLN7AfinluE/uutdsURmBILkCcMgOPjrJFu
 4bqY0jR/bJDRtTQ3rkS3R+6bhcwv0vL9khbn9Aq7a0GrxPFtXChRBjIF4rxbNmPZE1Z959aa6
 W9JCtKuGyZ9jkOpdy1YO1don4PNxrXdXBD1SdfpDNJx+pQ8YpQZCw4OxOuKoE5QGM0la70N/a
 8JZoVXg8eUDUhSfpe8QVmoSMCpoZ1ZLMubJOa/BQ5zXSSsmxYYV2Y46kxXmUy7K0pAccoCmyj
 5C+FJjkpcBQVBk7pEOi8BfZcSCVEKCrUDshk06r04/6ho2EF5EZ+9J7MHKDuc4y0v+io0mWam
 xk+22nWdGZwQuwXcq2GuDg+l11CzvEc/hibrWQEMFW8Ku+86uNMo8Y2wbb3t+XhTXDIsOJQSV
 9xnm39hNGQYb7PzNEdCPE9M0R96ayBaWoiU8KwujA7am9SJaN0PxjY3Ln1M90VCnGc6xnYhQu
 O9Rx0Yl2ZjczRnUID5COlT0ElIoKS26NbVQHnpNvcVNKAQopfjiplR1Uf3xp8ZHKvsCUBBFA/
 Bcwx8tZ5iWmBDSKG9MPvWqQmonzQ2MwQmp81fpwMKw2VySc76U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/{t1300-repo-config.sh => t1300-config.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t1300-repo-config.sh => t1300-config.sh} (100%)

diff --git a/t/t1300-repo-config.sh b/t/t1300-config.sh
similarity index 100%
rename from t/t1300-repo-config.sh
rename to t/t1300-config.sh
-- 
2.17.0.windows.1.4.g7e4058d72e3


