Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4EE1F42D
	for <e@80x24.org>; Mon,  9 Apr 2018 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDIIbp (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:31:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:40883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbeDIIbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:31:43 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVNDK-1ezSiB09Hy-00Ygv9; Mon, 09
 Apr 2018 10:31:33 +0200
Date:   Mon, 9 Apr 2018 10:31:33 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 03/15] t1300: demonstrate that --replace-all can "invent"
 newlines
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <532243287ff81725502f09251d9f749ce1d34417.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eYNZDp3tsxlZ+G4Io/31fZY68JSXTz21yYEUabrhgaF9+UaSyvs
 Ey797OCTE4NvnQj3jCUDjwP000TEqSWqKR0QuF/q/p1UiMSAeugHnuA5NxU5oAVEB6LchSm
 XnApRCE4eUsmGXLmkSHcLwaJujTsQDG31gqxgaNtS75Lh8lO/awiMkLxMcrleYWmHos74lG
 gHA5Y594hjLqYHbgUmwTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tmY8x4OWGhA=:O0CuMiIL7o5bAh3k93C3P+
 3ciB+U15LXrFCKrOnaFYyFaxQjibceZxn1PUTYlsgR1g9jGOLodEqxNT5iK0mo9KzXuMNnl+X
 /Qm3BAMZ+p9p5Y5EgF0z2+mt16Y+BAYsCWEnpbwmH/WSbo8VewDY/XXPqS9xXd0jy2Ew7fHHp
 w/Qc/T2RWLSltzldO3/HQvRCnm7g1rGFYcAWkirQeNdyazIjl6uits3jxECSHgi+xYkusnlqf
 g/E8j0GVEX9hVlDCwsaGrEXezmwkbdZLTzPKh6HtI9Vzz+R7hHknb2V7Utm/2xzqJQcjiYjyZ
 mo12YJl+FElmnmINGrLDasIwkoIK9nEV1NXtfJ/ydj28SkrhEiU5t2uPEjyEBTLhDmOMdaWZC
 94oBh/kC4zRsq5MspFgkh1qB+1b8WXU0NqZsjdZ/N+39Ae1IId3NmSF2Ur99GZEYtx613UFfD
 5aPW+QzVskbrLweTrz689uy9ic7K8H3S+o3kjuVo/CAWqtl1bfGYdJeZb5grYfIIxV5HP0R6r
 rAbHFvqC+5B/OuvcZBsssiIzZQ4wwvw0zXmwgCIrsIgAnKPvTFwcb2Z1Q67ELrVHpSZUqvXUJ
 xiUFYuADJcq2gRlPY7D/GYLBdChxcazNCgFRCY0edZ2ttOAINzR3013Jt2iQoQ4sNlT4A4Upv
 2sTZ8TVwxzE/fTWvUd1uGIB0sJRwHUQ+u9WSvbM8uVuYsOi3DDwSzq6CxyJIInLNI1KtL12sW
 HngRqK+pOvFRr/lNk5XmvBQiT8wapG+sa8Iu8yL4kLvpwKUCeGBCoXpYriHrMsmCS1XNUMMB0
 VUCkrBSunP6qkSJUTbuaI3txdNqoowP9+PVz7exqE7RGb/oBbM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 4f8e6f5fde3..cc417687e8d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1611,4 +1611,25 @@ test_expect_success '--local requires a repo' '
 	test_expect_code 128 nongit git config --local foo.bar
 '
 
+test_expect_failure '--replace-all does not invent newlines' '
+	q_to_tab >.git/config <<-\EOF &&
+	[abc]key
+	QkeepSection
+	[xyz]
+	Qkey = 1
+	[abc]
+	Qkey = a
+	EOF
+	q_to_tab >expect <<-\EOF &&
+	[abc]
+	QkeepSection
+	[xyz]
+	Qkey = 1
+	[abc]
+	Qkey = b
+	EOF
+	git config --replace-all abc.key b &&
+	test_cmp .git/config expect
+'
+
 test_done
-- 
2.17.0.windows.1.4.g7e4058d72e3


