Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9911F461
	for <e@80x24.org>; Mon,  9 Sep 2019 14:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405241AbfIIONk (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 10:13:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:39051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405208AbfIIONk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 10:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568038412;
        bh=6y3srjZK7eDZvt1E/VrcgCHzt3Yh0S+tjICh5xYRxeA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fZXVdIwfYC/Ag1XNuEK++HR6qJY720tPgFMWz3R4y2rDqaR+mmDPOXPz5h2diMtFa
         KFKxYLlESt7FaamIbJwACMKV3Hcbugy5vYO7qIdR03QICiY+33vUi/rCLEHjrKnfnj
         r/Hcm7HtR5iYQo+MaPBSKqhgTaqn7+MVmYxqMhC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M09BU-1iQ5Fw2Dm8-00uIce; Mon, 09
 Sep 2019 16:13:32 +0200
Date:   Mon, 9 Sep 2019 16:13:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Warren He <pickydaemon@gmail.com>, git@vger.kernel.org,
        wh109@yahoo.com
Subject: Re: [PATCH v2] rebase: introduce --update-branches option
In-Reply-To: <31a37eb1-8a75-40f7-7d1c-a8b7b9d75f92@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909091605540.5377@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet> <20190907234413.1591-1-wh109@yahoo.com> <31a37eb1-8a75-40f7-7d1c-a8b7b9d75f92@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EhleZp/9ZDDBrihROX8u8U5ESjt2ZW8ujBJv2QH5Wrzulp+i9+j
 hKPDkHCMhxadLrtYVZokYy/Ri2nPhuS2Ohszf5FNVzrQM6WGTMBZENcYv8q9VSW1u4AQh0K
 czotUb02TaRjnoetEc6L2gO58YAvgCvIMi5z1OWBGGknfEG64Ld1hREBW7jIp09kK4Abgo0
 hSukQpuHinIeI0vYY0TsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MUyZOIz5hyY=:kHtA5WTrcLMherGxVLRIJL
 KSv5QzKhkLImrshuCmyQj5qlA73sIiZjz8erYYIE4adgmTkRl1j5swxNJuytMRZySJZP2TRkU
 U1CnPO8m5gyhl5zK4pIpTxYtWJSpLPCEudk5aUatxmdTWCakG3gC5uastzKg6KWGvr/6/Y2fy
 u9Msomp6Vf4WDTG398Ks5ogerHEaWEvGEQzHEclrJeu1N7eKzOsoUXfKPh7Y7n9hiUPZT+df9
 KOHhL5DUZ4HlcXSrYyLwHYPxzeqbnK6+R8nyvBoKNKV3A12Zuff75z3NQvrjlF3lVKXH+hsLx
 cIRxg7sOWAYlLWutZM1Kg4QlFl4uCCfd6thxrX89Ylj2K/4sxhc/efnXlYfcbvKgi5ArF7ouY
 QDWGM8JfMuTK3F6GlewbDatu53lGvhBQW3FMgN8nfhT4j/nqw2iLWcWXLZ30xhaiQLRWPE9uC
 6gCdSF0ew5dsi9+n5W5iOmgTWAwfRAipRsF3zXtnVu95WWWhOTjkERQ7RitAWUuw1NXG63spu
 z1WbIlD263gDGwdb7DprHRx1MFU/7n5KF9PUmWEPYYNtE/ctLwnTeHTmVqN/4A/CJ4jQ2jLuJ
 2fjREDQUw+jp6Mzxg0PsyMWlgvmzfAGBopIFpt+Z1ox2EcrRcYc7j/aZs6SAS2n3aSG+SkK6N
 iOnbPm1mx57LB8MMtdsnf/Xu8ecoCln2+oHB8b02wVt8KRISSmm6amaCpcIXOCLmFvo8o8xY3
 2c8+c6QqjN5MFNE0RA0FmA93IdmzSMR8b6QHFIIj2W08vglUP6WC3xwIti8t7ajC7/ovA82aG
 YA22r6XmLQy+qgYEnWw+GENgvCTsGEMmgNncU9NsUrNEtfXxjV4gr2fk0tVnd95leUWqrSn3c
 LwiLYzxNbm8YaRpZlD4Z1ZM5yC5OBmdO+OKmBKEp4wsJ6Ciiekvm18UWNQPak7GLabL5R/cOQ
 m9laU862cCT4p/uATxnXF+V7zvEEnbuGmsWCjwIUivrkwy5TH8IOfXpbel7X/qhO87GQx5ypA
 2xSgMuOMOk4SGSpLsPVV+FwlAF2Jik4IDc60FR0wL2u18hqMwgGwTWgDL3Q0fVAB91QLtym/s
 pq59pezL6L9/QDyzz2DnxlmsSXqshT2R47KeRYUWJzDqdYcHos2c9ED/HSSbTZLJv9RBWWkSn
 P5s40fBA52IabraZMHYLskLfjrwIcBM2D8DZHlkWCBXU1tNWqvmtCVpwa2EoaD5bOsU9E9s+A
 D0H2nICKfjxpD9F0o
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 9 Sep 2019, Phillip Wood wrote:

> On 08/09/2019 00:44, Warren He wrote:
> > Everyone in this thread, thanks for your support and encouragement.
> > [...]
> > > It should not really imply `--interactive`, but `--rebase-merges`.
> >
> > `imply_interactive` doesn't fully switch on `--interactive`, i.e., cau=
sing
> > the
> > editor to open. It only selects the backend, which I think we're sayin=
g is
> > the
> > right thing. I've dropped the `-i` from the test description.
> >
> > And we don't really have to imply --rebase-merges, in case someone wou=
ld
> > prefer
> > to linearize things, which who knows? Running that non-rebase-merges c=
ommand
> > in
> > the example scenario from my original post should give something like =
this:
>
> I think it would probably be less confusing to default to preserving mer=
ges

s/preserving/rebasing/?

> and having an option to turn that off - people are going to be surprised=
 if
> their history is linearized.

I don't think it makes any sense to linearize the history while updating
branches, as the commits will be all jumbled up. Imagine this history:

	- A - B - C - D -
	    \       /
	      E - F

Typically, it does not elicit any "bug" reports, but this can easily be
linearized to

	- A' - B' - E' - C' - F' -

In my mind, it makes no sense to update any local branches that pointed
to C and F to point to C' and F', respectively.

> [...]
> > * * *
> >
> > And then there's the discussion about using `exec git branch -f`. To
> > summarize
> > the issues collected from the entire thread:
> >
> > 1. the changes aren't atomically applied at the end of the rebase
> > 2. it fails when the branch is checked out in a worktree
> > 3. it clobbers the branch if anything else updates it during the rebas=
e
> > 4. the way we prepare the unprefixed branch doesn't work right some ex=
otic
> > cases
> > 5. the reflog message it leaves is uninformative
> >
> > For #4, I think we've lucked out actually. The `load_ref_decorations`
> > routine we
> > use determines that a ref is `DECORATION_REF_LOCAL` under the conditio=
n
> > `starts_with(refname, "refs/heads/")` (log-tree.c:114, add_ref_decorat=
ion),
> > so
> > `prettify_refname` will find the prefix and skip it. But that's an inv=
ariant
> > maintained by two pieces of code pretty far away from each other.
> >
> > For #5, for the convenience of readers, the reflog entry it leaves loo=
ks
> > like this:
> >
> > ```
> > 00873f2 feat-e@{0}: branch: Reset to HEAD
> > ```
> >
> > Not great.
> >
> > I haven't made any changes to this yet, but I've thought about what I =
want.
> > My
> > favorite so far is to add a new todo command that just does everything
> > right. It
> > would make a temparary ref `refs/rewritten-heads/xxx` (or something), =
and
> > update
> > `refs/heads/xxx` at the end.
>
> I think that's the best way to do it. If we had a command like 'branch
> <branch-name>' that creates a ref to remember the current HEAD and saves=
 the
> current branch head. Then at the end rebase can update the branches to p=
oint
> to the saved commits if the branch is unchanged. If the rebase is aborte=
d then
> we don't end up with some branches updated and others not.

I'd avoid cluttering the space with more commands. For `branch`, for
example, the natural short command would be `b`, but that already means
`break`.

In contrast, I would think that

	label --update-branch my-side-track

would make for a nicer read than

	label my-side-track
	branch my-side-track

Of course, it would be a lot harder to bring back the safety of `git
update-ref`'s `<old-revision>` safe-guard, in either forms.

And of course, the first form would _require_ the logic to be moved to
`make_script_with_merges()` because we could not otherwise guarantee
that the labels corresponding to local branch names aren't already in
use, for different commits.

> Side Note
>   I'd avoid creating another worktree local ref refs/rewritten-heads/.
>   Either store them under refs/rewritten/ or refs/worktree/

Yep.

Ciao,
Dscho
