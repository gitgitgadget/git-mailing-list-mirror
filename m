Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC871F5A1
	for <e@80x24.org>; Tue, 12 Nov 2019 20:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKLUQw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 15:16:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:47819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfKLUQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 15:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573589805;
        bh=W8lQ40sq8dqFN/Aic6qw3nRzzd5Xj6B7KshidqqSaOQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hVW57+uLV/viksgv1a+mTA5teJg8tbtCV+KArZyFl5DX8rgPPI/7krd043+Zmkypb
         Wq4DmOapVy/l2jmb4xE1COjex3MMSX7xN5In4fWYegOVzQdVlt+BjYeeQx7bmlu14p
         G7AO3dCW8wRXZMliSdoS6scmCauJJrKmpyEjrKEw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1iPDkX0vRE-00Y9Jk; Tue, 12
 Nov 2019 21:16:45 +0100
Date:   Tue, 12 Nov 2019 21:16:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Change behavior of git add --patch on newly added file?
In-Reply-To: <20191112184720.GB38770@google.com>
Message-ID: <nycvar.QRO.7.76.6.1911122114380.46@tvgsbejvaqbjf.bet>
References: <20191108225035.GA60198@google.com> <xmqq5zjtn07v.fsf@gitster-ct.c.googlers.com> <20191112184720.GB38770@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Quxd3t/9SCTnh+Z1SVHcxyNbH+d1vsIltLw2tdaiY/xx61LrQ4T
 3ldbxeTzuVuIYAqdDTY4Z65r6ae9R2vuX4JMs2a5hjlXfHsT688rauYyykSCJQawg12NaQE
 ZpNsO6mluoj7hRBSc7sWZM1LhWRccDINygb6ASn1lw77aK27DohuecSdnEqkKaKofZ0CHB3
 tfdLdg5nThEQzZDh6wYGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VvmG9dk6Ucs=:+ijhsSQPyNhBl0PBQ64XIb
 An5E4/vl9tTP0Ofx9i/wDc1M2me7b/kqImCfn54pB7Q/7kgpUPgRJdNkSArLQ9DKfWGEabvHX
 ZVz4BNLVQvCJj4ANnxnzp2exvSORh33nrcBJ5op2z19fv7M0VHqN/gi1NNafRGYUJLDckGAml
 DGvLiOIIbeq4AbSXCEC59SUHn2UfJZ+VzhXj76jENpdqhYZeFm7OHeYctOZT9TqT7hGIuQQMO
 FjbK+osnXZitGtMdLyADyMGApLJx2X3HjgBKlDU/losxVvI4p/iXNtWLDM9Z77ooolrWBajLK
 068XxXM4O0lUs2sEVP/KCOR9vLTifAH7Td9fUZnowKaGq+rLF8Z6gWHDzZEZeGT6LSrceBXNz
 ytz5eCQ6qCC0g29VMX5XagXqc5V1l1RxSofK1YThsI+Cecx+/aMBZyb598/A+sgqVZZctJhkT
 0ksAV6fLAWhjY0wfaTHzefML06GlIpwam6NRba5X/z54vMIbdxHHvpeJyojG1gbGVCU/7OU+O
 bai2X21m65mfaDqj2gNvETJSQoz6f8txwqB1M5afD6Jf6DcrsSTHI7607JtD+q+RlbBUTtEmr
 +fmjILossBUW+SNks9KznHIqkq4QtyLzst2k5TcCRBpKQK/D/Vcv4vaWFNOWRjU/8gE+f4wjs
 +VmH5I659JwU/6p2HM4C0Q9jies5X+ZVQu5LbdoLCdQ/rWipswddZRaj4sfnafmsT8+zEj/h5
 zE78hGSVSRx8OUKufr9na2E6vgd0vZpOp+6qhHWqYGwLpH0UeaywrYX7oJ15ZVzffXaPdV1PQ
 lUfEmQL7JXhgrh/Y40ZjhxMj+kIEXaoN0a38/eUHEdiU/mT33T30QEmzPn8cozVAxu9eHH6mB
 wOoK5d2PcKYnA/D6ww9ramehCHtxLsgNAdSs9Mv8Gm0MXW0bt+em5sRot+4PBvazYDtVvgeFY
 Owf6DBsWkZjqL9UELvCgfX4ICAYqC7ZJEsBYwpjJ0NYiYJphqEWBjnsTRTSKBR3qEVy9Y8NbJ
 VMF3THz6QN8fr1PPjdRFgML5B6wePSO5wEbKbzPAP+VpVEe+XWsXQURCQvYiWVk6Wz7ObeyGX
 jWYBE05u/2QR+/Xup6kv4hoXVbhBJI3sm5QjZmxW2AEY3Myi/lg/F2rRoqFyMTc9Xy0jFUfuU
 X5+RS5Wux8YI/SngrsfsK2fZiZYd4Revc1H0MZrgMXa/sJy8QzKucAfegTRAe2tT0IQRXM9VP
 hDbJkDnXG1oH+r2vjdKKiq5Z+yFsAvU2uuh+HYS4oh6kYQ0M90nMQBk7qWMs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, 12 Nov 2019, Emily Shaffer wrote:

> On Sat, Nov 09, 2019 at 01:27:16PM +0900, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> >
> > > Should 'git add -p <newly-added-file>' do the same thing as 'git add=
 -N
> > > <newly-added-file && git add -p <newly-added-file>'?
> >
> > Probably.
> >
> > I originally wrote "git add -i" with the intention that the
> > interactive mode is _the_ primary interface to the machinery, so the
> > expected way to work with a new file was "git add -i", tell the
> > command to add that <newly-added-file>, and do the "patch" thing
> > using the interactive subcommand to do so within the "git add -i"
> > session.
> >
> > Later people liked (only) the patch part, and "git add -p" (and
> > various "--patch" options that invoke "add -p" internally from other
> > commands like "checkout", "reset" were added) was born.  I think
> > nobody thought things through when they did so.
> >
> > If I were designing "git add -p" from scratch and explicitly asked
> > not to do the other parts of the "--interactive" feature, I would
> > imagine "add -N && add -p" combination is what I would make it
> > mimic.
> >
> > Patches welcome, but you may want to check with Dscho as there is an
> > effort going on to reimplement the entire "add -i" machinery in C.
>
> Ah, this is a compelling point. I imagine the landscape will be fairly
> different when that effort is finished.
>
>
> From the replies, it sounds like it's a favorable change, but it makes
> sense to wait on it considering the refactor to use C. Thanks, all.

The patch series can already be viewed at PRs #170-175 on
https://github.com/gitgitgadget/git; maybe you want to have a look at
implementing this feature on top of
https://github.com/dscho/git/tree/add-p-in-c-config-settings?

Ciao,
Dscho
