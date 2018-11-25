Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040251F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeKZHo0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 02:44:26 -0500
Received: from mout.web.de ([212.227.15.3]:38815 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbeKZHo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 02:44:26 -0500
Received: from macce.fritz.box ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAdrf-1gFDh11flj-00BvOI; Sun, 25
 Nov 2018 21:52:28 +0100
To:     Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t5570 shaky for anyone ?
Message-ID: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
Date:   Sun, 25 Nov 2018 21:52:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VL1epcWgprmllPyw26e1V7R+pFu4E/ln1KC9H3lp9bexqF2wndf
 GzEb/41Of9L5MfIDpB0V/PEXMYiR1bue8XUkoFimc1HZGk0hHtLgLfIjhUrCYLOtw25T2XQ
 CJJurcU16Gd+6UwoxBAYrHZXhNevEPLfPiCrPGKHB9YUneWsresVkz2olCy6XbJgzi9jcFT
 p4p67kAyvv3+tKjPsRQyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cDHHKiG3I0A=:eYWwYyyJQVeX11QLddhG4a
 FKffCD0NE5QnXE/qN7UKxRxwDrXM9wre+Q/tGd+BTk+Xnx6qBsmPrPMKtJ/uIPylEWbA23/PK
 cytGhjjeB22mDAbzTVIawwATAmmcBT63CW7x3y0r8gnxJ0kGyzkzs5LBD85u+Z9RHxFCgXanl
 EgF4CFC/cGr1wnjQK1BRIYJISXLx5k/6BCGonSCGH8DkY0vTBZBFjCvkKiWm1kwvl3CvPNR7l
 7KUeBCL/37DcfDdHBQZ5KiC/Xt9tYeFO9NSQL30iCrr7aCG7gX6LBrobLGTJuO9qdFu0JWaZj
 QJ2y2Xs+8M3foaJPNWsszo4UMJ0BQ1RyyzOlSzRXAckUDmja+YagHPq2CsACT+3/tCBYpLdz0
 rtKVRNMKDC+s+UTttZnZLjVSCsVdhW6idVT/N8AdNNqg3vRmig/A7/vRqr1RM92d+GQB5rBzO
 yQ8X78nwyisSI83lMoj1K45/xtreZTtykIxBBohpN1aG1smMa9tK3Vz6MHUEBBZjIu0scPjQb
 +P2hPP7xeEg7m8P1giNcklWHdk1l9516QkMQaT1QHfcKBopka3dlCFWgvRyRtECwd0rheETly
 IQ8lrCTfjVHfBAiAVpTuwm4Z6uQNT24+eWOFWgxUdhbrjnRUQjqJNQBrhanoROuxJNRVV+kzy
 rqbj9/tyBcB8Ei/O0ezSrTkKdtiyN+mmURrndZxwY2iVr62mB3YzODyjaQpbHuwY6xI7EVHlm
 pKVInS3etjnbG+V1jTeuJ15v2SHlR5BhdoWGEEY/Vpm5My4hEaOSnEBPjkEaR/J7nLGaXJqmB
 GM28die/AK/u6of+UTQw9SAnBJKtKoyNblZBpUNBXsrVYAGfGoszBVCRceuujl404mPzZMGuc
 9o7VptNWFnnmKwTBK42RwrcBtRC400ooZxVZvFeTz1M+hG2WPXePlfP4GQeYWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After running the  "Git 2.20-rc1" testsuite here on a raspi,
the only TC that failed was t5570.
When the "grep" was run on daemon.log, the file was empty (?).
When inspecting it later, it was filled, and grep would have found
the "extended.attribute" it was looking for.

The following fixes it, but I am not sure if this is the ideal
solution.


diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7466aad111..e259fee0ed 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -192,6 +192,7 @@ test_expect_success 'daemon log records all attributes' '
 	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
 		git -c protocol.version=1 \
 			ls-remote "$GIT_DAEMON_URL/interp.git" &&
+	sleep 1 &&
 	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
 	test_cmp expect actual
 '
----------------
A slightly better approach may be to use a "sleep on demand":

+	( grep -i -q extended.attribute daemon.log || sleep 1 ) &&

