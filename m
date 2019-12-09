Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F30C2BD09
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787AD2072D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gl4y0vDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLIJTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:19:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:55173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLIJTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 04:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575883146;
        bh=j1T9AGP2UJM+ye71y48B7KdHdOjrnpmlwJxjo2N8rWE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gl4y0vDpwKprJR2VR21xkZ9EDnOzzR4tk44V5qk8W8/AlGUFCJGNYM9cjY2TxD0RO
         6Dy9/iveYN2XanV6vsPr0CkqTx47NQB2cs6lFlrKON1O583+GHEohM+IqLL95qVGbs
         I9F912qbF90InuYT5lDlR2cOvx8TP00meMPj2VLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTmO-1iGgkG1CUA-00WStH; Mon, 09
 Dec 2019 10:19:06 +0100
Date:   Mon, 9 Dec 2019 10:18:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: allow closing console window with Escape
In-Reply-To: <20191208194046.csf35b7rgycst2vc@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1912091014220.31080@tvgsbejvaqbjf.bet>
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com> <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet> <20191208194046.csf35b7rgycst2vc@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ykfESRq0mqRKtYiXuGAP5+PnHtP6pJ9CFTf8n3we7eX6WXdKsMg
 mx6cT+ULVR0HfptDkj0ddxvpKn0LOTSLsI+eXlLsj93deACM6VMXAUnMrP40NU55QNbzEv3
 tNxZ8XODY1E23E6BauBWKXCdQFndG8zEcdUehTgTOPpkJJ3a++vfiemltOHNaeQnHnjETOl
 qsgq1S+IeGxGaYqkyWJZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:re2znLbtdn8=:jvJUTP6ilBzZLZ2d2lpeAg
 gd87yaHfjMCQRbjQ5FSCSHoDd7+kIjB+fpnAfjl6Lz9eZoQwmTR+TIF77FYky0C3UDeiI0yIB
 HlKDQBF8h2a1kY/zCJnO+xXhUKv92mCmVz5gpJ+PdeAOKfVE+afmriADjGrVqy+zGMTntWOn8
 LaDU3hhRWrFn8c7T9rsO/w+7SPL8qTJFphJPe7FeaGfzv562wvZhdGr/RExBbGFjD66G3zaUx
 VzszsoIBDoKopZNp38QhVSHSbp9S1uhcytbgWWRvDzQ4lv1FLnysWF0quMphKdUI+2/gnjxWU
 fU4HHkTrHzQo0fEqZkVTDOHD7w77RWaE1IgoJiMNchPzPrXjm1gUaDsS63UKQviyrRK2pcvWJ
 ovLeO4CO/Hju0lj0CwlZCDwUvtjFG2sQSGngDewjc4exro/MnPl3KtqgriL4jnG6EL7l73Ym9
 jQZJp0Aqc043b4FELCFx5Ov0IYyoAaiFjsIrJjlkYKPo/48C3REaeBcfUvi3rGlQlGYY1KSd7
 ogzUc6t3X9oqwtQltPe65v8yx1BPkwvH7yDJzZQ5HQcKBKfma6HSJCsTlPzeyFbSqUBd/HD4v
 dcb8iDbSScH4+kd0XhkumwGD6eKCUWFpneqfPugNCK6KVx4fodr54VFwU1sBttFYPWqA3nPv0
 4wS85+sE91PcB0oieG3F+gr33Q2hKMBDkFmYOCpcQv76zJonIHz0I7jAurSHvyvlNhKNa2VCx
 on8HvP1SnDPvoD+0KoQaaYvv1ejiYlYYdkPhh+Jn+0ffuDnqcZD+49fXj1G9CWicSo7fkuyuT
 VF97TVxhCrAJ/NfiiYEcmIkKgZG5uWsAr5cHJVAFpabPSdFTbocsDF1eXSFwY9fnydMcfrAwg
 zHBam7BGu0FG3gnv/FmYT4ucmUpumSQ17ErKmxW/lXvxytQX/yR3ZR9mI+YBpGNneNQkpu3AI
 PXMYw8eDUwZTrYZ9km9ykCOdbnSbaeX77oSII/sahaKFjnNgAX5t7XEbM369FGld7JYv0UNXi
 vPQ/kSjoDnM1njI84fJ0mqcdbwYT2jJ2Kxtbs2K8zn1YDj6Nakj386z7w8+3819f+B3o8OcNA
 E3Ea7ArWuPyLM5BS+FS4rB4/2BVExNDcXiGCpN6crIWT2JkIHaCWNXq8K9ZxgM+shFxU7tcar
 xMxLquLGa9bhqgIdwHjvG3fMMY7bkkWUeaG1potjCoDf/iV39S8za4noOwKjWuyRgW3ZRO/HG
 GMEkwBroXiTCDxrf91R1QdBvbtV8VrUX3mHqzRCMKuz8kLb1hDIjSZQrBk3M=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Mon, 9 Dec 2019, Pratyush Yadav wrote:

> On 07/12/19 05:24PM, Johannes Schindelin wrote:
> >
> > On Sat, 7 Dec 2019, Pratyush Yadav wrote:
> >
> > > It is often expected that popup windows like the console window be
> > > close-able with Esc.
> >
> > Seeing as the console windows is not your regular popup window with an
> > "OK" button, I could see how it would be all too easy to close the win=
dow
> > via the Esc button all too easily, annoying users.
>
> I'm not sure why it is "too easy" to hit Escape. If you're hitting Esc
> (which for most people is pretty far from other more frequently used
> keys) you expect _something_ to happen. People don't just spam Esc for
> no reason, do they?

Is it possible to issue a command in that console window? If yes, Esc D is
what people like me would possibly use to delete entire words.

Even if not, if there is no "OK" button, it would annoy me no end if the
Escape key closes the window (it is not a dialog box, after all).

> > For windows like the console one, I would expect Ctrl+W a much more
> > natural keyboard shortcut to close it.
>
> But, that "something" the user expects to happen could also be "stop the
> command". AFAIK, Esc is often expected to stop commands. But closing the
> console window won't actually stop the command. It will keep running in
> the background, and when the command is done, the window will open again
> showing the final output.
>
> So all in all, I do think Ctrl-W would be a better idea. Will re-roll.

Thank you,
Dscho
