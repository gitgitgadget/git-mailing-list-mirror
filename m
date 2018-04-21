Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88EE1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeDUJwT (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:52:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:56895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeDUJwS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:52:18 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1eWf5V1dCR-00fhQd; Sat, 21
 Apr 2018 11:52:14 +0200
Date:   Sat, 21 Apr 2018 11:51:58 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 09/11] technical/shallow: describe the relationship with
 replace refs
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <6527ac4a14623670ef2804ded921ba7c308db218.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QAfkEpryDkGEtfC8WzJBXePgKKUiHWYGFKs4J8stPGwV/m70qx6
 pqdzhdvBqKFlxjlwaaN5A2iOi1UmpMaf0a5sQA4SwN2QtgvjkxAiSVceoGdWgtb4H7KJvpG
 RRjlpeSh7zvN4H4ckKd0BVhdNqljXLJ4H58x7jnFbY021K9kkF6VjGstwyHJCkn7Vn+QO58
 Qdzm/RL4FNW1DM+CVOMdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CJT+n5vUhfk=:5paIovnUU0cxqYEoyh/XX9
 JzgnQ9LjrxbrfQOEiSLtVWkyk+L1QsHwDOfQ9VvYLFjwo5sGU7E5oGklF9Eoscmk+gQwmy+H3
 d/jXf1gNRsgAabF7meLTgL9IPOaXYJV5DUw9MJ+0Juz1Js7x2N2MgUoPFnCTcxs5WQel1Szkz
 hJwuGJESME3J3WhoEjKx+KyZcTyUkfG+rgkRlXD2kodSCJsCfJLC7bNwEjSmOXzsO6feJvu5V
 dYnOwxhsXBfxRMKx/5JRl/xw1QnP/i9mKD+vTBzLwilthfApH6honFGFtHotMT03J8tPLrNdC
 rnOLI7VN6484P5p5+W6PLPoDWEeTbq+8N1ysO0uA8YPw7COBgXpvG3ugQNqrqIgonvjIGH8d6
 9zH03XdavTmfP7Td6uK2Ua3POgNxytSxYjKwkLamVpSCf+383gveHENbu6Hlgq+fjT8/tJZza
 gnpBMMTqcpufA/7cF10dE+84vDIrxDp5XGMybGgk/kHkJwN48ElVs1oZ59vlEKjzg39XtDBdz
 b0ma6JeCbVKRvDCHmcDOLC5LTL775t8YK61N6BTDjKqjJ6Ru63wLLg2ebmEIx77T9xTNBZK7Q
 vrm5AnmQCVdjU2x5/i80hn7If8PfDyKZNYXRIv5QNr3NImF92Zr1HMBHA6YXBthOzTQt6lnqZ
 LvvU139pQexutWfAe1rBrjdJ2VJJLY5iRNd4QKwGzADE2+FjiQ5yBeXk+990gSQT3X3OGEeBy
 IFIV1BFRfHpzSnzc9AFF/MHSUJUo4hnFXLPBWrazHIqFHFb00rkuyW8klhi1k4fH70DPCT23H
 /Qko8YfwcqMk5uIMoN3Fx6BuDgFl39HpKMILPT4HakW3ZCQdKI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that grafts are deprecated, we should start to assume that readers
have no idea what grafts are. So it makes more sense to describe the
"shallow" feature in terms of replace refs.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 5183b154229..b3ff23c25f6 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -9,14 +9,17 @@ these commits have no parents.
 *********************************************************
 
 The basic idea is to write the SHA-1s of shallow commits into
-$GIT_DIR/shallow, and handle its contents like the contents
-of $GIT_DIR/info/grafts (with the difference that shallow
-cannot contain parent information).
-
-This information is stored in a new file instead of grafts, or
-even the config, since the user should not touch that file
-at all (even throughout development of the shallow clone, it
-was never manually edited!).
+$GIT_DIR/shallow, and handle its contents similar to replace
+refs (with the difference that shallow does not actually
+create those replace refs) and very much like the deprecated
+graft file (with the difference that shallow commits will
+always have their parents grafted away, not replaced by
+different parents).
+
+This information is stored in a special-purpose file because the
+user should not touch that file at all (even throughout
+development of the shallow clone, it was never manually
+edited!).
 
 Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
-- 
2.17.0.windows.1.15.gaa56ade3205


