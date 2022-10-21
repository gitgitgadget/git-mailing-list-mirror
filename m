Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB6FC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 10:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJUK3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUK3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 06:29:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1884B498
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666348181;
        bh=j45MSfhC1vW/vhw/FXgHzBxawAvsRCaHGAgw0CgzWxs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kKYRbLMt4Es5JZkIpn8GafgfvrKonigeje2u9Avu9ohkiBrQE/gHJWqHdhJUIW6QB
         YFRIX8Pkm7sB9PZ/oVhq8Yjr/uvsHSXc8aULrmWwPoDGUHJPCEGjLgb6dqXHHbPgDI
         ALY7+8kN9/OonQWMJdu8/m5MK3Wdxj0+eshnKMg0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.192.185] ([213.196.212.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1ocvLh28Dg-00QU9A; Fri, 21
 Oct 2022 12:29:41 +0200
Date:   Fri, 21 Oct 2022 12:29:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 0/9] cmake: fix *nix & general issues, no test-lib.sh
 editing, ctest in CI
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
Message-ID: <s42p6rn0-s5oo-2874-636p-2541n475p045@tzk.qr>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-546716324-1666348181=:176"
X-Provags-ID: V03:K1:Di5stzdqSqoIKB5QnwECTxV0fFnldNG6zZwOVBxQPFY4WucrrTV
 7Wg0cDbpUo078mF5RJcRl+eS3j3hk5Cr+D1euJnDVn4H8ZmSYWqOAgHWdbE/wScKX3tzvda
 AClhfmHAOOfc1zO58KP5opP/zVgOD4Hu3g+dRO8WbtUa8KpTbyqiXjT8A/rDN3xy02gCMOA
 BGH1FhJR5qPwoWcPjcU6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RxZEGOVIXfw=:VXgQ48TbLPkxSFvtEV7DJQ
 l3MBKdKy9uwJ0iAwi6FxJey//4RjTo8J4q5rWzuEZe0gFfdMbF7hKo6DcKcRkxMeURZ+i+B1a
 RRfmHx36wXcMCVHiEo2EsF8mF0ECIeXursPNRCEq3wVCiFcY3miLw1FfbFE1/+073S+GNpnRh
 bw/qDxAlK5NLYQPRH/gA3z4Xti4TJYdJcK1UnTXFANXKLdsR25Tn9lYJL57HqkFUszGuMHk+A
 vSSGwnbkd3bMB9Iog/eDcLcEKsuH88gHL3o0wCxc34Pu65bxWlwhA8hkrserNHQ+L6benwiHK
 ci6RteDxjsp/GnnvTQz29f76CIGC0uTU+u2Dhwq6aKLUOkJQxaxaV3EWMPme5JIUn1hJ4w/qy
 g9vJKm514gj84tJqGouM8bw6xb2O9oIWPFg6asypVo3FIh0z8W4SXKz7JXFGb8Dr0CdtRRd0M
 6tW98QLB+A0izM5x4InLfN8FoUtwtNY2U5ij5STQO+g/h7mmfQNwA55/c8VdBJvt+t+UXNvQ+
 8+qzEzM9qSCgGT8VTC+Al6qOsCQcRIaMvwLAupOdFA8ShxLIDiZ2+5TvILKNjpx0iUGmqW/tV
 eDdY/74JbrE4f9k4QTas+NVKBszYVDGHwZ3eiGhfk7DmyFghNlRWik5pI7iAjCKg7RhpxGBlY
 dnHBYmsOy4ElzfRjyKKtS3m+uHG9oq88B0i4AT3PBhdyNn3Z5aIAaQBth+Q6xjOWjNSBdY18X
 WOHaKBj8Fbpe8+e6JjLnMtmT+uAfMOoEQ+nb8F7EvHuJ63dpk2UDUNqCR5MW3d1DOiIux1gJ1
 SVvQ8gO2l9mxegthvDK3cONq0/70qlY4ZzitBcIqz/57nDarYvI1C/YvbZCf46+wnzet+JMQ1
 IIAIhgI3gWiDhFG9t8osiQ00nHIiXa/JTbweNLnKGaVc+I4Ct287NFl9a6Ey3B3YyvS1SZxyB
 OMA31mj/rYYe1cm6FfR5o5kOSBcGExzCActIpQw4E1mgWMiJiDpx2NPK3qrZRcDCNyoi8Don8
 K1wR22yeK/ZTYGgRdV2klcC+qBqLDlDwOIu4ltjGDSHps58ZDCAXpwSy1XLGt+2W5IqJjEtjs
 VsVVECtFpg8/sKwdj65noNdjyTD4lRk+XXBCFOgTO80mr/RGNEmLfAFv2zYusXImEjZPCsDiW
 Oo09YHS51PfGxVKB6jNco++q5Dni0dWX9/KsMo2aW5MYNBuGCyWwpj61veZP827CD862vL9qh
 4FLFD3JDsHxH8SN8BpAVLfy4lColrwOcmyryJ1p8ZXg/TPSWSmcewYDpfJGab8FxfFTlvt5Yb
 BpFXcR4hKxrKW14I6EfZCSF7LLHPW2ixKYAuJdfhAD7IiJxabLVWKqSyfMZkjIJA3FflPWQ9l
 ww/ip+3z4UMpglpY1syoLXERBV0/BBIMCe0JEDcwuF1JCTth8BCc6OF08iLWNh5vOr1z1Wdsx
 jx0h/mbJaeREID6nfVqT/N69aeLwd49N2tp5ovSmJsPi+WO9CYDWl9W37US0GEuR6lzSb5HAR
 2fRiyiANm0NeBIKkNT6JxMmU+d6SFk9/ZnZZTKFoN5s94Fk/q4bl9fSlXRXMoe+XHUw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-546716324-1666348181=:176
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 21 Oct 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Oct 18 2022, Johannes Schindelin wrote:
>
> [For context:
> https://lore.kernel.org/git/on2q3qos-sr0n-0p8p-606p-5pq39n46qq4q@tzk.qr/
> is upthread of here, but spinning this off into another thread]
>
> >> Re my earlier feedback, I came up with this as an alternative, which
> >> nicely allows us to have "cmake" and "make" play together, you can ev=
en
> >> run them concurrently!:
> >>
> >>      https://github.com/avar/git/commit/30f2265fd07aee97ea66f6e84a824=
d85d241e245
> >
> > This approach _still_ modifies the `test-lib.sh`, which is the entire
> > reason for the patch under review.
> >
> > I hope you find an elegant, user-friendly alternative that leaves
> > `test-lib.sh` unmodified even when building via CMake. I would gladly =
take
> > that and drop my `GIT-BUILD-DIR` patch.
>
> You did ask for it :)

Well, I asked for something elegant, which in my mind is always something
succinct. A 9-patch series is not succinct ;-)

Sadly, I am already struggling to whittle down my work queue as it is, and
am quite deer-in-the-headlights about having to find the time to review
anything longer than a short patch in addition to what is already in the
queue :-(

Hopefully next week.

Thank you for working on this,
Johannes

--8323328-546716324-1666348181=:176--
