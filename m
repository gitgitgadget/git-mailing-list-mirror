Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5195C1F464
	for <e@80x24.org>; Mon, 23 Sep 2019 12:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502050AbfIWMuk (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 08:50:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:44547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502047AbfIWMuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 08:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569243035;
        bh=H8UAaf+mZxSd2lR4MYuOBjYXw07Zk9k1F6WX/mR8Y+0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j+bEznWtvGlWi2SfMgl89gBnNGvfWrEySqnCU+ejGybiPn8AF+JJqFXpQyx3UO9/g
         kf8yNWZtPhahDk4RFxnrWlQAzvYufGwfhUMKwP9mODKkbOAzqNO+/Q4T9jtdGfACyx
         7NXvdaTLkH2dXQdNLwFNmoHPTrA6JZALj2M8KN3Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1iPEu41vDz-00HNE4; Mon, 23
 Sep 2019 14:50:35 +0200
Date:   Mon, 23 Sep 2019 14:50:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <CAP8UFD38S_nV2NmjeadZ0J5ftJgBwghOZ+BNHZaNQ72nZmLtNA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909231448340.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com> <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <CAP8UFD38S_nV2NmjeadZ0J5ftJgBwghOZ+BNHZaNQ72nZmLtNA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7QYyLsP5xtdP3HVtz6LSfJA+oiHFHP29O0HVySVM6OIyISqQlmN
 by5tk1IGwxdbtQ/oLr78vaqqKifBHl5K5L6y93rPhS1293MpDetyS/lctB7mNVln3SyGb5N
 CmEaduw0DhZd34sSz9xCdy5MiYhfb4JjIQvfERXW8WmHY55/lQDJ8e4vjEdEEc9bAdD5YNi
 l9wud+8j+7ggeZf5DPuqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SAPyHRsF1g8=:v+LBq05Mc74ex/wstGA1iY
 n/PyZvxKbM2ufwJqDI77dLgcDUE3PVTlSo1u4U0FU4v1Jko2W4ScITNmvPNQJpiPw9YLMD303
 FHkahIgDc1PNhLomB5Gccxh9R2kH9z5mDm603d1WiwBXPQvTzvyzQLHnTt3F2e8+xU7BRP/7p
 y1rC7qJODuivnF0WRZUAOnKwllkZLTb6ph7wnUEL1M2MKn4vkvijZNSkm8aBTpgxa7mYfTyAY
 y+dt7RUri/K6aCu9J7oAdxSwMad5uh7y9lw1gG7s4poJrlXkDArFFjmni8WzHQpXDkE0ZDyzF
 4rxIjHHrA++apEA39tmz2xPojvXxm8F5AN3ngMU62AHO+qSS4WkUI270kPQxPJUmjEX8j7TJp
 iUHrKVqLDKiB1b0+Il4cuz1YgUIiPNtPmEkT2VOJykV7h8Yp7itdGN1nQ1F2H8gbM3bOfDc68
 Yx0Ty8K1So6VgivkSEy1+OtTsJpzunS/nQsuYTjnK92v7m/9zq17ZoYGDlmRqhXMQoJ+6iJND
 vyhrfebh/FxCLQGOrlZlgTITcRpgyC1t1n6PjsjpDBmBnPZIAp6CTRTyK11xdm2uV70bbOKsH
 RxwkakxjVLlpLMOrWKU9QNBIZo2x171HopOPK+A6sdbttRGwzCd8wCi52anXld/Oh8rTZDPfa
 nJchFOEqcIb9QKNMSccsnIn9mqtQcU70mfJlfrWVh42vMRxUK5Bjnr8QEjtxw9f1MsxwmW25A
 Xj8WnxxsQHf/JILXsPWZjfy0qY2+Qf9eb/z+WxIaw7utNE3lTYZwC80Wz1fjQ5sxzYxQemCjS
 DfPIisHQ8YufP+vDc1aTLcODaNk6HghwApotz5Yc59Uyz0hRWmH/OekoOgfpANch/IOuv5x3v
 g6J3GcOKz26VDG0FsW4vttZL2AHl+gL9np6epPmpYTxoab6kIWF86IfFg91AJA4wPMvnMedBj
 rrF6fqTPQjPwUKD6248qlQ8EoSfSF9syb5gqNZLXWS/IQAtkA4AP7dg29vox1aBO/hefGbuBq
 OH+jN+WHh0L0FR+c22+tz0Mn4tBZUVw46o6pEJ4uIdeC4qRDM2aKhlreFTCUrZyIEnUUDLgxq
 VgHHjrK7BeBngaXBU3pXQLfwHNN93VTJVqB0vCPRw5wnIs4xgA9uabVM0cR83Dc1HfDxK/eJ9
 PnL/QW5UkYwd7bLo87G1vwTh/g4W+0EerItdYH2mUou7BEpxpiAInSycFY1e5zoTaMVE8HIbq
 HtI8bpCYk1RHSVd7oTS9Ya4S0haMMQ4OFstmpZVm9TjMP4Kwmxt9QSxVANUM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 17 Sep 2019, Christian Couder wrote:

> On Tue, Sep 17, 2019 at 1:28 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 16 Sep 2019, Emily Shaffer wrote:
> >
> > >  - reduce/eliminate use of fetch_if_missing global
>
> I like this one!

It looks as if a (non-Outreachy) contributor also does like this one
already: https://github.com/git/git/pull/650

Ciao,
Dscho
