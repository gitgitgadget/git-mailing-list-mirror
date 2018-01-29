Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE711F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeA2VrK (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:47:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:51020 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbeA2VrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:47:09 -0500
Received: from minint-kr8j64v.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MLvLE-1ehMew2Dvg-007oJc; Mon, 29 Jan 2018 22:47:02 +0100
Date:   Mon, 29 Jan 2018 22:47:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     phillip.wood@dunelm.org.uk
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
In-Reply-To: <7e6906c9-d642-ee8d-82fd-29ee6c60e308@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1801292245030.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de> <7e6906c9-d642-ee8d-82fd-29ee6c60e308@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hGUil25hFdVPfq4iex2rQDhY3g97675jruD2ikw+Ifo4JooXv3K
 XLdL+77wx4GhtRqjdEBgHS7DOEhJIUBUBuykjfw3FUnGgIbrkR1hvENA73PDUSXvoCYJXo3
 q/HzW8f6Js3LW8Jgk7YkclawjXihA04In4dGGi3rqxhZjByFUbaE41povoMqP4rUvgmjv2N
 YGqGWaJ4gfnV/KQruBJlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1m2TjYHi5lk=:f2dJ/IW34vE9xqAoMSigEs
 pHiWOmJ4hW91h9bjty+sy8coVm8qml7lMwHyo9aoywqh1ZeqNw7xOgCsw9BnURzqDAWxaUVQ0
 CfLnxnXFt00zuE+tHtXM8lvCrycLNoX+7lXm+ol8A15KKMgW9ObQ/b09tNTQBDALfrVO8gZFq
 c13F9c+uWCFBxG8UOA/CBh6DqtvunwXbsAYHwxizDEIGnZ+k1PrJTncvaB8DDOrAHsRnXwM27
 8sFxYrQmZm1XBORUnt1t+0E5HbPpxFOWVOEipoYRzjC+WoVH16UfVxuJWLZgX3EVOtSR3eWrC
 MNVRrFrE7rypMLkbG1AVKM8DDPyROeymZJGKpAJ3PdIxZIoOJbQoBXfA7RYx+eoTXo0H087ru
 VSb4vaZu3w0pMRVN63OTKVVCggMyfhUWRkJtWIKzxC31GHf0TQMNuDvlSqtzzb4Z2qv8GNRvg
 1AIYwm3V4aCuTQsZPcRLxsxknZfFXSA3uX9Gk8RcH5rneTSDQM0RzKPVJguSZkO78ITt2FPoA
 hMWrGDuAn8bzkot/K9+ugejeU1aDpR91oQI16KSf+GAS8m5D7DnWuC3Yrbk/PjdFrj/HCAylh
 328705b/uhhwYfVYLzxGSXpixLQ3t81ArIopmYFPh/zeMNQzlO7kN4J8yZ1ni5N6y4ubDOD8H
 lMhLdb/cA/B6DJt3Vhzl1nzZGJg4Si+HW9PU8OtiJFWx1kG8tmAvJKDV3SSmtc1wux8pT5SIx
 wJQ+gPBe5TNjxN3SZz1uJzJalqBElaGSFtqkiG5O5J6dvSw/i0L5FLHIi5CU2HBufGM6LINvY
 vURA2/NYqi7V06W3c51gmC9bDQGuTsQojBVnoGwMuMH/OV9lrwcw4P0OpG5KduTaJy0Slqq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 19 Jan 2018, Phillip Wood wrote:

> On 18/01/18 15:35, Johannes Schindelin wrote:
> > 
> > Just like with regular `pick` commands, if we are trying to recreate a
> > merge commit, we now test whether the parents of said commit match HEAD
> > and the commits to be merged, and fast-forward if possible.
> > 
> > This is not only faster, but also avoids unnecessary proliferation of
> > new objects.
> 
> I might have missed something but shouldn't this be checking
> opts->allow_ff?

Good point. This is the type of review for which I was hoping.

> Another possible optimization is that if the parent branches have only
> reworded commits or some commits that have been squashed but no other
> changes then their trees will be the same as in the original merge
> commit and so could be reused without calling merge_recursive().

True. It is also a bit involved to check this condition, and I am not sure
that it is worth the effort for my use case.

So I would invite you to work on this after this patch series settles, if
you are interested.

Ciao,
Dscho
