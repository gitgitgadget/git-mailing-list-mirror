Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E431F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDUJuT (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:50:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:57991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751433AbeDUJuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:50:18 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBZ9u-1fJDMG1Pmg-00AWjC; Sat, 21
 Apr 2018 11:50:14 +0200
Date:   Sat, 21 Apr 2018 11:49:58 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 08/11] filter-branch: stop suggesting to use grafts
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <bfbcf732e3a8cbd8cd6255051b5d0397089d6e58.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VKMV+QSjX/3G+5GQ2EO8rJlD2gs1jiyOaapX+MLdw0wdB/1HhgU
 eEsZ1iJrjyBtNpBMishppL+8/cCvMZZc0yPvmSLqhPpObzLm2Ss/NswKKhXsMk7bEvb+JCG
 hTBGMfHcdbO370KuD+2WZ/nrbqf00Tg00bZOZnkMBjqEWdTi/JW2Yd0Q51i1yd1WEiuWSS5
 pRTmjV9mPCzeF9vFkLb9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pxv3wIvSilA=:vZ0wYoL5ediQadZRXtvDk/
 7/44egQ2zIb5v3pNJcWxdZ1O6OfQuR9Y2j2QZSgGZnNOgV0/bt3p2rjyM2WuKEgukFc0exZNx
 mQUOXpTXYN4lF4sQBu3lgado4J3PAryUGS3oz6By9mWwVgyF7aIFoLrtiv4KKUdfq3SzxsDg8
 9azWHLIDYGg1KB0JRlW2IPznjbKWA7G0V0DJCrKH/fWTNrmWjPENc4g2yMSlxKXdAZDLkLAXB
 S/CWxuSGzWHKKZrfcznejXtp40eu5bYtrXDpV437Wzm/+3OGegROlaFBdp4016tfiyZiZ0D+O
 0cEtfE5cXTw0sLJuTUyVHEplKzy1tRcZbIVcksHqFqRAseIsbmApw47ejKknXsqfND1kLG/q5
 EW9ldhoLTAgRwDT1JnA80cQ7DDsVUUZfdp5A5LL8CNkYdaPmVwSY2bQ2pHT0XweScjUjaas4C
 ZtUJQNKFDB+af4ZXVhF1B8mus+yWjCy66WOQf0HELwrz8OajILcKoSUWlaCiTw9yxckSvc7EP
 7QkEqkX3tAqa99AzKxIhrNX8CB84fEWff+7n4hRnjD5pKn3KIA9SWISDAZC8Z2n4KFyeq5uAL
 k/AiqK2KsIb7mWeZyzMP6+EiwSDVq18G3elK0l/slymNS5WqN/ojvVD+MGoRHOdtm9vnDBJNt
 7pB178I3x/6Tx6M2scwqf78ulm2EReFtN586lz+62W7LiJ9BJcv7IDEkwpcZy0ketBDgilXt6
 odo1U47ckGOmpIcT3v94cQHMWArg2LpzW4F8W+WElZpPAXTAWRSfVOhGPyGShbv9mizYYfUKt
 1Tg5jTRJmXCr2lxwyxZZAryDoECkfqp3rIf/LrKjSBpIXo8BrE=
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
2.17.0.windows.1.15.gaa56ade3205


