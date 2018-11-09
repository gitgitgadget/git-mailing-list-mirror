Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 597081F453
	for <e@80x24.org>; Fri,  9 Nov 2018 12:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeKIVtS (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 16:49:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:55867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeKIVtS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 16:49:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhkiL-1fhIrl2MxV-00mtbd; Fri, 09
 Nov 2018 13:08:52 +0100
Date:   Fri, 9 Nov 2018 13:08:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: install packages in
 'ci/install-dependencies.sh'
In-Reply-To: <xmqqr2fv5528.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811091305550.39@tvgsbejvaqbjf.bet>
References: <20181026013949.GN30222@szeder.dev>        <20181101114714.14710-1-szeder.dev@gmail.com>        <xmqqa7msrzaq.fsf@gitster-ct.c.googlers.com>        <20181108215133.GC30222@szeder.dev> <xmqqr2fv5528.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1984051357-1541765332=:39"
X-Provags-ID: V03:K1:ZW3gDzQSx9gSYhp/ItMr5z4KO0vtJBBgslkMBBcX1te4f2B8X8d
 QmuCfReSX4rYulXUBbe8mvjgvpqly8MkPHq3HhvdiaAvprakNebSrxwsp9Int7ljsSLV0dt
 CqAs5lK3piPvKlv08IDh6UR3sgkX8ONY9fw5Nvp7dKqJ7dm+/41wJO21Fg6WZwpE6Ksz7Yv
 z5PBlWP+WFKTd31hdIvBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yd69h9uuDeI=:xZzMlyBDFhLsxidg7ljfBY
 Q8gaBX7T4bmvrtDjXuNlvxMnOQHrnyC1vygDqg2IHZokmAOFFEXKWuwifJfhv2MrdBvwt4GFd
 Qtt6YJw97XesPTJrVLOsuCS0CSipxj7uhuXUEo+wA48OUPJFD8spYWwMY5on5U9OxOqAl8V89
 3jSzaIgD5yLdq0wTMYfWVgoyT+/7BVOVNea2lRofD1DOhZ37IyCB+KvLys8pT7diDSwUnMp2F
 xsNE/7yFfWPq3yhGYHODBW1MBiaRphMrbEI4E7kxMy9N2MqF0oTRZTfAO89znVJMNhO9x3FU9
 JgEUAxhe18RW84i4EUyjRVqwZ0u4gyMQvFaeV4YwfrCTaQkY6EwtstGkE3bBPMZm55RzoRG8T
 rTs115ut8ngDWbx6PNSQC5IUDjbXEoLn3Xw2WKXuFD6PY13sFrgpdIIgA8/GdtKzH5aHXTLss
 v8mD6h2QD3EBYC9wyPmT73ZniEMOzC55VzRSJ8Kv1LwUaD9lNDQla3XKVOYRiCFHPJHvpQlSL
 pGPzqJSb5bWeP88usoCDRpfhGZanT252Df5s8feWEy9GR/BeUbMw19Ntnz7TYYJ3kMO5oTj8C
 06obLG0Dh9rB6EagSFPkxSL0MyX12KsFpjTugRzkeIkCCv6AvgDMjgUWaBeXcHj2nZtTHX8ER
 wV6Qp+4fmKQM6C4p1EGKc3NZtFl0KuRF8HiCVgLABZLcvfD7fnKmjWgseCkZaZ3O898pQg/hE
 RUf+77hr8qkMHHbTsWuIw69ck00YlXwfOZwuyMMlM9Z049WtBeNgXBVbPlWIIuM280vt43LWk
 kYGuwzb+KECyYmsqqtwKtbvdtnf7d6KRk77NRzLGrGmpkrfRGNyQv+wMJZoaFeWPNTFSPeH9N
 NUiqfGENWuvwRv6GHJQXfpvp4VMLaY0YUhNf8JUQPI1s38roeo8ofBx0CNUcP3R52Tkx2DwE3
 8ab1bIyAdXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1984051357-1541765332=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 9 Nov 2018, Junio C Hamano wrote:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> > I'm not sure about the last paragraph, because:
> >> >
> >> >   - It talks about presumed benefits for a currently still
> >> >     work-in-progress patch series of an other contributor, and I'm not
> >> >     really sure that that's a good thing.  Perhaps I should have
> >> >     rather put it below the '---'.
> >> >
> >> >   - I'm confused about the name of this Azure thing.  The cover letter
> >> >     mentions "Azure Pipelines", the file is called
> >> >     'azure-pipelines.yml', but the relevant patch I link to talks
> >> >     about "Azure DevOps" in the commit message.
> >> >
> >> > Anyway, keep that last paragraph or drop it as you see fit.
> >> 
> >> I hope we'll hear from Dscho in one or two revolutions of the Earth
> >> ;-)
> >
> > ... revolutions around what? :)
> 
> Originally I meant its own axis, but perhaps the moon.

I see, you had fun talking about a revolution [*1*]...

I am much in favor of this patch, as it indeed will simplify the
integration into Azure Pipelines.

As to the DevOps vs Pipelines thing: DevOps is the umbrella, it consists
of much more than just the automated builds (Pipelines), it also has
Boards, Packages, etc, but I don't think we will ever use that in the Git
project, as our workflow is based out of a mailing list.

Ciao,
Dscho


Footnote *1*: https://www.youtube.com/watch?v=Xv8FBjo1Y8I
--8323328-1984051357-1541765332=:39--
