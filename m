Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD75C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DE42083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BY489yOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgJGVGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:06:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:45661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgJGVF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 17:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602104757;
        bh=+oHx2Gckcre0fu0GzoFZIjRCQ+Ua9BLBBCt1zaeZn7Q=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=BY489yOm0pGvqHkvJqDMt9WmKF8XkOkMWPhgYItD17Jgq+yR59V47xBjiDfsKLVjU
         c4VDeKCByKYsuQWYWtaGwRZ5EIGrw5tfqIi11aljzmoUP8taEqCkBisGshb+/f8vaQ
         VbNKJA4BpSyXui88sj5wiDThWY7YkcthncfoXCcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1kRGjy33Ox-018JLF; Wed, 07
 Oct 2020 23:05:57 +0200
Date:   Wed, 7 Oct 2020 23:05:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.29.0-rc0
In-Reply-To: <20201006092535.6419-1-johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.2010072301350.50@tvgsbejvaqbjf.bet>
References: <20201006092535.6419-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FouFkM3QFl2dFKSSm2nzOP4/y0Ii+/CO3x8olHtCIGG5n2mkXEK
 6dtw3q/BGzgu6lp0wMBicpsMTAk25WRXrZQJvq1zSPU0iA5YNXVKgkEN41VJVg5oF9nbHxQ
 t/HN6YmnL6bbj/9tvO+IIRmKaV9L3ugfhhSc7E56ubSgnzLGyaFryCA1Mus1mioBmBtsvxl
 5xjq48s+MvnEFMs64xRtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IalUqCfXr9E=:wjvjvQ4k+XUXqmoXavLyRn
 Gxhcbov84oGvp0wmckPcPaB6byE2AW9oQLYeTugKwZkM5O/1m1kE/I1g7Q/Ni6eAy3NYy2iy3
 juYthSsrNCmZ8kuevZQHnkFb/lemxUQT0f4upZW8yr5xnnGgFiZDdCg7BaBe3s7y3krRHPYG7
 utI5A0RbzsZjKrhg/7ir3w9WG8zTN8CoWoOaroIQH5oNAY6JsPBL8qg5UjWWSwZEMp2V81JDw
 9nzi3vv+WD+v3TtSvSLE3dlS9QvTQi3CZUigxJ6x21uw9C0kMv30vktTc8mOJKVvrcyRDZt/4
 OiWNM7BtzgWTdJP3s6D4wCzNF0DBzZWl0iJ6ezzHJ+6OgXt1wL+gcJqP1YKgqQiGZDR9WvoGr
 CAfli0JMdQqLbOdy6vO6gfNfLGHBdX2PpGbPKA+8ogDWgHf691gIbyY+sakKE8Cqctn4hLAna
 58WUWdiGZHMlnw4qLvjAjBJwo0RxY9eZgX/RZ0Wn2s9ooR/2228CDoTDfjqnKKRoAuVG4gRqk
 WkPOeSV32UaRc2eVAYq8k5imG2t3QiAMJoXWXihJUopqPWrfx12YVXqfXJsVKJNq574YvJPe8
 bk7oSySPD5AOQZNLIG1SngSDkv5AK3dQh8KLQtFn15XuZ9D5U/vahThFrQ3qaWIJpflpYCpuo
 Q/fnv0xmM4URX2GOgO6T/6A52OcjqwcLiy+M+ytZRFW8Gr5axnqIIb6FX4TPiNcNjJ/yi7fJx
 LcyevgywLIurka+4IdLEt3P8MSGd9SlVUtcqTW6Xz9yhbabzaZjB8E0zMG8ynFpBLeDhiOxlO
 3w3W9mRQif5ELXmI2hR4g0y8DtBpj76bcKfFwfVfkFv1LPTrtLstWG79YDSsjscwoPBelMgdD
 L44WU4bqTNPJ3Zi36d+jA4VgmKpN9plh+Hsnx4f4lw4Gdn6auyfSppOJDM6RpFYbitghy1gQs
 Bg4qdQpSMipfXQ29jOMBhX7kh+SJKGUg+Yhro3cTpyfSqFlevaZ+NAOG6//v1ZzvIBPRDKHZE
 kwVkqrslTU87OQ0oPhfA3zFGuKJ0EDSFwvzDC/ds66hhxjVHnPcEfGdYIfuL0GLFJQWw749Xw
 QeXQ58m+0w9o8trJqsamwVdV/uB2M/I2/BuDu5OpbY3wBgpNAT+NLULdM5ARXv/BPcjer0yt/
 RG+fVvh/XQIzt5tkFhyfGBSr1CTWTriLHRN7+vKF7jEO0V3pb/hFFYLCuJnUMSc8JJOukvnrn
 j3/1JWpTPacC9zZOrMU10GexZiDs4OUdbjN3CiA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 6 Oct 2020, Johannes Schindelin wrote:

> I hereby announce that Git for Windows 2.29.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.29.0-rc0.wind=
ows.1
>
> Changes since Git for Windows v2.28.0 (July 28th 2020)
>
> This version upgrades existing users of Git Credential Manager for
> Windows (which was just deprecated) to Git Credential Manager Core
> ("GCM Core", which is the designated successor of the former). This is
> necessary because GitHub deprecated password-based authentication and
> intends to remove support for it soon, and GCM Core is prepared for
> this change.

Please note that due to several bugs, this auto-upgrading GCM(W) users to
GCM Core did _not_ work (you can verify whether it worked by running `git
config --system credential.helper`; if it shows `manager`, the
auto-upgrade did _not_ work, if it shows `manager-core`, it _did_ work).

The latest snapshot at
https://wingit.blob.core.windows.net/files/index.html should fix this
issue.

I briefly considered publishing a Git for Windows v2.29.0-rc0(2), but -rc1
is likely to get out on Friday (i.e. only two days from now), which should
still give us plenty of time to ask for thorough testing before v2.29.0
final.

Thank you,
Johannes
