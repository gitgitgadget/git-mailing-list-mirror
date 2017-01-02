Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A086205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933330AbdABQY3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:24:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:58828 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933055AbdABQY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:24:28 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOkQc-1cT0ol2ilK-00636I; Mon, 02
 Jan 2017 17:24:21 +0100
Date:   Mon, 2 Jan 2017 17:24:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: [PATCH v4 4/4] t7800: run both builtin and scripted difftool, for
 now
In-Reply-To: <cover.1483373635.git.johannes.schindelin@gmx.de>
Message-ID: <0ae4a950a4cd2c8c4f05a6b46c60f127611580cf.1483373635.git.johannes.schindelin@gmx.de>
References: <cover.1480019834.git.johannes.schindelin@gmx.de> <cover.1483373635.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bPirGf7N3UtCu/t1ACzJhCyb8SeewPzgtXvZNcwoXG0Zi41nWCp
 3gfy1jvGJ47YvXe6fTpbZ5wJSvARV5YxE9J/7gmIvHGKzyezNVjLX2XVEdbDpK2qdeVgaud
 oaxP2LW1BwdIVe3lRDYOyMXPaMZbc7tstVug0ZxvQIxHVY7s25AB27xZX64eKVSainIR8JR
 RIejy9P01C1bwwYQYYGzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UzbKFLOQLjo=:OS9TwpSjkoPOa6STyM2DVQ
 qKTSxHfVIuqIjVWfiubsAgVwvvkjtaSkV125u+TYHRRHWLJwyt3A8D6Tz2/k2MM3StlGcm6pk
 8OYCDOBXnqpT54awivMK+v2j8c+Aof2PfMLHKGDBsZUidP1izLiT7i8rVIogyTixqj6vvkUNs
 T0HNFIG6bNrX9yz2BklCp4vhkX7+Q/AI4JkSmfXLm2ePlJubE6f7lMIINzU/ku+1NUTIqLTFn
 buyrtYu6yCaVGPdaozabJwD9D/WFj4CvWQgs1BJOulYz+t1ATvJuX9deahEM9QRmaW6uq7bSl
 R9BHOXep2c8ewknTuCp0NrdjceP2LvEtPBk7ehytXe3E+WUcz01YxhCrD9F0qMLvS0VmDUliR
 dwcu8+G7ciNFmPf8WT+9etmBbwUNmI8VB66m5t161R+WtxavtHGFda99mUPEwilKaKPgoS4ME
 PSlJY5V9X6YbubTru9rj1zKNnlG7jxbfS8KX5iZHOvqZTatvFAtkNgAca1uYc1314lq92DeoP
 ml1dhlMmBSTV29keQsccxfTwlCAYNTtI9xXDTtf8QYsAe51J/lKSPaU3hEa/EtwN1eEsbxYbG
 zuAQMtIMiuL862yQiu2rWHbCnfSE4uAeJbB+xWulZ9Ndk9kofkCetsczY/v1Qh33DT6IBM6bx
 FyLBBM1nSR2zIqWpJ26F/h7aoSvYMS3CztQ5X5HuiAYk0isqFRt/TRzLJCxIgtPE0tFyCYFYr
 VhYndOR0I8GA9/a+bYKw541aqTz7U8I8xWjcpPFnUSApfI+vCGP/SnelFeL7U7vfxSNmi867Q
 g0dWI92I9Amqe1X1SqRAPHfEEtY/6hRW5hkUvOtFGc2WFfS4Jarq6Y0fQdKECACHw9bVrDpjt
 77rOimuXP/9p4ndwdP/zbLnTGPovGm941iCBSuuks+PX2LaQ6rMjuaAB3VwnAA3iaGa7FOqnz
 nzcp8UAJdV2Vw9S4e2fa04x1BGuTCb83r+XXmQRUJDaczERu0/0O0GAEU2gV3QTaA+Dfd9PNO
 nJnqnxStgYeaxlDV+OdkNcEZ8jfYEOuXKf5ZFhN8/PVsPPH3dPk2E47mgQYAFB1P7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is uglier than a simple

	touch "$GIT_EXEC_PATH/use-builtin-difftool"

of course. But oh well.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch implements the good ole' cross-validation technique
	(also known as "GitHub Scientist") that I already used for my
	rebase--helper work.

	I am not sure whether we want to have that patch in `master`,
	ever. But at least for the transition time, it may make sense.

 t/t7800-difftool.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e94910c563..273ab55723 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -23,6 +23,20 @@ prompt_given ()
 	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
 }
 
+for use_builtin_difftool in false true
+do
+
+test_expect_success 'verify we are running the correct difftool' '
+	if test true = '$use_builtin_difftool'
+	then
+		test_must_fail ok=129 git difftool -h >help &&
+		grep "g, --gui" help
+	else
+		git difftool -h >help &&
+		grep "g|--gui" help
+	fi
+'
+
 # NEEDSWORK: lose all the PERL prereqs once legacy-difftool is retired.
 
 # Create a file on master and change it on branch
@@ -606,4 +620,17 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff symlinked directories' '
 	)
 '
 
+test true != $use_builtin_difftool || break
+
+test_expect_success 'tear down for re-run' '
+	rm -rf * .[a-z]* &&
+	git init
+'
+
+# run as builtin difftool now
+GIT_CONFIG_PARAMETERS="'difftool.usebuiltin=true'"
+export GIT_CONFIG_PARAMETERS
+
+done
+
 test_done
-- 
2.11.0.rc3.windows.1
