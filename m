Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A284C20A30
	for <e@80x24.org>; Tue,  7 Nov 2017 10:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754838AbdKGKYm (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 05:24:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:58278 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbdKGKYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 05:24:38 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgvEY-1ezyzw47ug-00oHzb; Tue, 07
 Nov 2017 11:24:31 +0100
Date:   Tue, 7 Nov 2017 11:24:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 5/8] sequencer: don't die in print_commit_summary()
In-Reply-To: <xmqq8tfig1rr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711071101050.6482@virtualbox>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171106112709.2121-1-phillip.wood@talktalk.net> <20171106112709.2121-6-phillip.wood@talktalk.net> <xmqq8tfig1rr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w7e47NZhGqyPOcIHqp9mY3vSUdYi+K4cFHwgg7tZmB5BbhkGuC8
 ZanM8yIu47XgxR62PD991kZuaV+nST9Ph3GxxW1yh5+Ro1D+8mfLP9Qbj+5HdCuq1K1wqXK
 5FyQjSzfKDuh0Z36/87BFygSvZQEm6SNjNqzWTHgvNMBo7Th3zFo+mv2V9UfoL8QqIR7b0u
 kpMIfwRNm74Nq21lP7kQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/0IGZtEDW/k=:cnyMdD0/CxKtJzm6r10gOU
 +YYA2XTOOh9pvDmHAiuWkUgzzneDLCUPWu3NUpQazEvQcxINTvnCbzOTLkkj/dl30na49fDrH
 wcXjlwhjsU5eWOSXN6LKoY9nB2ncUS+1en0Tc8GMFhJx/6VxCaeEHuQjDPXr7E0N2qZUUj/ek
 mnLY1/H1DFXy9tLIjLCVutCRIvfPp5k8PlPafD6pZXa6ntPsc43EE4YDzU1mx9OT5LZ7u1+kk
 GIGDTpTaFmfd8NFo4ohmVjUqpHweNdYYNg9GfvFerOyIYLpnR02mWGFAplt6uKPbu8F8gOfnp
 c67scclt8pNE4EiaaZkCdHWP6zzJlnJSLwG4YSs5ArzU7rGc2CYBN+Rp9zc6fcdiqMHuDfX0G
 iqBOwnhEYxXVgyCEBfw9HDiLhP2Tym11gcWQWhhh/T1pNfy0VS0LxN0MdWXkThyNQTN0vpgcz
 jG+98nXWsaQ2v6Ks17l1fxOlqKpNRJCx9c7JJHsSLFDPh6A7OhoSUfGjC7pZycqqHsbG6tFik
 bLQS3jQP3zdIA6hD1TxZq23xWrtlhAg40x8dPwj9gP6XbpdNZ7Qo34YTsUFso7Tn6IvCQf6EQ
 0/wwBM+fA85Gakmg0rvVZgiiiCZE1X3rhc3VK8I6Hh6gTuOGOSElSthIMIvySz6ERWwV5GpuB
 xH6bO6See2th/Y3Od8QBWSijvDA+UyiIv4sUo1ek5yr2tnFtuxlhcCDzBaGt7jC6fgg2DaGg+
 Glg2yWNamfPEad0+6qgvMPzRP/26pKJPEIpPZ/YIYGWJHEMZXL4arexiK48krLArx5kJ3bcPL
 ySpVdiCQjuNAtxOtFZfh6VHistB+1eAXA8CmfxxDpt26Qu0tik=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Nov 2017, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > Return an error rather than dying so that the sequencer can exit
> > cleanly once it starts committing without forking 'git commit'
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >...
> > @@ -948,7 +951,9 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
> >  		log_tree_commit(&rev, commit);
> >  	}
> 
> Is that call to log_tree_commit() a big elephant in the room?

Or maybe not so big an elephant, given that we *already* use it in
sequencer.c, in the `make_patch()` function. I did spend a substantial
amount of time to try to libify all of those calls back when I worked on
the rebase helper.

Also, bisect.c (not builtin/bisect.c) seems to use that
`log_tree_commit()` function, so it better be libified.

Granted, those two callers are *pretty* close to the end of the process,
`bisect_next_all()` is exit(10)-ing right after calling the caller of
`log_tree_commit()` (*shudder* what were we thinking, allowing this
completely unelegant and inconvenient pattern of exit()ing from
libgit.a?), and `make_patch()` is what the sequencer uses to fake the
patch that it never tried to apply (just to be consistent with
non-interactive rebase) just before erroring out.

And I am quite embarrassed for not having spotted the
`maybe_flush_or_die()` call in `log_tree_commit()`.

However, from a not-quite-as-quick-as-I-wanted look, it would appear that
this call is the only hard `exit()` code path in `log_tree_commit()`, and
it should be easily fixed.

Please also note that this is our mess, not Phillip's, as we let these
die()/exit() calls creep into libgit.a. It would be no fair to ask Phillip
to clean it up for us. *We* let this slide for over a decade: 06f59e9f5da
(Don't fflush(stdout) when it's not helpful, 2007-06-29).

> It definitely is a good thing to eventually make a direct in-process
> call into the commit machinery, and we should aim for that endgame.
> 
> And this step is going in the right direction, but I am not sure if
> this made the function safe enough to be called repeatedly from the
> rebase machinery and we are ready to unleash this to the end users
> and tell them it is safe to use it.

Well, holding it up won't fix it faster, it will just delay the fix.

I mean, this is Git, right? This is the same Git where we knowingly
introduced a BUG() call into released versions via b1ef400eece
(setup_git_env: avoid blind fall-back to ".git", 2016-10-20) that were
*prone* to hit end users' use cases that we did not think about, just so
we could fix those code paths.

Sure, we tried to do our best to avoid having end users see those BUG
reports, by investigating the code paths that eventually call
`setup_git_env()`. We can just as easily do the same here: investigate as
well as is reasonable the code paths that eventually call `die()` or
`exit()` from `log_tree_commit()`, and then flesh out the remaining
problems in production.

Ciao,
Dscho
