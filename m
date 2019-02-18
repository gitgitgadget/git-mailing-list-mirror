Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D1F1F462
	for <e@80x24.org>; Mon, 18 Feb 2019 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfBRS5Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 13:57:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:41563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbfBRS5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 13:57:25 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh6sJ-1hR4rW2o47-00oVNQ; Mon, 18
 Feb 2019 19:57:13 +0100
Date:   Mon, 18 Feb 2019 19:57:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: safe-guard a bit more against getenv()
 problems
In-Reply-To: <96793350-0991-6e8f-6ab2-15777e2071be@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.1902181950130.45@tvgsbejvaqbjf.bet>
References: <pull.127.git.gitgitgadget@gmail.com> <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com> <96793350-0991-6e8f-6ab2-15777e2071be@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6U7bbI4EWm8b4uZXVFfR6t/ABctZn5ru/Zez4QBoV0i1XITM2lj
 As+ZfxjyZgaWI1gGzqyg6NUDaaIj+Btiw6DzKmURgu64n0Fz31tIL37qzPHN67/SbKrTEZA
 Ru5tLheWI4f1cOiIkN+vPtVgLaLQkKUohb1eQTTsK36ucUs0btPjKtg3rAaYCYQAk65/zxJ
 pqKGVoRzUCXwIfMrZUAeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:00pXA/IsgqE=:bhOIgg1+EUjrCksnzBopXp
 gBv9Xhi4YbLk/bhn+nKg//y/17YL8XPMKiOMCzciWmk2h/uINXijwxuUhN+K8n6MxmurSKLXn
 RMS5df1+CaXEckZLGPAjlkIMmoc/pjzSgq//0HFG3wDMTk3D7fcwxqlqHCHdA4dmqCNCOpXmP
 DjP+/lfrTbXDMfBoGkvG7TfC1rJXM9hBkEh0U0MHrEx3xqrqu9p5gB4dM0eRch/VyCXJYyN2F
 YPG8fTSCa0+NblexW/E7Z7EiUqurnwJOYbJczBxMPL7wh5E7J4llLGPrDGRyk6DKUpzQIsnry
 NtzKv8BcmKkfjIS/nsR2LpJKYJFtsgXzirwvErWBcHWCn+liUsmfhpMrELy7/B8Bq5AU4SRr6
 t3QdpZkW84KdHPPgS5iV4CovLrLtdeE5t5JZslJUjcGTesvfloxq73CotUOGEpiCZPsHU45wH
 JbsVB5UyCg/3OCpQikGCqpdsvKDGCok+N9sJLGxW1y/p6tJAnO3ezxJyvq6IxyVdnR19PoThU
 RrNEKjq6X3C004nsEQKYBh8PeT9qekHe8BHrRcN6J4sTkQ8oifK8c1fjwakQAqGmcLo4eUWYM
 gRYbQ/MwWTYApacqTkZaYRaQ5+xzYb3hJBbYBIDTKkshFfnquIcQIvsYSU9+ZAI2R2L+iSqPu
 ZzuXTGubSK4a6jT9yctJTChld11hdcs0+bhp0HIRomwgzXrgTQGAECrJbwzsp8W9677FSZtcz
 D9QfV2hyTCsjXceWI/7oA7bRo00dAQLchPhlr2oKIPE4Np2kVeE7YeXw9hYQicWFegqb/CpR2
 jBZRUpkl5+XtSFJ+3sjPdPHORYcUXtzQoQLXWnvfFhnYbHBZKEueDqDGEgupywpydo4+Up22c
 gxeO73+OXb6JIqfXlnXAaWl6c7ulMweDqykaz0+1P1AbOBeFEU9UUAI5bZVjCB4jIyonTmZyT
 Co3MZcnUfGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 15 Feb 2019, Jeff Hostetler wrote:

> On 2/15/2019 10:17 AM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 4276297595..8141f77189 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1632,7 +1632,7 @@ int mingw_kill(pid_t pid, int sig)
> >   */
> >   char *mingw_getenv(const char *name)
> >   {
> > -#define GETENV_MAX_RETAIN 30
> > +#define GETENV_MAX_RETAIN 64
> >    static char *values[GETENV_MAX_RETAIN];
> >    static int value_counter;
> >    int len_key, len_value;
> > 
> 
> Why not use a mem_pool for this?  We have that code isolated
> and re-usable now.  Have mingw_getenv() copy the string into
> the pool always return the pointer from within the pool.  The
> pool automatically handles allocating new blocks as necessary.
> And (if we care) we can bulk free the pool before existing.

The problem with the mem_pool would be that I do *not* want to accumulate
tons and tons of stale copies (remember that `difftool` bug? Apparently it
calls `getenv()` in a loop that scales with the number of modified files;
I would hate to have copies for all of those).

And all you could do to remedy this would be to blow away all of them it
the mem_pool grew too much, *including* the latest `getenv()` (which we
painfully keep valid, e.g. in the case of `git_committer_info()` which
calls `getenv()` *three* times *inside* the parameter list of the
`fmt_ident()` function call.

Of course, we could use a hashmap combined with a priority queue that
would cap at a given capacity, and once that is reached, culls the oldest
entries until the capacity is maintained again.

Taking a step back, thought, we are talking only about the
Windows-specific code, which is code we happen to have *some* control
over. On other platforms, we have a lot less control.

Meaning: the true fix would be some sort of static analysis that ensures
that getenv()'s returned values are duplicated unless it is super easy to
reason that the use is safe.

Ciao,
Dscho
