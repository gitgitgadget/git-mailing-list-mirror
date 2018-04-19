Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F6D1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbeDSITM (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:19:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:59973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeDSITK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:19:10 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJjUO-1fABFG2Pe0-001CEN; Thu, 19
 Apr 2018 10:19:06 +0200
Date:   Thu, 19 Apr 2018 10:18:50 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 5/7] filter-branch: stop suggesting to use grafts
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <b697daf8010e2fa34f6997bccf5330b53eb46f6a.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4riyAduWUGQWi7o8fAEtzf1T+PXTfzseZBdMGmUw3E7LivTCKlS
 Y4sSFZJDuWw80PozR5csz7WYAtbAR+wGTiOtsD64nNuMvv+o2ZvfDFKYXjBQQHUxQoy6Tlf
 rWHidLPrw5EdBqS84e8WN41K65ZuVxvdkSpdC65I2knLD9M06EBvXvu7AREY8W1iPPnrf9A
 6xDWzdqAUpeiruf9ZJpBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aOuot277AHQ=:vNQ93FjgvC7NnI9zy0ohbM
 x9yAN8q0zP3rj8axu9OVKxck5H+FMHv/HniLITz8hrlY8LtGlhPzeaBk2ow6aD4qKMyCThz0J
 kWIHEzG+xVB5f7YZWuIrDREx/YosTgqAfhIUllx1Qro1dX+ETE6FHbJIYzsKqw1DWWdRmirJI
 ou30r5VgVMWdv1aYDKs/LrGe8QUHhxboe2OoWRjl2lLEa3XHO9ZOI3MUaMYQGC4iun/17zEBQ
 12ll6VVArPICdR5DL8cAHYenrOHz7okFsO2yCnvTYyvOC5G97ok79vgreOp3sC3pVJ++CALnP
 sHG2yHXlI2WehxHh5mUY72EQVClE5VEn2OoTgGpzaA0pKWXTm0cLJ+FgUeBGJocOwdSHTOiEW
 IoUOV3icebzaYpQdmAEezXqmW/rDa+tnG/yInMT8q07DXU9Z0nuBbz9iTJ9ipxjFgCnFVh2TO
 /EQD9GXsT1Vi4B2fRxFd3+NIWi5k1bXH9Hlj2PjsAYmhUaFWIZjg+2pJqhfirPyfs1souwxxQ
 QYpFEvxIgiwXfwRV9NpKPTZShUKf6CGwmFWlKu3tQGkzSklErZ1tUS7p5E3mfboQ9hG03sgBI
 yCaLVXaR+GozmmIV0dlcbSXAAFjYFExLREcaAUALdbi0B0qA8u4EhB+1l2EN1epq4BKQg7lKm
 hS3YV4gxZ9apbOwNPBhrNf9EdQqNaGUlTPBzShO8cmMe/M+ZLySvKQgwcCvYPtxPaUd7m/m3p
 aLCExhXokXIiaUerKLRQH6gXVq6y7XblEoOhZJCq2XxfMSYggP1ikPBnOKKtipotj5XwUM4rS
 /aUsXK3ds4KqSvNsl/9QoU1cRjSALt3H9frn37C/TgP1YqDtf8=
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
2.17.0.windows.1.4.g7e4058d72e3


