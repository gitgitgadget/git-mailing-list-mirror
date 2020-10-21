Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD9C55178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E1421534
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JKqb8qYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443494AbgJUO1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:27:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:57063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437761AbgJUO1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 10:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603290456;
        bh=7Mz2Ht/xkSupVScvCUKQOtU94hDfk/rgSqZzAEY5A0g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JKqb8qYON3phfTXLAVdAuGohepQ+BWFy5rZlk5jxkRDeEGp2FrAfzkyl/LLq5TzNm
         y0ZQMbcLilDB4bx4T2TJ19g/HB+ggsAHaxbkdpced05pyGip3hWdLcs7WFCn/F5i3Y
         tqN3VrEC9azuaEbsnt/6dvbXLtVUi7i/gQvlKMKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.235]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1k515b3Pou-00iFFX; Wed, 21
 Oct 2020 16:27:35 +0200
Date:   Wed, 21 Oct 2020 16:27:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Michael Forney <mforney@mforney.org>
cc:     git@vger.kernel.org
Subject: Re: SKIP_DASHED_BUILT_INS does not install git-*-pack
In-Reply-To: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010211626430.56@tvgsbejvaqbjf.bet>
References: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tC61kReAkw9Zc+6SqJ0rfDNqGRID+FnC6VFDt9TiQNndvfPvZ/c
 ENfT7TGNnm+PFRz5p8NR99c7WvN2MZ/phwk4R8JPsHSICAda7DnYV3ql8+CxsPfupXWZPaU
 +pSzCXUMrCVvEx+BbULNAcOA4d3b9Jj0Q4CSy9NTSxPqpMEFS4hp6+ja8F2mCkJmIIigBZ1
 79RfdleoWpnhOBDow77dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WbScaZlDf9I=:+rO2nwQgYAvaMMwCX/9Jfz
 v+QFu/IX7K/NXuTe6FutqWU/APqDy6y4SLCUhdtvOE2dhB1sO4SlXWIx7Y4Y5BinanWPH9b6f
 R7f54jF7lCnvQghgjsC4TzETmxKArZvSyUtEKeYBaxqP1+LFGJ4jftj4FW5OM+82JZaaWnjo2
 TfZ9f2HFPc2rGlGZwkRUBDS2Ibn7RxAuaOf8kmxvqMvhG4uFthxWyy4l3H2p4IJ2Bj+7GkEWx
 9Klq5eRppbTc91GfN8S1mKhCBqZZsCt9yoon6i6F1g0JUdJ1sibKx75Ss3fm4vjSBUD+6ciGe
 CX9+ai47I9QZmknu5mz15Es3IHCiTgCuSgZ93jDLFhWb9InTkYN/+0Opd3kipHI3VIV5Ao/rc
 NuWLoL6AOtAPLeq6Uys6FNyq2yt2vHfZ8vhUcPS3Azz2kGebpsp9ykKWBA9RJtkjKWqOWb0D4
 dnPN4F3iklTuChH6DATqn/gS+AbiQkjGUL/G8BloK0tKz3ekLTHd8w0/b2LD50L5Pgd/IDwAj
 Hn2O3LWK+LXuN1GbePLCwIJKtpLpDNPm4bcwQ0QPT57aj4+VU0ztg1qf4is8/giwoNVuRbVOf
 Sy0BxMTawaJz7DbIoRq/X1/lAJXdypNxuhZokmVssHFhsYSkwwolHDKZTAq+RMQzGDKYZ/XHr
 CCXd7qS37zGD/xQBYOB9CZOfxZM0DO2fW14c6Rdip0fEOSjffCPPhkaLwfoJfvbTTrCij/l0s
 yEnvz8lhXhUzLLMUiUw+0lE15DhZC9QVSeRFyeZIce0ZaMg0OR2n2OufWDItcrOdB+/XLrWxf
 ZjswE8lTDwjSJEsCa/TCFyW/X32Z7h+B4Y5m6+jdWMQYc2d7Sy1J194zdXebkwUY5puOFVn5b
 JCd/KYMQQksVOfgCrVGX24rSVRULttc4LlaM2DXZg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Mon, 19 Oct 2020, Michael Forney wrote:

> I saw that git 2.29.0 introduced a new make variable
> SKIP_DASHED_BUILT_INS. However, after testing it out I noticed that it
> skips installation of bin/git-receive-pack bin/git-upload-archive and
> bin/git-upload-pack as well.
>
> There is a comment that says these commands are special and expected
> to be in the bin/ directory in dashed form, so unless I'm missing
> something, I believe this is unintended.
>
> This seems to be the offending hunk:
> https://github.com/git/git/commit/94de88c986712e79c20813ba54e797c4ca8313=
7b#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52L2=
979-R2993
>
> Reverting that hunk restores git-receive-pack, git-upload-archive, and
> git-upload-pack (and only those).

Indeed. I purposefully investigated without having a look at what you
linked at, and came to the exact same conclusion.

As soon as the build passed, I will send this to the list:
https://github.com/gitgitgadget/git/pull/768

Thanks,
Dscho
