Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E551F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeKPCZK (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 21:25:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:57837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388088AbeKPCZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 21:25:10 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0bo2-1fThiq2MdK-00upgT; Thu, 15
 Nov 2018 17:16:30 +0100
Date:   Thu, 15 Nov 2018 17:16:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Tanushree Tumane <tanushreetumane@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v4] commit: add a commit.allowEmpty config variable
In-Reply-To: <20181115094101.GA15279@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811151713530.41@tvgsbejvaqbjf.bet>
References: <87d0rm7zeo.fsf@evledraar.gmail.com> <20181113155656.22975-1-tanushreetumane@gmail.com> <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet> <87zhuc1xcx.fsf@evledraar.gmail.com> <xmqqzhucpa37.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811150938070.41@tvgsbejvaqbjf.bet> <20181115094101.GA15279@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qVN8IPNKSyNeN9+RKvkFLf8zbuhh184YqRRtfHSvTLY2RdOsEEC
 9k8oDgRSiY3L41qOTLrdDISmTjwuxE2gEkVmXbUKQNkz/9dI2dBSpO9PqbhO9+w4pG3I9cU
 LrXIdHXPv9lZqI3fjHfCP/n61SFWTHWMOAKJtPbtnBc3RXj4hRi7V6Im3sIG8eyO22dpoLh
 KvGs40N5d0XD+TuPOjxxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qRJUmJKFGBE=:/rmSwOJLhKZixg6J5bhI8b
 oj+mqHpjCWpGRzzsR2UbEKX8Ssfh+6Im+4GcCRrr9XgQpEiJU0zJ93B9H7b7X/0Ko+9ZDMFKI
 +jhKMrRzCueMv+eFVYRKJNT4bh3NL0CM0iEHatnJOO6N79Fs7LAm2X/u/TJAWSnPz+zJ7+zZX
 Uu7CBnvRjfzS5jBlQ7SqVDhI/bfR+3F01uJkCzMEfJ5Pl6h0gA+e0YLR/CB/sN5cUzVBE78Oc
 ozAK8n61l1m6aNL3tSuG9DawmEspu1un/MdUdA7Diu5tDKvY0dsGJENlq1P/Ko9Ycf++0DOWd
 qG3Fge3OVGVIV/2qEd710ed7fWElYUD/OzHmz0kYlkMquQgdUr9MRp+Eqpz8MKW30Zr8Emx0z
 5dxhzl/xL4OTyEi0T5bM1YJOaNwzSxQp1yAKLBxq1Kwxrad9s2bYbxktNMUvIYbT7m9JRfQuu
 3UI9DUY6s5MGg/cp3ZOXDqnCPAKe0kUA5qEQhqLorCdzO/Xw++bozj+j1Og/WTy1gDzwPh8J4
 mfciVvRrzdcy4bVhkPRvXzcfOkl+UZufr96hiH/C6b8vg3nLO9AN/OVPly/ODTAEONojYaYl8
 KN4Z7F3Wyoa8RBdxJqFCED9c1VxuetF7ZQQTcuPbJ67GPDISBamJoREeVHvkuEPy5g/Jt0jWe
 08+Yzn19Uc0MVWp5hL4ApcIx7JBasamEPgiVZKHbAUum4UZyUZyzWhztqgd4Gn/+uGtFDx/8k
 33vGHSK48Eli8nkHdLrj9YsYryuWHhv+bmAgTFNqVlxfAi31ypUmKC9k8gMG9hkg0sYf7ux7n
 CRy4dAp+OjEmrXJScdMXdAvmplHXfNuiCX1HfLrNpn1DbTjXuFEj+Qa2h5k+HSDkzalvBTc+1
 ymC1n1VppqJ7r+erPeAyW6KBTxHolOAXvhrnUAleOGMNLFon+PCD6kYUeuWKTEvLQlpuPo675
 pOy6iLM8vCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 15 Nov 2018, Jeff King wrote:

> On Thu, Nov 15, 2018 at 09:40:38AM +0100, Johannes Schindelin wrote:
> 
> > From @chucklu:
> > 
> > > my user case is like this :
> > >
> > > When I want to cherr-pick commits from A to G (ABCDEFG), image C and E
> > > are merge commits.  Then I will get lots of popup like:
> > >
> > >    The previous cherry-pick is now empty, possibly due to conflict
> > >    resolution.
> > >    If you wish to commit it anyway, use:
> > >
> > >        git commit --allow-empty
> > >
> > >    If you wish to skip this commit, use:
> > >
> > >        git reset
> > >
> > >    Then "git cherry-pick --continue" will resume cherry-picking
> > >    the remaining commits.
> > 
> > My quick interpretation of this is that the user actually needs a way to
> > skip silently commits which are now empty.
> 
> If it's always intended to be used with cherry-pick, shouldn't
> cherry-pick learn a --keep-empty (like rebase has)? That would avoid
> even stopping for this case in the first place.

I'd go for the other way round: --skip-empty.

However, given the very unhappy turn in that Git for Windows ticket
(somebody asks for a feature, then just sits back, and does not even
confirm that the analysis covers their use case, let alone participates in
this discussion), I am personally not really interested in driving this
one any further.

Tanushree proved that they know how to contribute to the Git mailing list,
as a pre-requisite for the Outreachy project, and that is the positive
outcome of this thread as far as I am concerned. I am pretty happy about
that, too.

Ciao,
Dscho
