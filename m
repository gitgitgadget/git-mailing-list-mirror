Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F461F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeDYJym (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:38227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeDYJyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:38 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M4o41-1eSWEW1j93-00yuZf; Wed, 25 Apr 2018 11:54:33 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 08/11] filter-branch: stop suggesting to use grafts
Date:   Wed, 25 Apr 2018 11:54:27 +0200
Message-Id: <890a48faf6c77027d63cc5ab3f139a0fcb33eb30.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:mgUXMH2MHTXP9bIaHMrr7Mhw14AGfsweUlSxrsPFRWv3B6NxgRJ
 4WVn/ygA7GGDTQqWfeFiFtIgVIWaS7s7uGXHvQdwFxVmpuIiC38esbljRvfeS4hFP0jrfVc
 nehqR399XwKowmAEzT+4bxVXZMHyddHsTXqGVWbtuOKhHKt8Zh3s88Y4jVg2B6oBT9YUxT+
 vb3oZVNVGxd9hUVgO8PEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qgC8aaP6p/w=:no6CAM3WzcWKz/fAtFhqZz
 o3ca8EX0AUuQR1tEEiQsj8VHhusgcOgJRTjPrmHexQRrK8/Sj9IXeQb5j/snmP5fNcPESq7/9
 MaGa6hzhtoFALbTDNGk3+DTMRnpXGewt16JB4t1vMZsyqyQ6fgWGv65GeoOdS3Lz3JZYBL7jD
 MjI6r9vkQsFXBGkn2uO3vy+Suw0CEdJBSZxWDWSgg/Ot6eTDGcLbtxD3QpaUscgxP3pv6zmk0
 SyY54NScacntcV6KnrMOeERv8gOrAmNs34j2ewE/zsnbCC1X9bXtHACo/q+d4ThmqENlTbt7E
 EGJE/r4X/+Q0agLhtNXk2QazYXFSXyrBNTiMfxuF7N2t5jYMOYxPLT8vy9seSrxwC24ITupT+
 fXPy3Lyn54bLelt8E4b45NKYqmspKnYOjMnyFTyy/vL3q7CPouoxOZErR251A4VsU5lqiMLGV
 aZQ3Mcss9KX19rKPHQB2aLKxdvberuCxOKgtKQTBx8XI/aT+Ry1uPqrfpqQHdgZtPHpl3Zi0J
 c59jC4S0vAGxOJB5sOrgCoOkVnZc9h61S/SMxBJQEecCNzNIH8GATVLfDG52MPtK5zOSQCwce
 UsDvtiCQRf8OF1pFPHn17529xsIAbs3B8gLtAQXXvC6dEO1f+vOeOVlOzPFERWg0CqDtkUXut
 bAUC6kwnkCysrvafZTQf3LxvEXrK5azTcOGNhf9w9doBCj5xd2BV3MYObv53x2upQz8ZaKURN
 OifuurUIVQycjXLqx6NuosqzngAU8s76N5NkAvscXw8A6rvCslCFy0mRLKuYYXQPKcfAwiehp
 3TiqJSVWz1WkE+bSv1hvv/Fysx3n5dXiSxMmcPXOhWnVn4nYuMixZ0Nz1ai89iZQyDvSt8P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The graft file is deprecated now, so let's use replace refs in the example
in filter-branch's man page instead.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-filter-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index b634043183b..1d4d2f86045 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -288,7 +288,7 @@ git filter-branch --parent-filter \
 or even simpler:
 
 -----------------------------------------------
-echo "$commit-id $graft-id" >> .git/info/grafts
+git replace --graft $commit-id $graft-id
 git filter-branch $graft-id..HEAD
 -----------------------------------------------
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


