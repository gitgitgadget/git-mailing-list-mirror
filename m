Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0BC1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeKJDDU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 22:03:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:59107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJDDT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 22:03:19 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJXEd-1gNeNp30fr-0039Be; Fri, 09
 Nov 2018 18:21:42 +0100
Date:   Fri, 9 Nov 2018 18:21:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior
 where appropriate
In-Reply-To: <20181109101148.GB7410@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
References: <pull.72.git.gitgitgadget@gmail.com> <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com> <20181109101148.GB7410@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:86czkWgSOk9PiXozRBmTGjiRLsyhgq2TzzDjn32YwYYJib0sXRG
 8ins/CXEdTs2EMpFmXbJmvUrjHXL8ymGrkL4zU5IErwVlGO4KU5j8y+jWqJ3EpjZ9tv5ZVY
 u4ekV96qonsp1uvkLIuECv02hD2ZzVXp8Pj208p67l/+m/cLhSNxR53oL4mN3S8FRlYlhGn
 zJ/ugay0bmF7hPddTcRlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:exJWx+py4oY=:/iGU3aoOORIeNEyBpvb6J7
 o0PD1yJFHngk/Gg6QDtsEusKtPjfUaJxi69XmTdMjyMPtkpSEs3PBcMn7Y9gVHvH3X6qsR+5S
 15Hl0d4ErVbjgr+VfCy39SSvyNjtycnOJ1R2PPkFnfK2UVizgc9wW5jDpErIjLK6no7DwwKoJ
 vcy+0Z5ptfUBDVovBB5W/PzFmNsoEevspZIUzQa5jcCnj45zvREHWXpCfy9/4kNDO9O9Wzu26
 0uHto/EYCkSirOerCEaj1qTPkenlOnQ31K6cI02bcl+6CRRZ8fjKpG2PfYYnfIMJiQRl9rrwQ
 trFwKashyIPodPrDlXtZaFrnOUPNYFo0I/kvlAk26Hr3I2cd3ytjtSZ4A5RBazBk+Y6J7hM53
 DfWbD0a9G2oo764yUlG82oSKYDm5mcWksZdwwvl5QQ2CEZP3ry2TdtHDF2RKRRGJD6V5LLpBI
 ErKZJO2eZSUZYXmTWPg4gVu1oUjKJ6fU0aY09C1eA1QuylemXDEvZK1zUEFiJRL3lSUoDa7Dm
 Ov4ul3qyvS+YVcEkkYb04vNqpstyv/+2OP4+DmyqPZrxNKXnROCVAj420DTubuv3fYJNiYHYY
 JNQZukxqQ6xSoWwMjkVeascO5hE0ga1FjzZERuw9XwAX4lANYtJ8JGGHhCM55Qrtmm58BuJgV
 AHJI5FRGY/qoJuodtYw8sBu8+6MzojYUzBss/FpasXP5gcKC2lXKJvI6rFhmcIWGliZyrxZIB
 P/XF/mgHBp3kkxi72L4xUTcAcBVFNjT+rGrWpV5cEHnT+O43ISGCP53c//LqQ4U5ksiWFGbzP
 8fKOG96IAoxEd4nZFHwWfz0wYt2lN9QUcmyTPhmpU5lGfa+C0rI+w4ejv6uNl8aCamZEzs5Iq
 anYURGsxQYh5G2RPA6n60InF/KTx7yeemPHdFOKbIzz/DZH0A6GWqbSZwG/W5xN53d1SC0Qh7
 5YkWYfM2uZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 9 Nov 2018, Jeff King wrote:

> On Fri, Nov 09, 2018 at 01:34:19AM -0800, Johannes Schindelin via GitGitGadget wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > When we converted a `git checkout -q $onto^0` call to use
> > `reset_head()`, we inadvertently incurred a change from a twoway_merge
> > to a oneway_merge, as if we wanted a `git reset --hard` instead.
> > 
> > This has performance ramifications under certain, though, as the
> > oneway_merge needs to lstat() every single index entry whereas
> > twoway_merge does not.
> > 
> > So let's go back to the old behavior.
> 
> Makes sense. I didn't think too hard about any possible gotchas with the
> twoway/oneway switch, but if that's what git-checkout was doing before,
> it seems obviously safe.

Right.

> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 6f6d7de156..c1cc50f3f8 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -523,11 +523,12 @@ finished_rebase:
> >  #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
> >  
> >  static int reset_head(struct object_id *oid, const char *action,
> > -		      const char *switch_to_branch, int detach_head,
> > +		      const char *switch_to_branch,
> > +		      int detach_head, int reset_hard,
> 
> It might be worth switching to a single flag variable here. It would
> make calls like this:
> 
> > -	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
> > +	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1, 0,
> >  	    NULL, msg.buf))
> 
> a little more self-documenting (if a little more verbose).

I thought about that, but for just two flags? Well, let me try it and see
whether I like the result ;-)

> > -	if (!oid) {
> > -		if (get_oid("HEAD", &head_oid)) {
> > -			rollback_lock_file(&lock);
> > -			return error(_("could not determine HEAD revision"));
> > -		}
> > -		oid = &head_oid;
> > +	if (get_oid("HEAD", &head_oid)) {
> > +		rollback_lock_file(&lock);
> > +		return error(_("could not determine HEAD revision"));
> >  	}
> 
> This one could actually turn into:
> 
>   ret = error(...);
>   goto leave_reset_head;
> 
> now. We don't have to worry about an uninitialized desc.buffer anymore
> (as I mentioned in the previous email), because "nr" would be 0.
> 
> It doesn't save any lines, though (but maybe having a single
> cleanup/exit point would make things easier to read; I dunno).

But you're right, of course. Consistency makes for easier-to-read code.

> Take all my comments as observations, not objections. This looks OK to
> me either way.

Actually, you got me thinking about the desc.buffer. And I think there is
one corner case where it could cause a problem: `struct tree_desc desc[2]`
does not initialize the buffers to NULL. And what if
fill_tree_descriptor() function returns NULL? Then the buffer is still
uninitialized.

In practice, our *current* version of fill_tree_descriptor() never returns
NULL if the oid parameter is non-NULL. It would die() in the error case
instead (bad!). So to prepare for a less bad version, I'd rather
initialize the `desc` array and be on the safe (and easier to reason
about) side.

Thank you for your helpful review,
Dscho
