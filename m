Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE8F1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeC2PTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:19:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:56903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeC2PTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:19:02 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86Cn-1efW631ySX-00vcBQ; Thu, 29
 Mar 2018 17:18:54 +0200
Date:   Thu, 29 Mar 2018 17:18:53 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 5/9] t1300: `--unset-all` can leave an empty section behind
 (bug)
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <484133f267ec2ebb6d6c27ccb40410579c72032a.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M3EdadAgIUjsrtKndCMDt4Xxz0I2Knbr8ujWsq3nOCEQoZSFcZV
 pTn9yLOD9QACp2eEFOR5MS8aS/VV1V9ZlkWI4G1Tlx5tZySAn4caSWHZXg087ol1maifYiC
 JS06pJjjrXtsMhaiavIj+F2580fyQSGoxeO8AkpdEPMf0DvhtDRlSkXtCyjVswHnBhw+auX
 v9MUxj5sPimM9G3jo3mvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jZDQP0FvtZ0=:xX1TtA1lQpfJOA6vtFRJi9
 CN4HIF0NZ9M/hiik4aIZCHNzd1h2hceqRCKblWmlBQWbeUExOjFyD1zLjeGiC9a45EBp/hqwm
 STuX7+ZE2rXF3WTVu9JlnAplji4Yc6IOacMg9udrq2SLefUQkunpQCXyGRZ/0eaUMel+EMkdE
 X71F9CZRLoCM2yiEt7Qxf6cAqs4MhRI5wPqvCtbarnFedLwQD0/cHUm2HpelScOUhGDW+era/
 zm+T9FTk61owxqSVGOOcuuO7iq9bnsxKmfSag2t7PBncakIBN3yJ9loWh1SLqw/x8po65r2rL
 6zsdcU7tbuaa2gvd3drykpN4053kr6D1JRJ3u6LP8zXFhmJAcS5LF3wboprXO5o/ZJRoSXlWa
 Kd7n3rsiYJ3m42IUtcNqtV0x4Pwau3C5EbZl1lSz74q+9tAqiU4X8Y5B5MuP1fYJ7fryU2hVa
 Oj3oEgiOWHmNaBE5etnrVX2q26TOuWc5GbrnhExc5/kCOArQDp8ESYT5bjgWTRk9vJfapno+W
 oa4n5BuWZ0nvXjWahChp6MA2XLwP7Lmqh62EGpOcM7tfkkqicSx0NlWlfagRiEOaBmYnv0xZU
 bvRwIHOqlw2B5orl+F5RJfHLhoMyMUGs+adtSXsOOoIvK3y0YESHwBLHhpeKRSvXjxFPjTlU9
 40uGLgx/9xkLPyFu8JmIe+1A3OvJOw0bJWwrgUCA59EfNJu9bseCZe2sL9W9tBplWiI59UK3j
 CE42r6XZ62M/K1ioG4FvnF49DtMkDpK2c76US/eEYXtvf/uhsUfpkSScF+luC442bUuxa1AK3
 8DlerKpEBjyhaA+IXmR+77uP0NHlqk90pf3DHWRNUMBOrqdiL+jP63df+47vfcbmly8n3rb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have a test demonstrating that removing the last entry from a
config section fails to remove the section header of the now-empty
section.

The same can happen, of course, if we remove the last entries in one fell
swoop. This is *also* a bug, and should be fixed at the same time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 3ad3df0c83e..ff79a213567 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1452,6 +1452,17 @@ test_expect_failure '--unset last key removes section (except if commented)' '
 	test_cmp expect .git/config
 '
 
+test_expect_failure '--unset-all removes section if empty & uncommented' '
+	cat >.git/config <<-\EOF &&
+	[section]
+	key = value1
+	key = value2
+	EOF
+
+	git config --unset-all section.key &&
+	test_line_count = 0 .git/config
+'
+
 test_expect_failure 'adding a key into an empty section reuses header' '
 	cat >.git/config <<-\EOF &&
 	[section]
-- 
2.16.2.windows.1.26.g2cc3565eb4b


