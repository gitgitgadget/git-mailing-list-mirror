Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5EAC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7778960D07
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhHCXGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:06:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:45515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhHCXGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628031978;
        bh=Fq57/bXtcTNKZwXcGkdc0dSVMLDRcbqy4yUbaIuiQ8A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CfHjfHGO50GD+0707NtioAl+eWqniXQ+AtYhtw3B/5+bZsvtkJUvnrWjQusuXzcY+
         afvMzoTm9G4u01wpsdFARlmMvRN8+iymXz6BkRZP8gQKGbFU63GneaW+r8mrD2Qqz3
         K3QzGOQUl+NhKdk+dOT8vWJsJOjdqPox3UfvLj9o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1mbQ1i2PfU-00QTv5; Wed, 04
 Aug 2021 01:06:18 +0200
Date:   Wed, 4 Aug 2021 01:06:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/10] Documentation updates: merge-strategies
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108040105330.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qzeTNDwJ8tyZpUDGW78ub599FjdWKKefbG+Wmfz7Dt734ReLJyo
 y8J2vf7mOuKUIetFxhMAFbW4KL/vsVgfrSbQ+END/fc52mg2v1HokBBoZ42EYlP3Txw/quR
 JdkjxpVPtdk0Ir0otk8c1vwwSyXZR++BWbz0NeClfWSPnVgYDy/KwTWcsz75IJbLDJjAE7M
 3Iw8DJtm4FXEmkXX4hWdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K6p4KYfLXCs=:1o3z1NbUjW3a+qHyVvNrfl
 mOd6tFNERyP0v1CgPqVhg8mH4s5p7l+32xD2dTJYWQJM4uNeXMDvSiVJto7ptv959OEzQXDSj
 eGCwPXcKI5qXBBDxMcVpKZ01W6AcWhyMc79rsqaL5qjYwDjplkMiaQ/28+fwYfg/p5u5LADkN
 Qpxx5tANC4DZ0/D+RPLAMvF/WgYk/fqPNicB77TeirEo5++qX+14szjzng5r6rwZyDY+G0FV8
 55GdqKHQQx1yf91ME2PlikMgo66dWglqAeC3x4hlaRLrOUtcKhV971/SJR8JPJ1/VGCZUUU2L
 7MaIErkmSbua5GEa/6dRUrUx4LPmSVw2rrwI+WPTPwrHcyyr1suo+bzsYk4aHh+EbwP66T1Kk
 H2bE2432twZlI2yz29Wie5mZseUsXuxjV9627aEcuhf6QsT2t/WM9uLVflTUs0ZWyJDL/zY94
 uPwYHalXHR9AHqTEaoKGbLnOwOMjOBY/0xjoZKZRoKQyJoZ7a0GZnFLL3BTvPFvsG5lriOUfb
 1piwih1MT/JZmTolUgr7+PF9Iz8hp4zbdrMHGpEmM0tvcBr1etbwBs25wpBTkJf32fHTfq4Lc
 5XgZZ22lQwHlnSi5v+W6gtJddNw02+wZU8NCgLgRGEiZ2FJEA/fJ+P7sBk3KIP7snkp1ikiYG
 zARVanSDemlDXRbVNvHSDxSm5HB+qJQf4OmMumEmur0aOmpLr25PBqaCaWnZEA3oWJQ0fZC00
 2MA+CvJmdcR1lxN/sX0qpIvreoJLhbZXgLOVxneGv6XEFgL76H4AV8HGlgck0Xe/832OBWqp0
 mLCd7NcWtVQeR8d1KJBfjTqcZ7IJY8xn55+JjHX1sYoqbY8D6P/KtHPnIS9xvYXdl5KdHbZf5
 gS4gZFVd4fLU4IrG+rIxZnnAjf26iIc3PLvTEZYyv1v+u1DxsjYy2g8xyZ/MRvJ7BEsg1SIRz
 nY86ZA2r1rl1wGc6Glvdpcv5rX/tNC1aVA99GVk0zRIz9AXbROdsQZKw85Qj/CFMVpe6Dz9xf
 QlJ4nCHv2VmRzL5j+FLOG64u5U1p96B7QjGQXgD5/GoldEUM4IKuNnvoYin3EQzTPG2EgCOQ1
 ys49SqEwKnjA2symaGD/xx8xhUdiAOxOWXGGszJSsERlG/3gZFuBGlUrw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:

> I noticed while updating my switch-default-merge-strategy-to-ort submiss=
ion,
> that many of the changes were good documentation updates that we might w=
ant
> for Git v2.33.0. So I pulled those changes out and split them into lots =
of
> little commits so that if any parts need discussion or are objectionable=
, we
> can just drop those from this series and apply the rest for v2.33.0.
>
> The first 9 commits are just small documentation updates, but there is o=
ne
> commit at the end that updates an error message and a code comment.

I looked through them, and they all looked sensible. Hopefully my few
suggestions/questions are helpful.

Thank you for working on this,
Dscho
