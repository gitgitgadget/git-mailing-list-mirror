Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2494820248
	for <e@80x24.org>; Fri, 15 Mar 2019 13:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCONZP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 09:25:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:40499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfCONZP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 09:25:15 -0400
Received: from [192.168.0.129] ([37.201.192.41]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOx4J-1h9TG80o1H-006RU1; Fri, 15
 Mar 2019 14:25:07 +0100
Date:   Fri, 15 Mar 2019 14:24:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] parse-options: make OPT_ARGUMENT()  more useful
In-Reply-To: <20190315031553.GB28943@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903151421110.41@tvgsbejvaqbjf.bet>
References: <pull.163.git.gitgitgadget@gmail.com> <pull.163.v2.git.gitgitgadget@gmail.com> <10775638ad8f2ef9b64b8dbaf71b80d8546e81d8.1552562701.git.gitgitgadget@gmail.com> <20190315031553.GB28943@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2113359833-1552656307=:41"
X-Provags-ID: V03:K1:lsedNJdOGANWvJKglCiUirNsd5S5uJEJ+EriOuYnO7pl755WR84
 BrL+Y9xs/qE7Z4/hd4veQ9fOXzIxJDg3Lyijnbkn/iHhI+vDHWCgxKAUxTYOkZIeheDSns7
 16sn3/klyruWMsY2zRrI/mNzkvczgNGvOFcKwGAhfDaeSy7a39k0vUHbb/9F7R3+aThQC66
 fDDIGhwZHAjnzPDAyvBcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SfL6LTeiZHY=:G3e5ZhDxTITByrh3X88QKo
 QVBdn0NgtmVK4i1l6xGf/p/+Pt76OKcuosDAM8s8IvRZJwZ/TH3ExrHN9CFCsmVSHjZb3aC1Z
 Ud4t9ehpSJj7QIMA4bigkGn1tNUBdD2wrCpE79bmN794pSJEmUMGIOCRYEDjOPhq+zyqbiYFc
 Ac1gJb03Zaq4N5P17B2uYAh+Uy/Q2V32D2FKTQbibQ36mdB/4QKP5mQAs2DW0GVgi9sK36xY3
 pyBsSBpXomqWIQONG3B5cOU1T9R1AtZMhj4/3MB+qNIdl9k54XuAZ0WfD5aAxiC9WCZ69bPHd
 BJeD5BZwgKdBFAQb687XhLav4vcW/tUMKnn3MuTDXdvD7WE2NfyerUIDNxoJX/eoc5DarEViV
 Ix5tIK30xRnRl7L7JSkfX04TVvWbr5pJVwZX13Jlw+v6Dg8y70y5p49Rl0TcFX0Mq3pPUj81h
 ZfVD+WYUg0TA0eRp0hp1vS7vGn1gnA77lgRTxwdj/pgo1tuVDNdsXX13G1s6kUfGdnD615IaA
 3/hLcpO9aT60zEFcU1Vc/neuJwWAohIg3b7lflFJ9R47Nd3sqmXlr8YITcwZAtYfb/3IXlwBs
 XZmE6aVZmIgAECD+r1n3bjumeTzAEKLtglTwPOxJzHAcHj8Dlxf1Kv8SM9BZsHIkTwju8EWyJ
 r+IMfq8t4uWXo7pOwLWsDp/kej1Ba56/EBDOQ/eCTSLdP7myBrQg1//NEynamSJBhvYdLrbXz
 r9Z2skHm/9ciZ39isM/Op6YjWWVsql5KtFr59rUCMpx7crhuIqcRyAc+eeAd4IIlhJ6w6nmN/
 jye3nWHKRn5P8xyEgSly5lEAaJD4UnZjIzHgVk5SndOT/rr5+PGHY+TME7Du7ufK4Eyk+0gQe
 FX1oWQI1WdKZhmNJq4WSSBOeb3gbupZqKvyQJBm6aOvgdGJPKRPPshsWNv+SAzWJxGpmIzkRt
 L6f9IUYwahKDoVMsYvyjJVXjrhixjRnc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2113359833-1552656307=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Thu, 14 Mar 2019, Jeff King wrote:

> On Thu, Mar 14, 2019 at 04:25:04AM -0700, Johannes Schindelin via GitGitGadget wrote:
> 
> > diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> > index 2b036d7838..2e2e7c10c6 100644
> > --- a/Documentation/technical/api-parse-options.txt
> > +++ b/Documentation/technical/api-parse-options.txt
> > @@ -198,8 +198,10 @@ There are some macros to easily define options:
> >  	The filename will be prefixed by passing the filename along with
> >  	the prefix argument of `parse_options()` to `prefix_filename()`.
> >  
> > -`OPT_ARGUMENT(long, description)`::
> > +`OPT_ARGUMENT(long, &int_var, description)`::
> >  	Introduce a long-option argument that will be kept in `argv[]`.
> > +	If this option was seen, `int_var` will be set to one (except
> > +	if a `NULL` pointer was passed).
> 
> So this effectively makes it into a "bool" that we keep.

Almost. It is only a "seen" in the sense that you cannot re-set it to
`false`.

But yeah, the difference is subtle.

> I think that's fine. It always uses NOARG, so it is not like we would
> ever need to see "we got --foo, and this is the argument it had".

Yep, I checked that.

> I did wonder if it was possible for "--no-foo" to trigger this (leaving
> the caller who looks at the int unsure if they saw "--foo" or
> "--no-foo"), but it seems that the parse-options code checks for
> OPTION_ARGUMENT before it ever looks at negation.

I checked that, too.

> Curiously, it also checks it before doing the usual prefix-matching
> magic. So you could otherwise say "--no-inde", but OPT_ARGUMENT() will
> not allow it. I think that's probably sane and not worth thinking
> further about, but it is an interesting quirk that a user could possibly
> run into.

I missed that... ¯\_(ツ)_/¯

> > diff --git a/parse-options.c b/parse-options.c
> > index cec74522e5..1d57802da0 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -286,6 +286,8 @@ static enum parse_opt_result parse_long_opt(
> >  					     optname(options, flags));
> >  			if (*rest)
> >  				continue;
> > +			if (options->value)
> > +				*(int *)options->value = options->defval;
> 
> Cute. You could actually assign any defval you like, though of course
> the convenient OPT_ARGUMENT() macro just always uses 1.
> 
> I wondered if you might need another cast for defval itself, but it's an
> intptr_t (so it's the types that use it as a string that need to cast to
> "const char *").

Exactly.

> This looks very clean overall, and I agree it's much nicer than the
> alternatives for your use case.

Thank you! 😊
Dscho
--8323328-2113359833-1552656307=:41--
