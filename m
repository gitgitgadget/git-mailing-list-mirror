Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1E41F428
	for <e@80x24.org>; Sun, 26 Aug 2018 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeHZWTy (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 18:19:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:56157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbeHZWTx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 18:19:53 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjdS8-1fMs4J1dCC-00beyO; Sun, 26
 Aug 2018 20:36:27 +0200
Date:   Sun, 26 Aug 2018 20:36:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH 02/11] builtin rebase: support `git rebase --onto
 A...B`
In-Reply-To: <xmqq1sb8hdvd.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808241821470.73@tvgsbejvaqbjf.bet>
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-3-predatoramigo@gmail.com> <xmqq1sb8hdvd.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:00xkA2voXRxZQ7kaUyEAPmzLPz4sbpWgGN07MZRKOMDvs4ibUbi
 p/TWpWAbb/UM/x/hFyutFsdYM7IZWdqBl0HaYfyBZhNG7XK9xTqUT7ZT7vK6OE/2aWTSK/w
 GltkM8Ia2CXILNUQ/hetfn5sPGs2BtAS3+MeIxFvV5H/wp6kXz6zjhB1sKEz56xOrtD/U0M
 8i+gvscuMeV9GSwx/FWyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D01YQrbO8ZQ=:WGMG5YcRfbEiarKLtFd5Hd
 J6tuN1QemQG3oEDuuv8MIY921OTAiPM03Dv40kFTIZ9D6gBeZFcpKITsx7DFdUQElbZd90OE4
 ugokA6o1D5Se1Qjk+Uz0q5ubCskd/oNCybRUX/Dv5GNQqlwz9hw1xvwbrEBI1n0OPDGKaLfLv
 TbBUJQvdOPADmZjKp1JDObBxp3zOuVa0H1UvsEoqjAtUkG5dEm4aH5Juwcis5PdDnUGgH+Fm+
 yF8ETX0c/OmKZezjlH+zwdeubWc7cforD1PVTGS7GeTvhApeKGXkxpYqF9py6n9HG+kAsgPUo
 LFSpEOE42BJdTxWoe5+8YozOzhdHfo6GaSHOVv8F4kAKBTBwMWIstvIIZIaUZT7AyX4CAqt4/
 iKoKA1lb1VNNA2ejSrCGgDB9mF6reiU8cmSqkBvE4PB8ONTKblBC6o5M+2YhUkXzPY4Qao5f+
 rxAAKvJAR4PUibqkqqESMkMkNiF/xP9yj+uBOX8uZjX+qIi4ht/LPPTri51zUZ5G+36C9wf+D
 LGtUyk5hcFAS0ozDEwfkn4WgFWyi6GeWx+hHpVpjn+pt1btIFJ31JjXweMF3hnWOn/6FA7YNg
 MROljnhxzx7UhZGSRg7PFMu987g5lPKdkutY4WBPTRjI6JZ+S9a+VOfRBTC1FLpYz4QJw+xtN
 ZhkXcJBQYDHngjGN/yHGjle12zBPUcdHpwobencbMqIdTeju7QVRYKAMhz4L0hutrjPJ3trcv
 5dvsk4Bi14VplVfCAnsLZ5s7Adti5OQqQhWeCgGWWoXwe+KXGKndWnlNjYn1+2PgVh8wwN8Wp
 z4jp1Af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Aug 2018, Junio C Hamano wrote:

> Pratik Karki <predatoramigo@gmail.com> writes:
> 
> > This commit implements support for an --onto argument that is actually a
> > "symmetric range" i.e. `<rev1>...<rev2>`.
> >
> > The equivalent shell script version of the code offers two different
> > error messages for the cases where there is no merge base vs more than
> > one merge base. Though following the similar approach would be nice,
> > this would create more complexity than it is of current. Currently, for
> 
> Sorry, but it is unclear what you mean by "than it is of current."
> Do you mean we leave it broken at this step in the series for now
> for expediency, with the intention to later revisit and fix it, or
> do you mean something else?

I suggested to drop the distinction, in favor of simpler code. Not for the
time being, but for good.

I reworded the commit message thusly:

    builtin rebase: support `git rebase --onto A...B`

    This commit implements support for an --onto argument that is actually a
    "symmetric range" i.e. `<rev1>...<rev2>`.

    The equivalent shell script version of the code offers two different
    error messages for the cases where there is no merge base vs more than
    one merge base.

    Though it would be nice to retain this distinction, dropping it makes it
    possible to simply use the `get_oid_mb()` function. Besides, it happens
    rarely in real-world scenarios.

    Therefore, in the interest of keeping the code less complex, let's just
    use that function, and live with an error message that does not
    distinguish between those two error conditions.

> > @@ -387,7 +389,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  	if (!options.onto_name)
> >  		options.onto_name = options.upstream_name;
> >  	if (strstr(options.onto_name, "...")) {
> > -		die("TODO");
> > +		if (get_oid_mb(options.onto_name, &merge_base) < 0)
> > +			die(_("'%s': need exactly one merge base"),
> > +			    options.onto_name);
> > +		options.onto = lookup_commit_or_die(&merge_base,
> > +						    options.onto_name);
> 
> The original is slightly sloppy in that it will misparse
> 
> 	rebase --onto 'master^{/log ... message}'
> 
> and this shares the same, which I think is probably OK.

I did run into this recently, but not with an `--onto` option. I forgot
the details (I meant to write it down, and forgot that, too).

Sorry for musing, back on the topic. Yes, it shares the same, and *that*
makes it okay. Remember: this patch series is not about improving `git
rebase` at all. It is about converting from shell script to builtin.

> When this actually becomes problematic, the original can easily be
> salvaged by making it to fall back to the same peel_committish in its
> else clause; I am not sure if this C rewrite is as easily be fixed the
> same way, though.

I will make a note so that I hopefully won't forget.

Thanks,
Dscho

> 
> >  	} else {
> >  		options.onto = peel_committish(options.onto_name);
> >  		if (!options.onto)
> 
