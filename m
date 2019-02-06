Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63FA1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfBFKZl (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:25:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:33023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfBFKZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:25:41 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWgND-1gbg9g1liV-00XsKP; Wed, 06
 Feb 2019 11:25:39 +0100
Date:   Wed, 6 Feb 2019 11:25:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org
Subject: t0025 flakey?
Message-ID: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0T54DewqFzvHCgrhVgq02ZEaUPDDTwHiBqOROj3XiA7Pds6a+vC
 8jDM/CCGMJsNIXq1aFX69uS+jdpV9W4QIPp6jO/CYziR7KOJ5LoZcIOz5+3yj24Sa6dyxfO
 OhVgTOjKNBKP+/wOWXNkxVHt1in7xnTrchMI21L717pOkCIYotNt67bfcKg3ZnkkXcMP/eW
 R3VEa9Bfg4CWcNlS+QQJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2CGUFa1oWLU=:HQyrBPewtmCVf0farpIEWM
 DklDyPdU7itLWcCqcPnuluPqAt5mYpvdycgqIcwxFEaM6O4t9dD7vbqQeNyAu/XFRgRjIVJfZ
 KfG3mn6ZzcOXwyYFgYZfJeAAVWXElte0T0B/KSuNIL2QkQa5YBiH/X04kLYxDmwWmqFs3ktNk
 NvO7QPMA8X+7UuT3B1WH+FLKdDMSe4W/f7ds7tl47QkhBfP12WJIE54alWILKsN1V9DWRP51z
 8bLnKRMwknA6d7U2h6W66Cfn336zlA+Oe1ydX4jbLv6iPEjr214/+wSNz9qJqq3bMIlR8/E7l
 ULCKEybvhsey/YYG1nJ/sT8j1U1+/kcLDMT6CXOJ5j9lBGe1V9RhN6AszIe0qiUlZWslP9mKs
 kLSXUCGJNW0Z234FHnNdZc5tC0wA8M20HJO+0RkmVjJItt3BdAgMvXemNzyuNCflOxJHjV0ZO
 pJY4TMV/UjnqOZGelOVHrFDEClK1fNvqbJ4xjuK3Y0zuS62pRRlfCXZYG8CUQWzAhJxoyRLUj
 HSM9N57eI6QYjUv5UJ2DvHboQQStepF2WamL8BNazN9xPrIotMcdyUENMx+cCmR0eOKJTYmze
 UTKrSAIYR1ISeqIzcW2g6Hq0z24omvc54KmY8lasOVg9Qvaei7ztnCVFVoUWibUh2dLGu6+xN
 3H5WfBygsqs2nuPS/zdEjfaq61QYgjtPWE3n2onQDcFBRHYx4gTxnu45kJo2iwfX0gtvMzQXF
 A4RfATqmDs0WuDtN61913eaU36PHEI6MpsTFLOHkp8o2BbHMPmc302Shwn1OglWzAKjkcOrsY
 RP5POZtDwpXRmNHolIiTbzG4GiP2BNbDImrpZJH4bKEEfOh116Ldx8q2O7IV1Y1tqWquQy7JW
 WpIOWFo8lHzycyi9oJLco0s3ImkHnd5Ce1CzIrc385IEv0bvnqqxrhXeCTc3fkCgUGHCSukBK
 f+wfT6T8ndw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

at first I thought that those intermittent test failures were limited to
Windows, but they are not: I can see it now in a build on 32-bit Linux.
Full logs here:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=1032&_a=summary&view=ms.vss-test-web.build-test-results-tab

Excerpt from the failing test case:

-- snip --
not ok 2 - renormalize CRLF in repo
 expecting success: 
	echo "*.txt text=auto" >.gitattributes &&
	git add --renormalize "*.txt" &&
	cat >expect <<-\EOF &&
	i/lf w/crlf attr/text=auto CRLF.txt
	i/lf w/lf attr/text=auto LF.txt
	i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
	EOF
	git ls-files --eol |
	sed -e "s/	/ /g" -e "s/  */ /g" |
	sort >actual &&
	test_cmp expect actual

+ echo *.txt text=auto
+ git add --renormalize *.txt
+ cat
+ sort
+ sed -e s/	/ /g -e s/  */ /g
+ git ls-files --eol
+ test_cmp expect actual
+ diff -u expect actual
--- expect	2019-02-06 09:39:42.080733629 +0000
+++ actual	2019-02-06 09:39:42.088733629 +0000
@@ -1,3 +1,3 @@
-i/lf w/crlf attr/text=auto CRLF.txt
+i/crlf w/crlf attr/text=auto CRLF.txt
 i/lf w/lf attr/text=auto LF.txt
-i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
+i/mixed w/mixed attr/text=auto CRLF_mix_LF.txt
error: last command exited with $?=1
-- snap --

Any ideas?
Johannes
