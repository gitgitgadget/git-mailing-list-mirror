Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845CE1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 17:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965974AbeAJRFx (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 12:05:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:55840 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965898AbeAJRFw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 12:05:52 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lmp-1enQeN0m4d-00zWm2; Wed, 10
 Jan 2018 18:05:28 +0100
Date:   Wed, 10 Jan 2018 18:05:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
In-Reply-To: <CAGZ79kYdgD2h7QjjJe0aA4eMATCGkH62XYvziUNvAPsBJDXOCA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801101756140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180107181459.222909-1-dstolee@microsoft.com> <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com> <20180108102029.GA21232@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180109065018.GA32257@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAGZ79kYdgD2h7QjjJe0aA4eMATCGkH62XYvziUNvAPsBJDXOCA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5ucSq+pefCB2PO0gDQiFpaPCl9LzipKoTFTGTS6PTK3/2mjHZgI
 R4WVT1wCGoddyG7pL41WrJqt5OQGzakSvVIuEe86dXBwKK4KF4r2RftSYCUV6rLzxcUcIoT
 mZt8FLzSitnu3b5DNJZIM+1N7/w3rHuCmwo/qMXDLvuFTdDbKuKjFwfe9V3dEQokCAOuhz0
 3vCKr/FIOFkA9pF1De4eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ICJOrFLhlGs=:Kfm00Y20TnZsAAUJwLwz7w
 Ap1Umbthg+jetsx66dzTH6HMsiwQnrHqC8NdkDeyFwfvs8XHzY26THDOhAAwDBf3E5iqoebLp
 9uJxhJyJ7DbZaq8SAbiWlx0mAUrO4WyjUwnQqalFHq8oKs8+NEqsm48xDpzBLwKArpTwjaVEM
 XH+OobcUnshT/CMTdAHh8vNIQwN8+s54fDEm8/0llSIqYSdhVYCkqcPqO7CWtpMdj/CsiIHqx
 exHOT4kT9VO1xI6vyHtSm05NZ8BSRY7TfY78a3avdxSFC6eb8bkAaZNKBuOgoGseTe5XAHRDL
 VD93Z6saN+y8O4bEkNc3y0jAq6yyWW1OH0xtDnSp1RJRZBcDwiexHpLbBZIcQ7raegA6G19cO
 xuTLAvlO7Dtv4v0kwau5BzofbFcdLEznlKwFAHtUFYeSmXfHObSgVgV7ETkkQPQjBCb+6Mdz+
 o/hZmJN1DnGTZ90sqn1AJuFXXc9geIlcnNaKuoNsgigKrrK5cS1hniGM4qB20NVue2uanakri
 xP0NKyGfOtmvx3tlGao9Iv5c48bo2JcgjVQmWzADhhLMJlGmW9tQoR33bHa2z5qIDRhh2B5J9
 tie4FBGzL5FdZYfbVr9LVDr2GLsgHwnTwtBYnJCxlW06g5/XIRVrvfa4XjTpmipMdz7w+uhLr
 SkRiGcd4nqZJPDYpGPCHygbZQgrhAZ0qvjfdKiFf2dK1iTyArDaW4eGm0ThpYgiqU3NljZ5bH
 +WpjH5GO7yai7+Nf0uhPibq/14gVYp5sWl3FIJwPAi4NfUunqmVf9zZYJJNtkhrdiaWKOuxvB
 MG/1rd3TKZmLXXn0ivuFk9BrRkCoF5/ZKh1EYjrWs6xOnjO4zo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 9 Jan 2018, Stefan Beller wrote:

> On Tue, Jan 9, 2018 at 5:05 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Just to throw this out there: --abbrev=8! would be one possible
> > convention to state "I want exactly 8 hex digits, don't bother
> > checking for uniqueness".
> >
> > Not sure how urgent such a feature is.
> 
> You seem to have spent some time on rebase, including lamenting on the
> in-expressiveness of the instruction sheet (c.f. "rebase a mergy history
> sucks")

Let's call it "todo list" again?

And yes, I spend a *lot* of time in rebase. It's part of my duties as Git
for Windows maintainer.

> And in that light, I'd like to propose a new naming scheme:
> 
> (a) assume that we "tag" HEAD at the start of the rebase
> (b) any abbreviation must be given as committish anchored to said ref:
> 
> pick REBASE_HEAD~1 commit subject
> pick REBASE_HEAD~2 distak the gostim
> pick REBASE_HEAD~3 Document foo
> pick REBASE_HEAD~4 Testing the star-gazer

I do not necessarily agree that this is better because it is valid only
locally, only in the current rebase (and you enter new problems because
you implicitly require REBASE_HEAD to be worktree-local lest you prevent
simultaneous rebases in related worktrees).

That prevents you from, say, chatting to your colleague and mentioning
that commit that you are uncertain about. Imagine asking "Hey Todd, do you
know what REBASE_HEAD~2 is all about?". Granted, if you ask about
"deadbeef" and it just so happens that this shortened name is ambiguous in
Todd's repository. But that is pretty unlikely, isn't it?

> And as we have the full descriptiveness of the committishs there, each
> commit can be described in a unique way using the graph relationship.  I
> am just throwing the name REBASE_HEAD out there to trigger some
> associations ("similar to FETCH_HEAD"), but I dislike the name.

Not only that. It would also be confusing to read after reordering...

> (c) this would not solve the problem of mergy history, yet. For that
> we'd need to introduce more keywords, that allow us to move around in
> the DAG, [...]

You probably missed my hint that I have a working solution for that.
Please have a look at

	https://github.com/git/git/pull/447

Short version: for a commit topology like this:

	A - B - C
	  \   /
	    D

the generated list would look like this:

	# branch D
	pick 0123 A
	label branch-point
	pick 1234 D
	label D

	reset branch-point
	pick 2345 B
	merge 3456 D C

Ciao,
Dscho
