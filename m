Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC79C433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C6B64F3B
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhBEG5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 01:57:00 -0500
Received: from pv50p00im-ztdg10022001.me.com ([17.58.6.58]:59840 "EHLO
        pv50p00im-ztdg10022001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231294AbhBEG47 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Feb 2021 01:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1612508157;
        bh=8Dv43LafsC4b4+zpSPhWvikJRF2I2PnX1KPH2MwOgTo=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=0YSpuFjcvnLoiwsvbfupK3UKZ+8lZciYoAhmk06u9VsNZBoacHDyeLRStfN7BWPqQ
         WUhWOTpol/kQOVGHvOBjSj4KLZkacDt4hryical3JhXCF7FMLY4PVQK5VWvSs3ARNE
         uBFJzRf/DYZgdbJsuDrWJJ/LYPaUkq+LIQL3F068NHd/LxIay7EdkUVhufX07wTrJj
         JJtQFB545jRE/N5i0/Hy4QGz7WJlxL2XfpjKvviKAJx5rWcpMq3zEhuLB1cZbbcL3X
         D0v0AZVdw4NMHxRbpHatLD5PmLftFVtC1M7ZKyb/iWq8zoHDLq+a6Y/jbm2cQmMraL
         b65h2qV4GQ3fg==
Received: from [192.168.1.7] (unknown [183.193.184.54])
        by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 0F9A0A02F3;
        Fri,  5 Feb 2021 06:55:56 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: git command was killed
From:   LiuShiyang <wingsdream1943@icloud.com>
In-Reply-To: <CAPig+cRyCW3CtANyp6YyAOA5hddSRMX-Ld1YdwN--FPjTrpNzQ@mail.gmail.com>
Date:   Fri, 5 Feb 2021 14:55:53 +0800
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A51E27A-4126-416F-920B-F9FA3E5257AB@icloud.com>
References: <7CE44CBE-DF7B-42DD-AC0F-8125CB6A8403@icloud.com>
 <CAPig+cRyCW3CtANyp6YyAOA5hddSRMX-Ld1YdwN--FPjTrpNzQ@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_04:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102050045
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Eric for the response. After I had git dependencies gettext and =
pcre2 reinstalled, git was reborn on my Macbook. Seems this was a common =
issue with 11.2 upgraded.


> 2021=E5=B9=B42=E6=9C=885=E6=97=A5 =E4=B8=8B=E5=8D=882:07=EF=BC=8CEric =
Sunshine <sunshine@sunshineco.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Feb 4, 2021 at 1:48 AM LiuShiyang <wingsdream1943@icloud.com> =
wrote:
>> I=E2=80=99d like to get your support to solve below issue. When I =
upgraded my MacBook Pro (appple silicon ) , all git commands can not be =
run, and it shows ******killed. I have tried to reset Xcode-select, =
switch the path, or install again..no luck to resolve it.
>>=20
>> shiyangliu@ShiyangdeMacBook-Pro =EE=82=B0 ~ =EE=82=B0 brew config
>> CPU: octa-core 64-bit arm_firestorm_icestorm
>> macOS: 11.2-arm64
>> Rosetta 2: false
>=20
> This problem may be specific to Homebrew's installation of Git.
> Apparently, Homebrew wasn't originally able to build for Apple
> "Silicon" and the various supported "formulas" need to be upgraded
> manually for "Silicon". This page [1] shows a (perhaps) outdated
> status of each package.
>=20
> Somewhere in [1] there is mention that you may be able to install a
> package as x86_64 rather than as arm64 and then run it via Rosetta, so
> you might want to try that (assuming Rosetta works for you). Or maybe
> you already installed x86_64 and Rosetta is failing for you(?), in
> which case try the arm64 version. Otherwise, probably best would be to
> ask at the Homebrew project.
>=20
> [1]: https://github.com/Homebrew/brew/issues/7857

