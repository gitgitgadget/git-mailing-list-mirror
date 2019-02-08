Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A071F453
	for <e@80x24.org>; Fri,  8 Feb 2019 17:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBHRnU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 12:43:20 -0500
Received: from mout.web.de ([212.227.17.11]:58073 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfBHRnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 12:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549647796;
        bh=wYT+H02B41VdpW7ki9qAAYoyw+TdKCVRzs95dRbqjjw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=m0odBARFwbqvn1KwKI62lBUXIiwprC1oEYCLHw8CVKYexPQrzqFVLt5/bdaekHFZW
         T3nvflN7B68gSGKVw2KTq7LBspYLjP5BsWMFp5QtjKulu/ezYr8nuo3SQBTpen2/cH
         hOD2U36E0WBVoLzQXnFMnOpPxRjtLOJYJx71/1uc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHXxg-1goqnQ29zo-003Kiq; Fri, 08
 Feb 2019 18:43:16 +0100
Date:   Fri, 8 Feb 2019 17:43:16 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
Cc:     johannes.schindelin@gmx.de, angelomelonas@gmail.com,
        git@vger.kernel.org
Subject: Re: Possible minor bug in Git
Message-ID: <20190208174315.nnljdpbh4nyoxgd7@tb-raspi4>
References: <nycvar.QRO.7.76.6.1902072040360.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <nycvar.QRO.7.76.6.1902072040360.41@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:p5j5TiP+erYaE6rAzc0XmWkRSGvWhnHdWSD/0DGuSHwol2/5KxI
 c7PnwpKacDJIYpEuHd8u7A44asBUL1S3ypBLEfa1Cub7851xXna3hWTaOpzjm10Ip9q6F7N
 n22Rk0KUJAIjVDHtDFTMPa6T7Upf5S4AjXcX7MLRF6Jx/D7yyCY2OwmIrhC8LS8WirfPNtx
 2hZ/G4QdoA5uw9uY1bWDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jvBRHLaT5hs=:+CSRomjVjrLnFGw1bMjAf/
 YfZs2EkZMgf3wjV4kjmpWVjadXHBpAebkIypNlzrsQahghAPLmCZRNj/jaU0MxaHlvmxYVHfI
 N5ZpCHV4LE6nUebZh4b9mf+3bviKagT3m4ZU0N8RjUtUQTllxqznLLziNHn8R+qmFkjD7ataF
 LZK4V7NipF9WJDgMIhmcaiP/6bAs7d12ls/YFdR5j7bS8IVWC9DM/oxVYqJ5W3v99ALrynrdr
 vMY5/g3KBstXbgjOiNtlQdAxqX08nrngUuapNv7ZHc+9y7rizOGpVkTcUzmJ1fl6kp50ZMzOj
 K2IfeYZBM9DHTToFz+0reJP/7mcnpIW2TvuKNHfkarR2xYhgeIfNWu/+7d25rcX4bAJ04R0xR
 D/VQLlIeyauo+6RDrB8YFEHtqYFRO4cbwsVTUVNvAwaEksjTVs20/Q6tKHpqZmaZAUwfOXSAQ
 rv+sZXCVT+RYZCIuAq65BvUvwChSJ8drfePEa1CbtZpX3yZQwLvQ7otyFsuu/2eggweXlp3nQ
 jC2ocDrEVRrvx5K8FfStO/Z4oWAbfBkIF3hBzMt4x+tZZy/yieLm+3/BFarQ88IDTl8i/V1RC
 cO3RSKElArDUDLtggGTrNobHxHfl8S5/KyY7rFnvDP4Dxv8a2MJrb4GQjzqGe7h/SYtDA/Wfu
 B4/DIQwmptvy6MyDCnYUtNr5apPp2uKqVEa0Toq57iUDirzJ8BuvyIinisbHWfnvpQbgIByHn
 BC+TWpoCxf70SWjuUrq471+fAQJMtFEq/kJ7JRf5PV6grJxZuNbz0dnFGKHXzcmNVBapVuYTP
 sKiBIEaNeQZYbxcNgY85aCONyLGGcBMl+zNkD9CuPj9cpJaE4lksIuqyvt609PABQJH4QF5Vx
 SUiZG9TLN0uI9l86EVJfWfKls+Cj2Vtzcq+2DMDQZB2KG/rNvQYLHR/NKYz+Fq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 04:18:23PM +0100, Giuseppe Crin=F2 wrote:
> OK, I successfully built git on Windows (thanks Johannes!) and I'm now a=
ble to run it.
>
> As of 9f16cdd I can successfully reproduce the bug.
>
> Interestingly enough, I can reproduce the bug even for /usr/bin/git runn=
ing inside Windows Subsystem for Linux. Part of the reason might be that b=
oth relies on the same lstat() call... (Note: `stat` inside the WSL is cas=
e _insensitive_).
>
> Now: what is the expected result for git running inside Windows? Should =
it die saying "fatal: pathspec ... did not match any files"?
>
> If that's the case, is the following a valid test case?
>
> 	diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> 	index 8ee4fc70ad..fadd7c74f6 100755
> 	--- a/t/t3700-add.sh
> 	+++ b/t/t3700-add.sh
> 	@@ -61,6 +61,11 @@ test_expect_success 'git add: filemode=3D0 should no=
t get confused by symlink' '
> 		test_mode_in_index 120000 xfoo2
> 	 '
>
> 	+test_expect_success 'git add: pathspec is case-sensitive' '
> 	+       echo new > file &&
> 	+       test_must_fail git add File
> 	+'
> 	+

In general, yes.
There are 2 comments:
This the "echo" line should have no ' ' after the '>':

	echo new >file &&

The other question is,
if we should move that test case into t0050-filesystem.sh,
but that is a matter of taste.

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 192c94eccd..b8d6bad97a 100755
=2D-- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -106,6 +106,11 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with di=
fferent case)' '
        test "z$(git cat-file blob :$camel)" =3D z1
	 '

+test_expect_success CASE_INSENSITIVE_FS 'add (with wrong case)' '
+       git reset --hard initial &&
+       test_must_fail git add CAMELCASE
+'
+

