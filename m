Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A8820248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfCUON1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:13:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:45607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUON1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553177590;
        bh=jXmQXAKOgTzshO+V1KC9jP0qnLmpp2RZowaB4gCT+N8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kdEhVe3Q4a/wLj4B5s6TLoXgAgAR5zALnOU66+Bydwi14Gd3kKCLFkjnKSyMdn8eV
         3vAA8Df1otFcOrlakL2wRc1UQGjc6OGQIOV+H70DZyad+xTSHoBjJ/3AVxxe+CQvcH
         45OPjdbsnr4n/lzsemJ+9P9pQN9AiAxLUfemSUis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeNGL-1gf4fL06Zh-00qD4S; Thu, 21
 Mar 2019 15:13:10 +0100
Date:   Thu, 21 Mar 2019 15:12:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Duy Nguyen <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
In-Reply-To: <xmqq5zsg3cl6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903211511031.41@tvgsbejvaqbjf.bet>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com> <CACsJy8DU02_kOqAHhU5EgMHKmkNSGdvt+7XzSHoZDB+b9sDRqg@mail.gmail.com> <xmqq5zsg3cl6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MwN1mXu7jEZbH0pWc+RzGeFl5AzSsP7c/TyOeMSBQAh098SHPLn
 tvWVcaUJvFUeBRXlyAnvhhIdW2Vh9nrW6G2JkS5OWjc8GyKquZiq0zA1yJy2BT+2gHzFVQU
 RE6vYOKIgUFC0L8m2K+Eg+nG2B9obwai3KPYi4xp8K4OmsJyc6rqlfEJIg/J93rKziKpL00
 6TzAcliTQPNi7LKAaXCSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lq6jq2Q3JVQ=:rKL1FLTvruQH5RjPYpUdV4
 H8zZfowBvY+XCmWKxHdRQ0kOAgF4U8/2MEtsivEu8EMtI0BtuaierF6pxLg4dpSPgZ8kLB7Js
 u0fpNsSjeCIys7eFgczwvV0n6wJ8ATTKEiy4vIlNgSNIYTBx7vkusYHPCGwG7DQO4PbfAEQ9R
 QBPRKDRltQ4tKY31KThQxnWjib+6LnV+pj6taYwjKAcW5JDx59ANp1+svcgB9pspxXAmg/gqJ
 9CHChiIkWCQiuvBAFS+YyTxyCt72O2BFSRv9T9El15PuCv5J2nAYgfR7sGcT94NzuMlfyOKIr
 dqrvKZmaXBs0LkZKp4nupnuvpfYwUjOhBnxFhxwSEupKK/ufgVjdFrly3nzGxOUi4FDkFq70v
 +QgDsLtOOHVqFFhP7Gc8HqYIOCB20mXYJfi7wW/hxLhveQfkt94QtgI/8QpfsemJ9xZP5X004
 pQFA3+UJAT1zVkkMubwX+Y0CVZDRTkgNpaZ0gNl00+57UAOjcAgcoAhXB7E1BajysFa5dl3ut
 Cg/xPpJpRJ8vYRJfNK0T14cyShj4P4jNiiIOGEI/L+m1NS0PJPv6jzErNnLILLRzia7yyIeEf
 bXSWR5Rbu3+qbdBpA/YQBKQ7ETvanCkLCbj/Mu/t0bTt+2TQtHl952327stF2dVIDLlOF6zPE
 En06Ii9UnZC63Klt6g8KimHsOd6i5JyNWmba9l6GFHNQqG7q4IGEnZVA7sKaJP22Mrkp7sfvG
 2cIxR2rdWEVjKmVxceYeQAJ1JLiveABJi31oz2zUkBQB+0C7HEeEpIFYm4WJCrRELYQ+voffy
 +ILnMSx4f26aX7MGvMPkwcv2Q8JLM72Tz300MemE49zvoaop4VDgvPY1OBuyWDNuTsR50434L
 /LjHiZw4MKWnBMlzsA2RZ5CNnuizuKxLnY7jnKteBqNcx1nhrI0g7GKN+qencFQaAVptm/Z41
 f0874d7V63Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 18 Mar 2019, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> -       This is synonymous to the previous form.  If <commit> on
> >> +       This is synonymous to the previous form.  However,
> >> +       users should prefer the previous form over this form
> >> +       as this form may be more confusing due to the same
> >> +       notation having a logically conflicting meaning in
> >> +       linkgit:git-rev-list[1]-ish commands.  If <commit> on
> >>         one side is omitted, it will have the same effect as
> >>         using HEAD instead.
> >
> > This is fine as-is. But another option to reduce even more exposure of
> > these forms (both <commit>..[<commit>] and <commit>...[<commit>]) is
> > to delete these forms in "DESCRIPTION" section and add maybe "EXOTIC
> > SYNTAX" (or something) section after "OPTIONS" for just them.
>
> There is no other way to express A...B (well, short of spelling it
> out as "$(git merge-base A B) B"), so while it makes quite a lot of
> sense to discourage A..B (simply because .. is unnecessary and can
> be replace with a string with one fewer letter in it, namely " "),
> I am not sure if it is wise to throw the three-dot form into the
> same basket.

I just happened to come upon a use case where the `A..B` way is not
actually useless: just after fetching a branch, I got the usual update
lines, and it is pretty convenient to be able to use them not only for
`git log`, but also for `git diff` invocations, to see what actually
changed (from two angles).

So maybe you could register this as a vote to not totally strike the A..B
notation from the manual.

Ciao,
Dscho
