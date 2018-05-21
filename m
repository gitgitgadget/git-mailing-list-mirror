Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE581F42D
	for <e@80x24.org>; Mon, 21 May 2018 09:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeEUJvw (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 05:51:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:51837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeEUJvv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 05:51:51 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPlsg-1fOWxf38fS-004zva; Mon, 21
 May 2018 11:51:45 +0200
Date:   Mon, 21 May 2018 11:51:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
In-Reply-To: <xmqqvabh1ung.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805211144340.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <xmqqvabh1ung.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L4Q9C3skPoYy1MVhazqtGHIcl3N2uQ0t6EDtwqmGlEG4+gyWKEx
 iZW6qj8B+uYNte6ULVwdwrfP0TAm54Lf+/4DXtaKlQpYA50sVQU//6hPdt8WytEf4zg5jY0
 wsNBuyQBZOmkK3mlb6eueAXphjo3yHlkoz3H3IRv8CceNBzsSi+JDJvF0w+M9dj1/l3HPQP
 46beIe4bSb1sbzMqkNBVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yGODWwUbfsk=:FP0tu6Hn9b54BZ0cr7AN/w
 g0BdhmMxTDY+ZBG5mgZ5czTR5vjk5deNzjYytWIU8ZfP+xxLWzyzPISZ6AoFPGgUfJH8RadaV
 SR8P/wzafv8Cam55LXe7fiRciD5mV27MYcxOOzOJtm2NorJ4Cp96Qmx6v05QaOWWqvYfVPSDy
 XLcr1w8V5SzPY2M8JeCEjdPT4mTV5kQbmRVR9NxgW8t+6GEZRjlUj2Yuye88OCXJ2mpkC9pfl
 jeHiqhWmVteQAb9wnggJzgjdCNkDQi4dbLknUWd0VC5mg8Wfv2MumV8obGA2brSIzForEwT2Q
 A9+BlLvVkTAM+NWYrCelBLvM4tsxB2aQHILtsgWS0Fg4rqXTZpqtK08RgMY+1cTnrQRBwRTux
 n40w+jx5UJDuQkOKO9h7V+yJz8cDg+3hFL2E1bd37Dw5Ch6E54dBW7PDGuW/7UzM43xaEBcQ0
 lX+To7hb0bkQO8iU3knq3MHQ58CeGPDRlHPtXem18uAr0A5N1QGsu0hkLynimkWivqbPeDk9a
 uHQv1zW82aL04I2uXgEk7W4f0H4/Mbrp/6p2wFlcRhs55vPxD+7wFinmljKwilb51kH5BbF2O
 ctnHfSIfnTuxnYEEnnRkinxPZrZudaF9hsQEZrLFkiQ0v7djYlkbdC+FuQHTSNNfWx6t9STO6
 jk05qiSYWWcnUFFiiPQg0UrNoOHvxQkCtLeXDdNUziZP6TEv2G29DW/Qc5EEYts2IuXjevWzU
 hti0zINhqDHDsAqU8iL/H9e2CnSL8g4p/Xj4ZGW1i94ZYmssAUvd0JjhO6JMjfaBe66S+7Jy/
 zMHIoxl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 May 2018, Junio C Hamano wrote:

> I've been using both branch-diff and tbdiff while comparing rerolled
> topics before accepting them.  One obvious difference between the two is
> that the speed to compute pairing is quite different but that is
> expected ;-)

Yep.

It is also expected that the branch --diff actually works without you
having to make sure that the Python modules numpy and hungarian are built
correctly (which you Linux folks couldn't care less about because it is
done for ya).

I spent such a lot on time trying to get it to work on Windows that it
probably only now reaches parity with the time I spent on implementing
branch --diff.

> Another difference that is somewhat irritating is that a SP that
> leads a context line in a diff hunk that is introduced in the newer
> iteration is often painted in reverse, and I do not know what aspect
> of that single SP on these lines the branch-diff wants to pull my
> attention to.

Right. This is due to the fact that the diff does not realize that it
looks at pre/post images being diffs. And hence it does not understand
that the single space indicates a context line and is therefore not a
whitespace error before the tab.

>     https://pasteboard.co/Hm9ujI7F.png
> 
> In the picture, the three pre-context lines that are all indented by
> a HT are prefixed by a SP, and that is prefixed by a '+' sign of the
> outer diff.

Yep, that's exactly it.

The way tbdiff did it was to parse the diff and re-roll the coloring on
its own. I am not really keen on doing that in `branch --diff`, too.

> We can use --dual-color mode to unsee these but it is somewhat
> frustrating not to know what the branch-diff program wants to tell
> me by highlighting the single SPs on these lines.

I was wondering from the get-go whether it would make sense to make
--dual-color the default.

But now I wonder whether there is actually *any* use in `--color` without
`--dual-color`.

What do you think? Should I make the dual color mode the *only* color
mode?

Ciao,
Dscho
