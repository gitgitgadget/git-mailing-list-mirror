Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0BC2018E
	for <e@80x24.org>; Sun, 10 Jul 2016 14:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136AbcGJOQ3 (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 10:16:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:59329 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbcGJOQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 10:16:28 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LmeGF-1amuuX1I15-00aBlB; Sun, 10 Jul 2016 16:16:18
 +0200
Date:	Sun, 10 Jul 2016 16:16:16 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Josh Triplett <josh@joshtriplett.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
In-Reply-To: <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607101602320.6426@virtualbox>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com> <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com> <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qoB+pPLk/J76qg/4d97XJ75XshrPNRQgp2XlnW915zrpei5mIPN
 /lF4RUqaPfVhDNQSSIv9h7vl3C8wUqDKNcB4bv8jj2tanGSpHp/wIcbYbmHZZWsFVHWBRZd
 HAIoCK8/6b7rNNSRR0POpc9o7ASpePmVoxxKWrU1nmzIov2/f/RFhvIxhEu3h1bKwE0MTib
 uoIdOzV0SsPJtYvl67K9A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:0jifCOATXyQ=:qoUKMPfqZO6WlrAcmRcVis
 QcfNHNH7SVmWUl2lgunVAdg23HUvlz+U62/iMOxMWDdKrFfp5I2sNOl+KdoHSXfHNQ6v9autC
 RcUetptdy4s/o1SB9Dl0rh3hziW+RBxcRZnIr3lVpvlt4n87b0gbYKFbv1GUb87KqQzWuhj/k
 w2KPiMWOyPI50VIkixD40dAZaLw6SvXHhJffOWPn/LKulnezQuo1iMU/QGn7uO2L7UNw29LLc
 7MgsX2xEwfa46sVazDtyBigjcxW1388B2ad6geEoIb30S1EKPwoz3NClp7iJq+TIcNrcpmuvn
 iuCpjxTwh5X58UqrvpiYpuBwNMJnHOl3lLaZV3omO47q3bFIrKkcc2gnCl97+zdozyaSFmpqR
 wdpQMF6s0cQs8H9TvasIU7vw8toAB7Ge/ujShcnO+Dv1AKUDeJ1OWZ8mVCv4StZYLqMiYGZtV
 Bc7zfFzt4q6LESIXSbBkPk6zSt8ag0YlMYDy9yZUj76uXKbvB7to4/uDS9M+YwhV1a/lU46DY
 WmoNZz9eeFvJeU8Iv0TvV92NQ5otudmwmvFgbEXhapWGnOuQtkumvSH7Jv9xNMSX+MiL9nAtB
 oGzE+y3DJbNwSEZV8JvspQEmMu6HXlpkR5Ss6sRyaGR7oISZrguOK+QgD+OUZQ0Z4qNkZObIF
 J3Zvq7sdkSJ0UV7epuOfp8qVt18Jwn6CHwER8WNqBo2vgK2Z8UQc4/2JPH6cUHVoxgqfOlxph
 4bP1BYtTGDo9Aer1N9fAQ8DN6Txg8YloUTby/aerBu4NcfRVduC0i7NfYJm5OXXQHJx3OSHCy
 VcyZPoB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Sun, 10 Jul 2016, Duy Nguyen wrote:

> On Sun, Jul 10, 2016 at 12:59 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> >> Now, how about special-casing *just* these legacy files in gc: HEAD,
> >> >> FETCH_HEAD, MERGE_HEAD and CHERRY_PICK_HEAD? Any new transient refs should
> >> >> live in the refs/ namespace, which is already handled.
> >> >
> >> > That seems workable as well; in that case, we should also document this
> >> > (in the git-gc manpage at a minimum), and explicitly suggest creating
> >> > refs in refs/ but outside of refs/heads/ and refs/tags/, rather than
> >> > directly in .git/.
> >>
> >> Not just outside refs/heads and refs/tags. It has to be in a specified
> >> namespace like refs/worktree/ or something (we are close to be ready
> >> for that). We could update the man page about git-gc shortcomings now,
> >> but I think we should wait until refs/worktree (or something like
> >> that) becomes true before suggesting more.
> >
> > We have a precedent for a ref that is directly underneath refs/:
> > refs/stash.
> >
> > IMO that is okay: depending on the use case, we would need multiple refs
> > (like refs/notes/*) or a single ref (like refs/stash).
> >
> > The important part is that the new refs start with refs/, and if they are
> > to be transient, start neither with refs/heads/ nor with refs/tags/.
> 
> No, the point is, refs subsystem needs to know which refs is per-repo,
> which is per-worktree. So far the rules are  "everything under refs,
> except a few known exceptions, is per-repo" and "everything directly
> under $GIT_DIR is per-worktree", which work fine. But if you allow to
> move per-worktree to "refs" freely, then the "known exceptions" will
> have to be updated every time a new per-worktree ref appears. It'll be
> easier to modify the first rule as "everything under refs, except some
> legacy exceptions and refs/worktree, is per-repo".

Given the substantial pain and suffering I have due to per-worktree
reflogs (and those are *just* HEAD's reflogs!), it appears to me that
per-worktree refs would be a particularly poor feature.

I agree that HEAD needs to be per-worktree, but already the fact that the
HEADs of the worktrees, along with their reflogs, are *not* visible to
all other worktrees causes substantial trouble.

In my mind, a much more natural design would have been to map
transparently each worktree's HEAD to refs/worktree/<name>/HEAD *and keep
those refs and reflogs visible across all worktrees*.

With that design, I would not have irretrievably lost reflogs to auto-gc
nor dozens of hours trying to figure out how to have *any* auto-gc succeed
again (because I need to reduce the horrible slowness incurred by too many
loose objects). My interactive rebases would also not have started to
print the auto-gc error after every friggin' pick.

Ciao,
Dscho
