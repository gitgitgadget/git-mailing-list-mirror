Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336DF1F744
	for <e@80x24.org>; Mon, 27 Jun 2016 09:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcF0J6I (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 05:58:08 -0400
Received: from mout.web.de ([212.227.17.12]:60160 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbcF0J6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 05:58:07 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MCZh8-1b9BpJ08GY-009ToQ; Mon, 27 Jun 2016 11:57:55
 +0200
Subject: Re: [PATCH v4 0/6] worktree lock/unlock
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
References: <20160530104939.28407-1-pclouds@gmail.com>
 <20160603121944.28980-1-pclouds@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <914a6ad8-94d7-d26e-8c6f-f9656d912818@web.de>
Date:	Mon, 27 Jun 2016 11:57:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:F+qDErAy5Wwq83drgjVEDJeEMHt/zk/WXodCyAV2chZ4c87arwp
 L45o30JXQL946NG41S7lWL196aRfrtyFkaPPJUcraGqCVOeGPFFThFlzhIuafdiasZaLERN
 9cI2P/HX5PvKxnF0OxzJkkSGW+2hvSbhrbmhRiHQXfjoXLEfW7fcLU+G29sNRzuMNsdOuVl
 W/yKOrGKXclNaEjEiVQhQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:W0vtzjGkERQ=:puRdGEEv4sXtvwfEWkyJCX
 1pnVZG22uwyvNLBUnBOlSLbhOP9gHW0R1rYlVVkeV2k3STuVd/KUG68tfnt20Ew59bXhRfVM6
 qVucmo8FO2LXgX3IqDE6k0ItKZHAKCawaf0tjRlkjhTsrJR3ldh/RfmC14PdV9t2Z3yLoA4Et
 MtMIuUvTH7wNfYlcXlgQ0h3zt56SXPCO1CmJgUrml2InFVWVOHFwkU+uW0Ws95Q5zDIpAjW0V
 Gwe2KDEi7/7bCvTWdU9ejZVtF7/r1noTvtLsoB+StTI8uSiIPYZe/ufAAY8WaHRBHMhCU+nFv
 xEpp9d3GU8wTW0f0B0ijaVNrfHVSotcBTqhF0/bHmF6ywiy3tqqsMQPBi+SRFDkOEs53r5DoO
 eYbeDNQPbBwn8z6F0/EOhnr6mhvYk+Ew4DCn9e762ojpypnGhNgsUjhq4f5H5cbg3kwJCqYiN
 35c5Zgei4WJy+gjmrO406yAV1uPL7wfXKgMDjPgY90BMBomRLq4aT0yoG0PRoCuq3udEptDMk
 X5gPm8Kiz3I8mAMetnoQ44HkXwpEqjM7tzOG8SLYfLMFF6Mh/MyTfVaSUUunpDW082ANynlqg
 lcCP73UZCeqJicUuGeTslkk51z2MTosopZDteH42S0XjnNJ7jwLPKj5JXE6JruHNPquAOuzxJ
 O+SowfTHyDgfITAWb3gko286uS6OKlgGILra7Uudl/7sFh5FyYxEilhazKNTP4bO02vPJVKw5
 WzKu1H886XdcI7FRLsKOKEdqXJpnmkAskFX0EKHA+1VfV5BSWaOSPoH27gI+vwCyg+CPMaEIE
 AYjX1bM
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>On 03.06.16 14:19, Nguyễn Thái Ngọc Duy wrote:

Minor problem:
t2028 fails, when the test is run from a directory that is

a softlink.
(In my case 
/Users/tb/projects/git/git.pu
is a softlink to
/Users/tb/NoBackup/projects/git/git.pu/


[master (root-commit) 2519212] init
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 init.t
Preparing source (identifier source)
HEAD is now at 2519212 init
--- expected    2016-06-27 09:50:19.000000000 +0000
+++ actual      2016-06-27 09:50:19.000000000 +0000
@@ -1,2 +1,2 @@
-worktree /Users/tb/projects/git/git.pu/t/trash directory.t2028-worktree-move
-worktree /Users/tb/projects/git/git.pu/t/trash directory.t2028-worktree-move/source
+worktree /Users/tb/NoBackup/projects/git/git.pu/t/trash directory.t2028-worktree-move
+worktree /Users/tb/NoBackup/projects/git/git.pu/t/trash directory.t2028-worktree-move/source
not ok 1 - setup
#

