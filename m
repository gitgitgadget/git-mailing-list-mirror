Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A931C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 06:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB35E64E3E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 06:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBDGr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 01:47:56 -0500
Received: from pv50p00im-ztdg10011901.me.com ([17.58.6.50]:51036 "EHLO
        pv50p00im-ztdg10011901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233070AbhBDGr4 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Feb 2021 01:47:56 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Feb 2021 01:47:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1612420745;
        bh=CTvAa23D7k2Qjp3r8T5ZbelEst7UJLJSrVJzd9WE2j4=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=nmVSEQrlDMw87P3JlJLRiwpqMP8cBg7rk2BT1yWHWVHgs036LOx3pRtC7KDBYk48d
         Vr4HGAEIwe4lu540WDccgmh4Dbk6RDcWVDCar48oseBr4h2i3/828IHBtVZ3AGly3L
         4gNiE2PTHfAgaPuKu42sUDWBwQuve4qz+8WH8CzeNIAQw9g5Q8K3FUS9pOj9IvzhlY
         t3WG9OZvKc0nfg9WSvPbarH/D0wUketp02IVYmI9GYJC6Yf33mEVK4r71XEI0WqIjP
         5aiRCZuqg4phqO5aefDZOo8fX4oNBkMils6tED1m42Tls17SnwRUS5a1rTxCDssmso
         KrQjAFgQvuxzg==
Received: from [192.168.224.245] (unknown [218.1.30.66])
        by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 3897F80032B
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 06:39:05 +0000 (UTC)
From:   LiuShiyang <wingsdream1943@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: git command was killed
Message-Id: <7CE44CBE-DF7B-42DD-AC0F-8125CB6A8403@icloud.com>
Date:   Thu, 4 Feb 2021 14:38:55 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_03:2021-02-03,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102040039
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

I=E2=80=99d like to get your support to solve below issue. When I =
upgraded my MacBook Pro (appple silicon ) , all git commands can not be =
run, and it shows ******killed. I have tried to reset Xcode-select, =
switch the path, or install again..no luck to resolve it.

Please advise how I can solve this issue.=20


shiyangliu@ShiyangdeMacBook-Pro =EE=82=B0 ~ =EE=82=B0 git --version
[1]    40011 killed     git =E2=80=94version

Brew config results:=20

 shiyangliu@ShiyangdeMacBook-Pro =EE=82=B0 ~ =EE=82=B0 brew config
HOMEBREW_VERSION: >=3D2.5.0 (shallow or no git repository)
ORIGIN: (none)
HEAD: (none)
Last commit: never
Core tap ORIGIN: (none)
Core tap HEAD: (none)
Core tap last commit: never
Core tap branch: (none)
HOMEBREW_PREFIX: /opt/homebrew
HOMEBREW_CASK_OPTS: []
HOMEBREW_MAKE_JOBS: 8
Homebrew Ruby: 2.6.3 =3D> =
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/bin/ruby
CPU: octa-core 64-bit arm_firestorm_icestorm
clang: error: unable to find Xcode installation from active developer =
path "/Library/Developer/CommandlineTools", use xcode-select to change
Clang: N/A
Git: N/A
Curl: 7.64.1 =3D> /usr/bin/curl
Java: 15.0.2
macOS: 11.2-arm64
CLT: 12.5.0.0.1.1611946261
Xcode: dunno =3D> /Library/Developer/CommandlineTools
Rosetta 2: false


Shiyang=
