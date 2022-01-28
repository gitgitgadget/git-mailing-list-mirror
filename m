Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C13C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348641AbiA1MmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:42:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:48823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348603AbiA1MmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643373733;
        bh=aTbsbht8Y4ICE5pjalGz+7noO67oAL63Z+M0TwPasLo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=O+ESoDBlchLXW9+nkIwXaVyIEjPT4N30y3p4LL5I4ThRDCtTxkZsgrZvnplBd0E9s
         +vYFvJz1/UOJhmQCn9UNCbfDN8cL9bMxm1v89vaajDZZida1myPoGRYjs7ETYzdb2c
         S8izwaDmuDv9PXjRhpxiTJwM3goEL4VOmzTDRBoc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1moJTi2qRX-00TRjK; Fri, 28
 Jan 2022 13:42:13 +0100
Date:   Fri, 28 Jan 2022 13:42:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Miriam R." <mirucam@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/11] Finish converting git bisect into a built-in
In-Reply-To: <CAN7CjDC+O883DB1iaJAXF5ZCis7FP2Z9z0y2qS2-JVAKfQA8aA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281336410.347@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <CAN7CjDC+O883DB1iaJAXF5ZCis7FP2Z9z0y2qS2-JVAKfQA8aA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+eFXSBH+ysN24pZjPYxj70Bb74v/1W9BNtKEyDbJmSWDlOIfrgv
 jaOqyI8cs0LZu0ABytn0kUMOWgCFtLnyN5B1a365AnIZGIkgbGIba36eHl9j1YDstUbBjZj
 ahUduJt9lTrc9hnx3285rRyV2mZiot0E9Oc2okJ5VE7/CzJ6p6YgsEVizO3xmkg9fz6fAr3
 croAwyNlGp31OibnvCgZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jmtAnPoTU5Q=:6tzgA11LDcjZFmO+jrTLJ8
 52IRdOSZqySSZvCQqXH971YrLsqV2vGDg94B4ftE6zPjlWuKGk+ocE2O3LxWVOA3FWZlYgSdL
 w82oCm3IRZ9FC85d2MsiI5YMx616cUXpLSq3ZxtPsGvqLqowUPoUSD1hZYEwc7Af4+SJ5P3xb
 /HjcoAGKZalfpvpQ/Zv7m3hmJmR0YBl3MBONjGX0NhbWqEcaDVTLx61Y/ENAkSwwpyxcjRLA3
 crCL0UKtXNMKpW3CQhgahM+wJWc9hTKAscFKVJ1Z6CVaHD0+V/8MDUnK9lVTDh+Yv314PX20B
 MIChqeL4eFIvldWsVwk67pI/HVJf1sv/YTqsNrPmYh6rwv2S1BnZPCo/Gi33ELG7gDD49hAmt
 oYxICJn3MuMdM/+Vs+KfvM9qcEaJ1hFesDwWuyPG6dn3WCj5tx2/K2+VqeVyvaPgMQsdpJwaJ
 o7L/wNcWKmdrZcXSmHqYUPhAvSp3f5Lsg7W2BGtyI1JTsTyD1dcLIwRoAHbarBigMCksLREzk
 JWtYOV1PuVOlVXqBexNkZTNVjW0Sw0z1ZZNK61zIu96p5BdE209c5rlZYS7h4iGowLwsBWN6o
 Xr2k0vUIb9rJiix+9oSoOmQ3N3ubWJ6hyD7ONnyfoQ+lZQQf6FOxD4E0+DkBbBuMxPyEw4rcg
 XZgZR2dNcEvf1HxFARsbEv22SOsgU20//K6jOCj8Vz54Yvm/BCXklo/ehuz12jmwNQPrI5g61
 J41EiqtBFKe3P4k/wA7rP7HqikZWkRgrOYuztfeqYfd0uD4Hqfmi0/HmpF7/Xj2kWoF2wZUE7
 STCJtv7cgnDZZsDszYn4GtG+z6DrCsPKuYRUeYkqvCuMp4uZKuN+prksvTZDDZAV1d8y70sIz
 Jj+48xVoTMEQiLKyAZIwffSSvcIctPNodpAeDb2mrjYN5emUM1vIanZabEQNlnDIf7xm83p2j
 6cDRUeZgHu1Tu1+QOWDixsQba1kK78lgsSsu0BLZZgujeNBsZshPm29rp1sl1O7I0al/g5izy
 ZJT7e/9Fla0Ea1s+ydGt4g9QAEVRFYxgjJqnXje4N7/BFG3JNe0E4O+T5ruvjb2ZnqRoaaMZE
 qJCzVp5fqFfYyE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Fri, 28 Jan 2022, Miriam R. wrote:

> I had done the last commits to finish the porting of git bisect command
> since my Outreachy internship two years ago (
> https://gitlab.com/mirucam/git/-/commits/git-bisect-work-part5-v1), and I
> was planning to send them in the last patch series during this February.

Oh sorry! I specifically went to look at your fork before starting to work
on the patch series, but had not seen that branch. Now I updated my
remote-tracking branches and see it as a new branch, so I am not sure
whether I missed it or whether it simply wasn't there.

All in all, we did very similar things. I have a slight preference for the
more concise version that does not use any command modes (and therefore
also does not duplicate the commands in the output of `git bisect -h`).

Maybe you could find time in February to review my patch series? Not a big
deal if you're too busy.

Ciao,
Dscho
