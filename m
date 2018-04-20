Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2941A1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeDTWZj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:25:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:55317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751860AbeDTWZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:25:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbrR4-1esXYh18PW-00JI9f; Sat, 21
 Apr 2018 00:25:33 +0200
Date:   Sat, 21 Apr 2018 00:25:16 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 08/11] filter-branch: stop suggesting to use grafts
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <8c0bcade20cf0b475f9b3d15f9dfad37d3ad6d4f.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:18YvoM4nLEXC+B3gyiFQXJog27FyLcmQD0cllIuZ6vmqrpds+BT
 BCd56KoH8oE/y9ffaNjlvQgLyoGWrbcCM3PphbEDDwbX5IuY0TO3+Z1yOSwfUT07lpG52J4
 B+uhTzwxZJiTEixnnIjyLnRP7Aq7dCDNzq4AnlgucXnszOUBwQAO7rCjq9MAnG9aa2t/bfv
 NfstOejLUi9RSi69Mzrsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3cByp3id0CE=:6bdLi8skONn6sH8qTxiJBm
 6Dc/YXPqrx00KEi0gJrFGaBiTLPHv1ud+PlRMrPlPB9466mFi+OkVxvHHcR3QeMJKb7KLLrWt
 yqrky3PEPXIMvD/c4kE/ukdjCXnI+z1+mrWpK/0Szg/aMOaat8OCId/WFXkIFXcnxt61jvhHK
 JM9SzUiuocuPKmPqMmQYmM6gieAq/L467x4KQMIJAjBUMJ36mktkGlt28nR0y/CSa8JVZOn18
 ufhvuhv2Y6O4xfJDLZAuo9svkPLfKuQjTYTX9BEHWMEZXVKIKxyBqgPsqiW/+T2LkRqe4Nj61
 8o5lUSiLKgKVxr5wFAyzyPyJCO6pZq6BsJlE7ARGOwzuRRf4cMRVtnNyKlqTksMyuFoeUGFL5
 36+VSdoK8tnWlqHIUD98Ardy8OfUTlSmZe4fsEgc4iprv/uIxmDS9jn+X4ejNCdk1BL0RMD3E
 j4R2p8C9VFOPcimoAv5XfPfhCqf/kT0z1B8krr7Ts0qu9GCZ8k22YX4p6ixlqSf9Dp6regpEZ
 hGcikwpPMNpy7Ihh2Am4FyLVhkGzRF1UYraDTfvQNa7KKMSd/ubiHAlWtjwkWs4S6jETsFUdC
 WSyMXP7iOQ3Lb9f+mjyF4F4nDlgl3E3L+bQlM+OTSdWB7HdcFqEnNJte/5Dmf8ilXbK3opd7L
 +7vZ9O9Kt4DZQSQDbl4/blxxD2Bcay5y+QqdBak9pe2s1xz2xy1ekXNLA36TKQI/r8Lrepmqi
 KqUFNfIGZbRj8fSjucqXS8U5J1aIGsUJSU8kj3LNNpQTIDBJhSDhTLsUkC7MOg6xSoxRQDNTm
 MIFQXcgGELjidX1mJ6wSTEDX4mPrHhkp59ELwcxE0evQkztUBY=
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


