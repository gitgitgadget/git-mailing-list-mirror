Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FF31F404
	for <e@80x24.org>; Fri, 10 Aug 2018 20:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeHJXIZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:08:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:37011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeHJXIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:08:25 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMTZa-1fprWC3auM-008L63; Fri, 10
 Aug 2018 22:36:55 +0200
Date:   Fri, 10 Aug 2018 22:36:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between
 patches
In-Reply-To: <20180730212606.GL9955@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1808102233490.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com> <20180729190359.GD2734@hank.intra.tgummerer.com> <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
 <20180729214543.GD9955@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet> <20180730212606.GL9955@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ywzZiXXkk5xFYgN30IwMG8pumtm2JpSEY2gi3FK8/tM02LzgnKM
 KGjRij37f93K4n+hyiggcF2lQoVSIoJW2EAB3hRujskYxpSmFpAMF0RTqnCaIDW5a9T3KOW
 jdXwvFkdWFFrSsgjXMawb6WNgib5xxO87mAKzP/rf78NHZkZZRSW/onzmXYRrN/PFRPGeyM
 Wtg3NINitu/7pEj9OiQtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hMKQfhhpZdo=:tADql/l01xqSizRP8vjnfF
 PISPGKY1Npqp+r0shUEToGvaF8UzmVUPa1CSGRTGTx5+ngbubuJMceB4fzGPUfVJ4aAUzqUJw
 Le2PfuoEkn8lri+kc1idLO8Cv7x9GL8/2xYDO6cPQ3stREK8kuFvTC2ahDZu8a6BlXY2j5CqH
 fzc4PUS+TYGklrpxDk+6267UXsSSg5t0bJbcxYHpzMnjXjqJ/aJdMFCTLmFN1+cbbm63Yv1ah
 /PgHOCKcVUOVcAuYut/M2fzS89IIj9P8pnCko1oJvRR95uGc1sqURxjfxj7+z5U/LJEbFde/B
 ShlilX4Os2MhrO+3HP6hEKLFncjIj4N5WpeQX8J/qc6mRCJiyIbmNPVKgln/K88QC/Eatqz0Y
 k5fFm9wWZ9ZlGkJL/pE/o0zUqZtkN7fZVvKiyDJcVEcBmTQMfMc944IRgw83Wn4frzuDQCdqr
 aFbOPN4kgOc9ZgPE4u3BCxuQkFOG6U8/B2/4sub9O6wt35zCPmx2pAk+kBa0NQbEFI2J/OYBm
 gWdzdzWdwhb6mbYk/MIaWLfyQcrWsmt5AwNiZ0XwUh+pQUjMTN9j0Qan4p5kHwByymNWGcbUL
 XF6To+SO2fPofXKW5pXuE3sspj+VMZq1CEFb10rXwy85bfhXjzBKOjYzYnz2v6jqMJg1rqxVT
 j50jmUMKHyPzE3bqzo6OLSg0gDdUnFty6CY47IDa23KLFgsro5jyXycPUdrAQkFaRgKjkepqn
 oSj/D//ifrmiYBASTxlALDadlvEu71mTNSndBcDOcetqoBQLhAaRMYMwEi2hUhCzpHOcZUPa0
 WTnYBvV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 30 Jul 2018, Thomas Gummerer wrote:

> On 07/30, Johannes Schindelin wrote:
> > 
> > On Sun, 29 Jul 2018, Thomas Gummerer wrote:
> > 
> > > On 07/29, Eric Sunshine wrote:
> > > > On Sun, Jul 29, 2018 at 3:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > > > On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > > > > > Just like tbdiff, we now show the diff between matching patches. This is
> > > > > > a "diff of two diffs", so it can be a bit daunting to read for the
> > > > > > beginner.
> > > > > > [...]
> > > > > > Note also: while tbdiff accepts the `--no-patches` option to suppress
> > > > > > these diffs between patches, we prefer the `-s` option that is
> > > > > > automatically supported via our use of diff_opt_parse().
> > > > >
> > > > > One slightly unfortunate thing here is that we don't show these
> > > > > options in 'git range-diff -h', which would be nice to have.  I don't
> > > > > know if that's possible in git right now, if it's not easily possible,
> > > > > I definitely wouldn't want to delay this series for that, and we could
> > > > > just add it to the list of possible future enhancements that other
> > > > > people mentioned.
> > > > 
> > > > This issue is not specific to git-range-diff; it's shared by other
> > > > commands which inherit diff options via diff_opt_parse(). For
> > > > instance, "git log -h" doesn't show diff-related options either, yet
> > > > it accepts them.
> > > 
> > > Fair enough, that makes sense.  Thanks for the pointer!
> > > 
> > > There's one more thing that I noticed here:
> > > 
> > >     git range-diff --no-patches
> > >     fatal: single arg format requires a symmetric range
> > > 
> > > Which is a slightly confusing error message.  In contrast git log does
> > > the following on an unrecognized argument:
> > > 
> > >     git log --no-patches
> > >     fatal: unrecognized argument: --no-patches
> > > 
> > > which is a little better I think.  I do however also thing the "fatal:
> > > single arg format requires a symmetric range" is useful when someone
> > > genuinely tries to use the single argument version of the command.  So
> > > I don't know what a good solution for this would be.
> > 
> > I immediately thought of testing for a leading `-` of the remaining
> > argument, but I could imagine that somebody enterprisey uses
> > 
> > 	git range-diff -- -my-first-attempt...-my-second-attempt
> > 
> > and I do not really want to complexify the code... Ideas?
> 
> Good point.  I can't really come up with a good option right now
> either.  It's not too bad, as users just typed the command, so it
> should be easy enough to see from the previous line what went wrong.
> 
> One potential option may be to turn "die(_("single arg format requires
> a symmetric range"));" into an 'error()', and show the usage?  I think
> that may be nice anyway, as "symmetric range" may not be immediately
> obvious to everyone, but together with the usage it may be clearer?

Agreed. Will be made so.

Ciao,
Dscho

> 
> > > > > > diff --git a/range-diff.c b/range-diff.c
> > > > > > @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
> > > > > >                       printf("%d: %s ! %d: %s\n",
> > > > > >                              b_util->matching + 1, short_oid(a_util),
> > > > > >                              j + 1, short_oid(b_util));
> > > > > > +                     if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
> > > > >
> > > > > Looking at this line, it looks like it would be easy to support
> > > > > '--no-patches' as well, which may be slightly easier to understand that
> > > > > '-s' to someone new to the command.  But again that can be added later
> > > > > if someone actually cares about it.
> > > > 
> > > > What wasn't mentioned (but was implied) by the commit message is that
> > > > "-s" is short for "--no-patch", which also comes for free via
> > > > diff_opt_parse(). True, "--no-patch" isn't spelled exactly the same as
> > > > "--no-patches", but git-range-diff isn't exactly a perfect tbdiff
> > > > clone, so hopefully not a git problem. Moreover, "--no-patch" is
> > > > internally consistent within the Git builtin commands.
> > > 
> > > Makes sense, thanks!  "--no-patch" does make sense to me.  There's
> > > still a lot of command line flags in git to learn for me, even after
> > > all this time using it ;)  Might be nice to spell it out in the commit
> > > message for someone like me, especially as "--no-patches" is already
> > > mentioned.  Though I guess most regulars here would know about
> > > "--no-patch", so maybe it's not worth it.  Anyway that is definitely
> > > not worth another round here.
> > 
> > Sure, but not many users learn from reading the commit history...
> > 
> > :-)
> > 
> > Ciao,
> > Dscho
> 
