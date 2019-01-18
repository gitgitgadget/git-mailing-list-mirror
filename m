Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD13A1F454
	for <e@80x24.org>; Fri, 18 Jan 2019 14:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfAROW7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 09:22:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:60007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfAROW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 09:22:59 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTw5-1gVrw91KOr-00LB3F; Fri, 18
 Jan 2019 15:22:52 +0100
Date:   Fri, 18 Jan 2019 15:22:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive
 machinery
In-Reply-To: <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1901181519230.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com> <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com> <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com> <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:COOhrvxehxMlk2klMWhR5VjxRQNIheZf7G3i+Nx/uP6/8bCdL/8
 BohExW49Fd9wnhTARLsFh+LA2JZPDU3Z1uNT1q/Y46HuN0zjSjdV/64PzXfYqEgLdowb0D4
 udf3NMOfuAliKPSANsH0l3+HTm9Du4UYofSN9nAkvyUurypDCUIAAp0UeEF5jyvqWLou7lV
 45HqA86npi/MeWZtVDwWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kHYBNIsrvSs=:oA74+Q6nrlT4bZHEiAK/vQ
 vdZrFlBQXa5eFSCrofmuN4195sj4lD/KsU9mmi4BjI8pNKLaHzaf41vY1+2Cgz16T9RWgMYuf
 M0LBhP7lbYFf/XOJ8JIj6NwiPX6BMx+FeDfb30X8ejg3TyVz2YYsFZtqMoo4VYaUJTMvXwbdP
 b7VJ2UXLLcsomxY67Q+WTTszfeqQLn/eZ2pEFnaHWWSk8RMH29xZ/FPOkLBiddnz+IXJLj+3x
 ZdU9IYohLMDN2h+ZRm8XhdfQhbDP/0vRSy7mitj7nWoLFl+gptchztcQO+Zeq4TrBWUhFW1sy
 1pycRfqDg0jfCt+QCPAO6DhT493BDmcGh/tAqt8MvBHkk7tpxFM9MPA7Cjwjo23Xm+LH0izgy
 7OZkyPCh/ZrzzkKRKU4EtACMPIz+k5Q2eXC5pMyfrZCEwFRG7tdfkpXiS2Qxo0tPT7isc0pSF
 SwpYN4xTan6x+eBz67oHIGBgehDXuzZ8owwkUtTbnn1QGo8YTiOK5kmwCm76U5k4ZPoIPL/cC
 lFvkcqFerRJlM0uGhYp9spG5DKaAEz9KT1UvrVTuZvcyJ54dPP42fVRNBwsgHa5ZK2n8x7+8V
 5dV11btdfSbRPMIoYTiFH/WBMcRF+nOVBIXQWPTulNqhkpLLLHhXZQt0MXfuWJ59lzDwp3I+o
 fatI385fJons3L9NKvb4FGtOmRPNwyebfZs9WA36eTIOhkMAp+n+N76mL7fPzhF0FtxGiPQ3E
 UxeYau5Dgd1of074STjIouIqdPUQ/cGD1Mgy96iYyIDWHn8yNqwWg+NB3BTiXTq/PykUaRQKN
 1P2Z5c7tUiJnr6a7eSYP71ms/hlSklNgafKGPar5owbVGK7nZFAH18IBvc5znN/6CU7reBpAH
 jt3wTotSEJDy64YjzaNr/wg3pkgYWq9uDYDlSzIB1WAXnEiAF6gENLzPbTps8AuhrGpM+aDvt
 ZtJTVcyqUEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 18 Jan 2019, Johannes Schindelin wrote:

> On Mon, 7 Jan 2019, Elijah Newren wrote:
> 
> > Dscho: Looks like our series conflicts slightly.  Would you like me to
> > rebase mine on top of yours and squash the following change into
> > commit c91c944a068e ("rebase: define linearization ordering and
> > enforce it", 2018-12-11), or do you want to rebase your series on mine
> > and either make a new commit out of this change or squash it in
> > somewhere?
> > 
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 0317280f83..54023547ff 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -578,7 +578,8 @@ static int run_am(struct rebase_options *opts)
> >         argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
> >                          "--full-index", "--cherry-pick", "--right-only",
> >                          "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
> > -                        "--no-cover-letter", "--pretty=mboxrd", NULL);
> > +                        "--no-cover-letter", "--pretty=mboxrd",
> > +                        "--topo-order", NULL);
> >         if (opts->git_format_patch_opt.len)
> >                 argv_array_split(&format_patch.args,
> >                                  opts->git_format_patch_opt.buf);
> 
> I can easily squash that in.

Actually, I take that back. This is tested-for in the regression test
suite, and I need to keep the built-in and the scripted rebase in sync for
that test suite to pass, so that single-liner would incur more changes
than I am comfortable with adopting into the builtin-rebase--am patch
series...

I am about to submit a new iteration of my patch series, would it be too
much trouble for you to rebase on top? If it would be, let me know, then I
will rebase on top of yours.

Ciao,
Dscho
