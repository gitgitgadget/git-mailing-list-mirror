Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4721F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759342AbeD0Vkb (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:40:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:39505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759330AbeD0Vka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:40:30 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M9K5G-1f6A251Gb0-00CiH9; Fri, 27 Apr 2018 23:40:23 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 09/11] technical/shallow: stop referring to grafts
Date:   Fri, 27 Apr 2018 23:40:09 +0200
Message-Id: <7feaf8466df7f6bfade72d02c756f827435a3c8d.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:ZP+MpwK2gGXZdzYDtdwWUhVmA+U+/GQO2Xi+dP0nHnP1TyVYkgg
 JdgivfVJcU6IjHoNAMXQx5qFFgpPAlymSXMr1ZZ4OXjkJmw45X78gnKPtPRTTYYkh0f/lWl
 HtV2Na6OJTPTuIpNL/UVXa5g2/AZd7Y3AAISXFg/7/kG/ubL8fPtfDcJdwfttB6GHxDB5wM
 p5ujJZV90TboWKLY1FFrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SZMqED/XiBw=:LlRq+d6NzT/zVcx5nH4grr
 7wmBdJC70Y3XlKGoX0rQeJQXL+3YU6yIvobdtwsyo981DLGbMS0RUZrK4uaMKbhImKPDwucu+
 kAAAXz+5wyqNjlqfYSmUqd+V+j/PkTtbhav49oK3cRh+u7TkcKe7iLMbVmu9ebRGPJg8EHC/L
 EZxBQ7A7GnoACBo52jecT9pqqtftJgooweaP+F/RNx3HU9UaeLgqYETcRmIQrxipatOvnLajl
 9TZgORr77Aj2ApEq8swXBaJuOlpdnMgsNbeT7OItZwwPcN0VFkrM9s04/i1p/aulEygYaQI6/
 bx03Qju9uubXXBPmP0hYmhD1U/YgETHQJUNzYcGan1ZqBUwxXxAiujft6o43ulybsU/V/UH8z
 fRWr8gny6oWbaeB0CfLr0He40MrM7U9QUBkdtg3OTcEOrRjgGcEL2dthin6WmZrLkgCgVqITw
 dtSOkbBzWQ8axK0Pz0jhdmmFCJyTnElCZJn9yF/aMlEfaBViCfp/QJdh+M958C0zR2o4kh14N
 ixAq8pR461uh9xiUPc8XKiMUOnUPKTV9I6n8oCrbKyxB7JGDrQo3hqRe433wCGe/vlFKlTusS
 xJok0p2k11clXUfvqX8wG1DYdjecuF1pIpJPD9ymRQnB2TQUotT9yvgROFC51wEuLPhnEABY0
 Nh49Zz2kwGyDpDI3NFtDHRoTFj0YTVDuTw6Iat60DiqnkCxsRTv2NQ5ujPElW7c9+/04NBxTW
 dX1fR9Z+Mu2ZVYV6l7va8+hEwMGhbvIa2EDI4lYqpC1129o+9SjpIxFJM71t4rj2TUkR2EuR7
 eVswhb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that grafts are deprecated, we should start to assume that readers
have no idea what grafts are. So it makes more sense to make the
description of the "shallow" feature stand on its own.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 5183b154229..4ec721335d2 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -8,15 +8,10 @@ repo, and therefore grafts are introduced pretending that
 these commits have no parents.
 *********************************************************
 
-The basic idea is to write the SHA-1s of shallow commits into
-$GIT_DIR/shallow, and handle its contents like the contents
-of $GIT_DIR/info/grafts (with the difference that shallow
-cannot contain parent information).
-
-This information is stored in a new file instead of grafts, or
-even the config, since the user should not touch that file
-at all (even throughout development of the shallow clone, it
-was never manually edited!).
+$GIT_DIR/shallow lists commit object names and tells Git to
+pretend as if they are root commits (e.g. "git log" traversal
+stops after showing them; "git fsck" does not complain saying
+the commits listed on their "parent" lines do not exist).
 
 Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
-- 
2.17.0.windows.1.33.gfcbb1fa0445


