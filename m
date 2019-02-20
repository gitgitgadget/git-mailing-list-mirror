Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884381F453
	for <e@80x24.org>; Wed, 20 Feb 2019 21:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBTVBu (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 16:01:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:51095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTVBu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 16:01:50 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFcg9-1gqqUP2hAj-00EcXs; Wed, 20
 Feb 2019 22:01:44 +0100
Date:   Wed, 20 Feb 2019 22:01:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
In-Reply-To: <xmqqbm371rdn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902202201061.41@tvgsbejvaqbjf.bet>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com> <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com> <20190208113059.GV10587@szeder.dev> <20190210221712.GA9241@hank.intra.tgummerer.com>
 <20190211011306.GA31807@szeder.dev> <20190212231837.GI6085@hank.intra.tgummerer.com> <20190219002336.GN1622@szeder.dev> <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <xmqqbm371rdn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Stv8orsNu+7yegyags6Kc+9knV+iPw45mfqKHjxU6ByALkUkX5L
 Sk7WttRiPQ8HgZjLFI1Uae02UuWJnjxm4UMAw3/PTmhA8UKkoD7+djGor+Hz5eswNrCp/jo
 ma1gvavpyGxuL+LZoyBecLN49L/XNA+6TRJwmkoHx52t8xAS8mGiJrW/Nh5Fo5ZWvA6psMG
 q5iWAV3jfnHoESEWz/AYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n5UNDosTunc=:Ysbw6LNoN5KbWMOU9TGGQa
 oNJYkPBt0sy1cEPXNwgHc7bPePPzqll2In5ZtnqrsuJh2dJ4FPFvamxuE70dXGeC8I5V048LI
 u6LkZX+axcWmib6S4R6TKIBqHQtvEhIsN8SskxNme5Cvgwp2siLBOrbJobHjBEpu3VizNMupo
 tbePG8le7R/Np7iDiI311Z2o1eCQ+8o7U3PC87QIGgtKdtfBMziVBwDj5+cxmdVJFhoUqVuuV
 Uz+izgOUqDoKDvVUMR0hVF5QzIsqDAzOXytSEUo6ka5r5+w1TzP1zJC4C/X2/kLJOj2B9djJq
 hewmMfdB9OegoS4r0rFN9isPRTm2qEN5+vSmGuNxL+IX9OOWLkcdZUbML9JXYDTXgPda2jigv
 NwQF6svls6udNlV6BjZJ5bSU/2LaYFCblmW9n56LxbIsZkou+SesqmmwmEVZlFcKEPFtx3gve
 DXhIPXnXq6NUh2diu/sw27Gsyx0+ZnvFzfUYN2gik0/8PI7tXPo1mrdc9zhTLJPbiRj4ClL7M
 DxJzLAOrgrxdj3brFLkWqCcNJ5tMYoImph7229pOP9SPJPiJnqu+TGKPLXB5DMViEk/mueCVj
 3ceW13wSLp/CgQscKEYYjtEoIM5iBn/lnCvUwZqDvBdpMVwTXwOICbX2qyVpxxtK6qSTO0bwl
 WBJujaKImUsfdYNkPAc44T8E8Yb+U4BJzovVqIWfmjKlrublpXT0UJ7kLT8BTm4REkzAPvkuJ
 nxNHpNdvWisC6NeNrpaNn7bV/PIoz88EEiZIae7ClnwZg+qFqho8icLQhDOtXHdhSvV5IYFWT
 UneQdHm8yQADDLY1PXNt4qezzKo92JV4nqdZKSKo+enx+AE+cHT7l0YDETwgkXBGxKXJ9YAwW
 GVIRsZOjdKTnowOHc7csYLjQUr0BYHaOCn7HqxddEbsAw+iuWZ0181T+mtDZhTqdahwDONXts
 IkYHJSYdIEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 19 Feb 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> >> > index c77f62c895..3dab488bd6 100644
> >> > --- a/builtin/stash--helper.c
> >> > +++ b/builtin/stash--helper.c
> >> > @@ -231,6 +231,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
> >> >  	struct tree *tree;
> >> >  	struct lock_file lock_file = LOCK_INIT;
> >> >  
> >> > +	discard_cache();
> >> >  	read_cache_preload(NULL);
> >> >  	if (refresh_cache(REFRESH_QUIET))
> >> >  		return -1;
> >> > 
> >
> > So this is working, but it is not the correct spot for that
> > `discard_cache()`, as it forces unnecessary cycles on code paths calling
> > `reset_tree()` (which corresponds to `git read-tree`, admittedly a bit
> > confusing) with a fully up to date index.
> >
> > The real fix, I believe, is this:
> >
> > -- snip --
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 2d6dfce883..516dee0fa4 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -1372,6 +1372,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
> >  			}
> >  		} else {
> >  			struct child_process cp = CHILD_PROCESS_INIT;
> > +			discard_cache();
> >  			cp.git_cmd = 1;
> >  			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
> >  					 NULL);
> > -- snap --
> >
> > And the reason this is needed: we spawn a `git reset --hard` here, which
> > will change the index, but outside of the current process. So the
> > in-process copy is stale. And when the index' mtime does not help us
> > detect that, we run into that test breakage.
> 
> In non-patch mode with pathspec, there is an invocation of "apply
> --index -R" of a patch that takes the contents of the HEAD to what
> is in the index, updating the on-disk index and making our in-core
> copy stale.  Wouldn't we need to do the same?  Otherwise, the same
> "reset_tree()" you are tryhing to protect with this discard_cache()
> will call read_cache_preload(), no?
> 
> Among the calls to reset_tree() in this file, I think the one that
> follows the "reset --hard" (your fix above) and "apply --index -R"
> (the other side of the same if/else) is the only one that wants to
> read from the result of an external command we just spawned from the
> on-disk index, so perhaps moving discard_cache() to just before that
> call may be a better fix.

Good catch!
Dscho
