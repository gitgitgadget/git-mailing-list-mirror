Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF152047F
	for <e@80x24.org>; Tue, 25 Jul 2017 10:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdGYKWW (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 06:22:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:60764 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdGYKWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 06:22:20 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpgew-1e3DiV0czu-00fSNV; Tue, 25
 Jul 2017 12:22:13 +0200
Date:   Tue, 25 Jul 2017 12:22:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
In-Reply-To: <xmqqeft8fp5j.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707251221160.4271@virtualbox>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com> <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com> <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com> <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com> <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com> <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com> <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com> <alpine.DEB.2.21.1.1707221323420.4271@virtualbox> <xmqqeft8fp5j.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T9jmB1bby0bErfQ9O9j+YpRF4xHWeyJZ6a+XApxNJ92WxbUTkNB
 pwe/zQPN+meL6jiKm0ThGtpCFlCrqWUoBPqshgu1bIr1e+v0pvs/GVK/J69uxescKjJNHcF
 OXa7Ufb1iQqnlN0UAlQ/5EVolQanAf1tu1tGPAylyHyiG8RUXoT0XXwG/OGsDiLe6G11bwt
 7L/pY5atzmKSNxMxJ9Fqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7xa50RGkl4s=:8y8sQ28KlOpbyF9xw9aZ4n
 IJx2Bu/wsg+d76TdihUei/uGs2N9E3acx4+PX+rzDpsLwqCWunAnjp0wMZDqPxpWWWhJo+LZi
 K+2FCbnhLYwGzyFK3xVitYm/Zoirtke9pZN33B28T+yp33a2TpxafrlVH76l/4XPSFC3Czyne
 aPvt7tzTobAKilWdYPG1Q4kiu6Tm+7d8gHnG5DxFS8jn3rP9XWDmKIDIQb5bOGpy3j9j8afFq
 bkTM4GjjvMiTYUabwjU5BRbJfm4ep/zJ/mozy6YFrLTeRcMKkyvjfMArQD4kK3CfNrDeYzfJF
 Kebiye8XXBG8+iCrNd+SEOOvz+Bbaa9tl3o6/hHvbBTJf+SIQs08dA7oWa5g/WlMRA0GVJTCW
 VbVT1oLlfQMTYa/SxbgXIfVOksU1KwOo1TyPn7AE+jewOatJlzIqXUu3zb8bwtqgH8kRKEMJ1
 tyeBpYD2lLf0WASqAWMPd4m5JJ/C8LGFM8WkSDrW/U2QDXt+HOhbhR3KpMpuj1HDz5IeS0tMD
 iYDXT3H5dtcoLa2GlUgm2oSp+DTTxXw/MTWTSuxKzTF/Pi0ywUE48xagufhjl8FexaDdjP8th
 wvtzunahqVtUE4mQG3p31Owuj+Sq9hwis3mQRW5fyPhN/67Xz3KHsZfweLimNlxC8Qd95rV0B
 /7vk1XhQilTR3cAxWqz6mucHdlP743I5G1E5sRotjplkjqfNtnwFUgLLDAuC43G7/CbzHuBHx
 VPzqywc5c3DGPLdzyAAtuXGGWB0I7iIY+/mgxqUdidReN3bp2ao+dgxDEq7IQjSO5PCc7pqT0
 GSI/8wtECivTsJEsX4RjTBxEoMDomBKRYgJQUT6wAH+vJDk4jk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 22 Jul 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> >> A very small hack on gettext.
> >
> > I am 100% opposed to this hack. It is already cumbersome enough to find
> > out what is involved in i18n (it took *me* five minutes to find out that
> > much of the information is in po/README, with a lot of information stored
> > *on an external site*, and I still managed to miss the `make pot` target).
> >
> > If at all, we need to make things easier instead of harder.
> >
> > Requiring potential volunteers to waste their time to compile an
> > unnecessary fork of gettext? Not so great an idea.
> >
> > Plus, each and every Git build would now have to compile their own
> > gettext, too, as the vanilla one would not handle the .po files containing
> > %<PRItime>!!!
> >
> > And that requirement would impact instantaneously people like me, and even
> > worse: some other packagers might be unaware of the new requirement which
> > would not be caught during the build, and neither by the test suite.
> > Double bad idea.
> 
> If I understand correctly, the patch hacks the input processing of
> xgettext (which reads our source code and generates po/git.pot) so
> that when it sees PRItime, pretend that it saw PRIuMAX, causing it
> to output %<PRIuMAX> in its output.

Oh, I missed that. That's even worse, as it precludes what you were
wishing for: to replace timestamp_t by a signed data type eventually.

Ciao,
Dscho
