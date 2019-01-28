Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6188B211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfA1XBb (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 18:01:31 -0500
Received: from mout.gmx.net ([212.227.17.22]:37413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1XBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 18:01:31 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBIAz-1gviZ52am5-00AGg9; Tue, 29
 Jan 2019 00:01:22 +0100
Date:   Tue, 29 Jan 2019 00:01:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
In-Reply-To: <xmqqlg35elgv.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901282352470.41@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com> <xmqqzhrr54h0.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901261916340.45@tvgsbejvaqbjf.bet>
 <xmqqlg35elgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rMJW5Uepq6+cSIW0NPMvnbyoaivdSgGm4rCK56lrnQOGSJYMZnT
 tk8+f2LzHwjIwkZVs0IRqpGjKsX493mZok6qeaTIQrClMKcIsmyctwoDEXGNeYjncsAYoG3
 bR7kkWCpQdX7JY00CXMQ8r5gUFHN5ph951ekl11q53EkH0AiuK1EwZ8xkGEyQyYhewFb8em
 tsRutUKSQGaed/0OjhTIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7z67Hnn8r18=:1L10srV9msYcEBcXI7F8lS
 HHPdYQCKhp+CO7vZOSCo25tQG/vasOvaEDcjq/qEefSZV7CO7XruFo0IwEcUFX0gODikCA786
 VBoJB7GJhwa9ZTeQS9DaA7203eR857ytk4n3Wtr3pzb3EsfrcWXzbah0PbPEb22NpeufnVqK5
 fKCM6WeCeyKAqmvWVzBWUW3EbKo6nuim4dXMGUP+t2hm9mYmhFGvBKwLp/N2ANHdKATLnaMXl
 Sq6D65DduS/odfbVyQOZWJuOej6JLRS9EUpONJJIKSFrChHcH1I2lnE/lEwEr3Vi7f0v8LeMq
 L8L5tBYdCbOYZzGA3et16CQgFm8D2tsOv81jo4KuEnuxFub9djuZHoyUYc/ljrRg2vpHUmafL
 SuMkUK+8EJpR8baUP/WWor5zzdhiZUlk7vJuOnCKnMH3EJ6WMi/yOw82946OdXXIPGgO6e3R9
 5YFWlDX5z5uZ6I+6c7ceLiWcN9c59K70quBPfBeR6fwVIZijmLp9DEPRPkG27zWZjIABJ4yfU
 hMetFC+sCi8cLmG7rNpR5xSo6Oa7/utNcJnPCuVG1dsOi5r6Clw4j58kAjofJMjA/y8TO0lNU
 EKJaGcatON3F21j5VmRUcYRPIEvLg0uQzTM/cNu9d0Xt4J1kw2NanDy3065Bple67N7eX/1Vl
 1DSgD3dY1DfbKmmz80qffVgTKLeezhBP+6pFjROZDSX3r3ypY9cJp+ysojGTHXdBDyUEcYKFg
 JuV3GjYqUUTKUCn3w9pzjZwwe9W69Ohp9Nlob7p2S0YDqUfB0SZXeF6GvMPXAYxyRG1dNs093
 z8urZiAtYY1D4/eFk5Y3i6G2HpoxpNPgw/S+gjtexENI1ytau4VPo+n8zg4Ncm5sa2Wv+IXTd
 kAp1sjBx+6WmOnQMlVOPE4Iu28rV9IHFUSQBjgqh3oZKNIFxqZjogB/ZgyyIKT0CLrkOj7guP
 1P89Di1vMUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 27 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > No, not really. Actually, not at all.
> >
> >> It would be, under this new arrangement of the code, most natural for
> >> Those who want to use gnu-time to arrange it to be somehow added to
> >> $BREW_INSTALL_PACKAGES, no?
> >
> > The purpose of BREW_INSTALL_PACKAGES is to list the packages necessary to
> > build Git and run its test suite, and the only reason why this is no
> > longer a hard-coded list of packages is that it depends on the CI platform
> > (or more concretely, on the available macOS agents of said CI platform)
> > which packages need to be installed to do so.
> >
> > The gnu-time package is not such a package, and it is unlikely to be
> > dependent on the particular CI you want to use.
> 
> Those who want to do perf tests in the current setup would need to
> install gnu-time because the current setup is only Travis, whose
> macOS agent does not have it preinstalled.  Other CI platforms'
> macOS agents may already have it, they may not want to get an error
> by trying to install it there.  I am not sure how that is different
> from the situation for gettext etc.?

The big difference is that gettext is needed to build Git and run its test
suite. While gnu-time is only needed if you want to run the perf tests,
which is not a part of the CI configuration we have, neither Travis nor
Azure Pipelines.

So as long as we do not run the perf tests as part of the CI runs, that
optional dependency should *not* be included in *CI_TYPE* specific
sections of the code.

Since the perf test reference in this comment that you keep talking about
is so clearly intended for some human being who wants to run the scripts
in ci/ interactively (which pretty much contradicts the "ci" in the name a
bit), I would even argue that it already is too hidden in the depths of
the scripts to be useful. But sticking it even deeper into the
CI_TYPE-specific sections? That would make it *even harder* to find!

So no, I think this suggestion to move that comment into exactly those
sections (and of course, repeat it, identically, because with this here
patch series we support *two* CI types) is something that we really want
to let slide.

Ciao,
Dscho
