Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC991FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 12:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbcGSMcU (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 08:32:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:65377 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbcGSMcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 08:32:18 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lg1QN-1b19ui3kbb-00pa11; Tue, 19 Jul 2016 14:31:48
 +0200
Date:	Tue, 19 Jul 2016 14:31:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH v3 00/16] Use merge_recursive() directly in the builtin
 am
In-Reply-To: <xmqqshv6h460.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607191427400.3472@virtualbox>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de> <xmqqpoqi35u3.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607141414180.6426@virtualbox> <xmqq1t2wqaa3.fsf@gitster.mtv.corp.google.com>
 <xmqqshv6h460.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dG2PkUyEa88XOZtaB8eoLZbUDMILEOr8NRjv2VNtI0zwIFqckpL
 hyKZqEeSpG5L3Fr29ROGwL7Q5QGFp4YTcS8yw895DdmtxW2dgxZXXs536gecsmHZKBqNPiL
 H5TXwjNrbCzwCoT1scCvSC/wbVc2AcBVMDfAVuYuvVrGy3Uof4F3ipc5SPp4mc0LE7ntO07
 o+hlRU7HyUdlZKu5raiuQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Mj2zpZm6sUY=:83rAkVDh+At+8f9uWncJus
 O5/0wHt3PTkILk3Jk4SzE3wvCAVwHpw/+oLGKfZhMliVZg1JG1CFY0T7yWGPzbh5Rn4FLbc29
 uyvYnT0Xlm3oH7K8QUHsREopVKqXNaEFok9zJGz/WSnh6x/xTxL3SOZ2El+hQAiPpAJC/3PF6
 p3glDa4LnofJt1jeeWrLg/znnIh3mkdFvjbe1GoqC4p8r+BqYEWbP9lveV8ESGr3AEqVBSKrI
 WrxZfGnho7SoCVRv9KlMOOU9YE1N4kDMQfZce8cgt9l/+0Bjrg1eibPJjQ4XM3ODxgAoynJVT
 B79tZWWsLGELU7V7OtYn8CWpLTQ6eQoiI/Fc+O2XHrKxEXdhbysNzGS4OJMCKncLlR0gdL3+b
 IvlSB6GReVj5DhE6I+Vfp3Fig7vBJxh8Mp771SHf1fXQuBX9gwu2wbq+oHJjy32X1hcDHDcjt
 uUlBKtqUsb6zn/HLTtFxEGASm8z7R10rZGr+T1eml0aRT9fEgnwY7dy+Rd7iwv9Kt2PmUNNWh
 x3gZTqPYyX28xiAXv+Uoj6My7uwzPphsuV5PM0Cy81lWPUbURvDumchy3Y2A1j2f9Pr+0uBfV
 Dhni1K0Is46PylopmAQsy6iB/FDbXMk461K2C6VBmDovqTIhjsnXyHy40PUqBnAYG6Nx37HYX
 HbIe/Wsvif9S+ujkWd6AdKIDLY3YUklJJoJgXVe/wMlRtvVFj7byTwkxnL2aR0QhCVqUPTaYP
 khZ/9YfIyB1nTNfloY8PsXFF0rq/0ISv7u5NoOfl1HZ0wtwFElqpWsbLC0A3MX21dQd+1Iyen
 E/Lu3uS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 18 Jul 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> The two topics that are in 'pu' and conflict with this series are
> >> 'jh/clean-smudge-annex' and 'bc/cocci'.
> >>
> >> It also conflicted with 'va/i18n-even-more', but that one was merged to
> >> 'master'.
> >>
> >> Now, I think it would be okay to wait for 'bc/cocci' to go to 'master'
> >> before integrating the 'am-3-merge-recursive-direct' branch, but I would
> >> want to avoid waiting for 'jh/clean-smudge-annex'.
> 
> Nothing seems to be happening on jh/clean-smudge-annex front, so
> unless we hear otherwise from Joey in the coming couple of days,
> let's get js/am-3-merge-recursive-direct untangled from its
> dependencies and get it into a shape to hit 'next'.

Okay, I will rebase and re-submit.

> You can assume that I'll merge bc/cocci and
> js/am-call-theirs-theirs-in-fallback-3way to 'master' during that time,
> so an appropriate base to use would be the result of
> 
>     git checkout master^0
>     git merge bc/cocci
>     git merge js/am-call-theirs-theirs-in-fallback-3way
>     git merge cc/apply-am
> 
> if you want a semi-solid base to rebuild am-3-merge-recursive-direct
> on.

Okay. The way my `mail-patch-series.sh` script works, however, is that it
infers the base commit by testing which tip among pu, next and master is
the most appropriate.

So I guess I will have to hack it up a bit to allow basing my patch series
on something custom.

> I am not 100% sure about the doneness of cc/apply-am yet, though but it
> could be that am-3-merge-recursive-direct does not have to depend on it
> at all.  You'd know better than I do ;-)

I agree on the doneness of cc/apply-am (as you know, I tried to help it
along but my comments had an adverse effect).

And no: nothing in my entire rebase--helper patches relies on cc/apply-am
(I do not even believe that anything conflicts with it, either).

> After that, I'll see if the conflict resolution is manageable when
> remerging jh/clean-smudge-annex to 'pu', and if it is not, I'll worry
> about it at that point.

I can help with that, too.

Ciao,
Dscho
