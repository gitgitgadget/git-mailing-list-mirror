Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A400F1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbeGNWRk (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:17:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:54285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbeGNWRk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:17:40 -0400
Received: from MININT-3BS5S37.fareast.corp.microsoft.com ([37.201.195.126]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MVNWU-1fYIwX1yVK-00YhUr; Sat, 14 Jul 2018 23:56:59 +0200
Date:   Sat, 14 Jul 2018 23:56:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
In-Reply-To: <20180713203140.GB17670@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com> <20180713203140.GB17670@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bjoo/s2affZqPCT8k+i2cupUsBKoFp55vf703K8wRh+bZe92lD6
 MFHNNGfVDkZuNpOYZdDC8MJCv/bUWHOHrYL9QmYIeGWSksJ/eUoLk/QHVJtKbmtGi6phmdk
 3hkLWaek1lbHaT2sWTYqLsK6KOu7YfKrHtAntsjQ/uGRky1SH5bK4OT8KGoUTYEg7Hi706L
 2EwuQMD2A7AbQvzk+90xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cVHSmxEDRhc=:5zfpaDh54mDWwYq5SUqZS+
 zhIoRn05p4t05Z3mnUTdZwD+qKxsa10UuuejMoP+3jtow6LppkV1vFhb6EdzAcZCSAdjGA+qg
 T9mrIKaSgcKfZXU/moC1RISEbAUSdxo+b4O6Dmdn66iH9a8Sqz1RbMJuOOi0fMI1mHrh8r9GG
 UhZsQxmSkbERw7dfa5ReGN63qQ5XYCRRsWoxq7306YmLRpZMhkZxzfED0heyY08V3LYWLhN8u
 zeWOIhDmO1V+Vdol2b/vK4mSBDG3O0WTVf0w1cqIVkm/wylNZDrLzsc4WAjxedkHwhipHciVf
 ZVJr1Fk1eF4P8N6NPs6wMyuqX1Oo4DiZ39JKt8KXffcS2tvzsxN/Xlsw+cfHcbu5CnuzUMBpY
 GK8P1rbFs44etCtWofnJrkGb9PCvHtLQFfLyS8PW2FBvnmtTmydWo5POi8fVlueqX8N+5vEGX
 AFkizXmrUtbquB61+EVP9ivHWtxtkVsBHHRRXaGao3Uqlwj5stCloHRMc51FXrVauZHhnsBID
 pZz6ClhHKlolsLX53ivCgwAGN696u/cIKiXXCjJVG4+W/eMxLrm7Yih6IejY6siuLZDFSzYw5
 ViPRV+vkr8xWajucprgKdZF7+iotVC1NnZvEY4GwoLUbjngXHEsDA4ZKsS/QXpWyjmTeEz3Ar
 glsiPazHb5anYsnM2409iixwNTshP6POZpdilLOQEjFE93GKe9P5SLxb0bLQWdYBdreMVC8YN
 hSQxrxeIXQYV37AxCsUjWebyPssqsiI62MMphgrzK+PhY8xTp3fciWFHicOixriDPelTaTSJ4
 3q4lmbK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 13 Jul 2018, Jeff King wrote:

> On Thu, Jul 12, 2018 at 12:23:28AM +0200, Johannes Schindelin via
> GitGitGadget wrote:
> 
> > This is particularly important to keep in mind when looking at the
> > `.git/shallow` file: if any commits listed in that file become
> > unreachable, it is not a problem, but if they go missing, it *is* a
> > problem. One symptom of this problem is that a deepening fetch may now
> > fail with
> > 
> > 	fatal: error in object: unshallow <commit-hash>
> > 
> > To avoid this problem, let's prune the shallow list in `git repack` when
> > the `-d` option is passed, unless `-A` is passed, too (which would force
> > the now-unreachable objects to be turned into loose objects instead of
> > being deleted).
> 
> I'm not sure if this covers all cases:
> 
>  - even with "-A", we may still drop objects subject to
>    --unpack-unreachable. So if your pack has an old mtime (e.g., because
>    you haven't packed in a while) I think you'd see the same problem.
> 
>  - if you use "-adk", we'd keep all objects, and this pruning would not
>    be necessary

Sure. I can add those cases.

> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 6c636e159..45f321b23 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -444,6 +444,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  		if (!quiet && isatty(2))
> >  			opts |= PRUNE_PACKED_VERBOSE;
> >  		prune_packed_objects(opts);
> > +
> > +		if (!(pack_everything & LOOSEN_UNREACHABLE) &&
> > +		    is_repository_shallow())
> > +			prune_shallow(0);
> >  	}
> 
> I understand how this solves your immediate problem, but it feels like a
> weird layering violation (which I think is a result of existing layering
> violations ;) ).

Okay, but please don't punish me for those existing layering violations by
forcing me to address them, instead of a quick bug fix for a very real bug
that was reported to me privately, and that I would like to see fixed
relatively quickly.

> I.e., it seems unexpected that "git repack" is going to tweak your
> shallow lists. If we were designing from scratch, the sane behavior
> seems to me to be:
> 
>   1. Shallow pruning should be its own separate command (distinct from
>      either repacking or loose object pruning), and should be triggered
>      as part of a normal git-gc.

I fail to see the value in a separate command.

And: `git gc` already calls `git prune`, which *does* prune the shallow
list.

>   AND ONE OF:
> 
>   2a. Objects mentions in the shallow file are important, and therefore
>       _are_ considered reachable on their own. Neither repack nor prune
>       needs to know or care.

If we were to do that, we would never be able to gc any stale shallow
commits.

That would be rather bad a design, don't you agree?

>   OR
> 
>   2b. It's OK for shallow objects to be missing, and the shallow code
>       should be more resilient to missing objects. Neither repack nor
>       prune needs to know or care.

That would be possible. Kind of like saying: we do have this list of
shallow commits, but oh, BTW, it is likely incorrect, so we painstakingly
verify for every entry during every fetch and push that those commits
objects are still there.

It looks to me like a rather bad design, too, as the whole idea of having
a `git gc` is to update such information *then*.

Sadly, we also allow `git repack` to drop objects, and it is really the
responsibility of a command that drops objects to update things like the
`shallow` list. Because that is exactly the time when its contents can go
stale.

Ciao,
Dscho
