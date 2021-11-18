Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E4C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9513761A64
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhKRNyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:54:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:48495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231587AbhKRNyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 08:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637243463;
        bh=zin1pJeKDF0lluqVMEaLiT1Ui6iqp8L+lGjz5it/d48=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KztLFH/zscxF9Z1ZdcVOIw5cjvQeMYFt1FWYuLUEtJht5uyR7mVqismIjrcwn3h5O
         vPogjCidIn88tSyQ47sT1uBPsPZN1gAwwqSYMZNuedY0K4kS6sZB3kzm5kgVgrPnCs
         t2u6DEGXj0Gl/yfgDJ24QV8MEwgLOnaoo0Rfdiv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1mK9u70RUC-00pvDe; Thu, 18
 Nov 2021 14:51:03 +0100
Date:   Thu, 18 Nov 2021 14:51:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 01/17] scalar: add a README with a roadmap
In-Reply-To: <f674b1fe-87d4-2598-874c-7c3984d0ee92@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111181433010.11028@tvgsbejvaqbjf.bet>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com> <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com> <3aa095dc824ea7f659e6c11aa2c21be6cadbe985.1637158762.git.gitgitgadget@gmail.com> <f674b1fe-87d4-2598-874c-7c3984d0ee92@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QAcNsvTMJwjBoHVLduZexGPrE70PAX0GoTbTcboGgW5N7BZpCUJ
 2Xuwh2esLGP0J+1a3+UQA58GpNKeRoUSo9oSgCMN8mQ50QnLTfmRQP5S/72pK3vWUJwhfg9
 IOyD1AFcMtmZSUjqKVw9bxhKHeawGGWjD/0xE4vC2e48eYuRJrXfnu3+750g+Weve7VH5iz
 StN7HKBmynmKThK3eXcaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vSkm+aJYtFg=:mzzthpnVBi/DRgOt3fl1ta
 tqkC8Glu2yGBy2O8iiOOpXk09RdUhXrBmFFQE1zxqy1EZJmAV1om4lM9lqUnOxWBf6Bf3zNMt
 fPP3GaTKA7L2H5v6OTUJmzXjBYnz9JNTV71dGAVkrqTLBJASEZMvsC1dvOJ2Yy+YbGOSwEf9V
 oT6K/snF2amtPgJqkZgNM22OCC+dPx+gumktNvL6f7rHkh3jTLab4B/xoCsLZqSyHmbefaJwl
 xOzwHKDkeWEqDBPkNqJICp41lQHBfLjxNeO241qf/p88IU/JJGed8xI+6s1UjgV56hC12G4ga
 Dch4OAvT8iw2WcJ/cdOk6JPwg8jqym0SNTGQc/NDKwM2UlGukV3XfqOVC/eBCVxPVWeP9XyeF
 gjmlpB23/MK1aLg51XXj92zeUYrTI64EW3J2RMs7z8HbqE9RcWvImg5YVS1sN/FEFI82zALnC
 1Au00C5LtfCSUtOFYipuCGxehy1H9kKIHr3zXNRTqYiZbYeJRAp/WDvggvEzn0QG/30qNlgrU
 lVTcw0tcVmQFQOxRIOiLR9I6Ui9RwAxcpyxSFl/KV3iQnYHdb7EIXH6jHzI4Etq3mepouWHV9
 WMoSYt679F65Rr8E0ekoLlVM3T5tr0rfiF4qexzOqD3rQ9ZcqKONUr6TUM7J0aj4rts3bPBD5
 /zA5UoD3T1/WL6H4dFdMh0OtHEMuKSrtTicxSS3+A1GWPFHZnILUsWjTyZMFZK5SSREUKMoT6
 RWvVGhn+7fkMsoteUCMa+ZqOcX6oEIwk8X6WBgh0wgCyYNf2Ag4Xl+zy/5GGQLvttG1YAxLL3
 M1v+kXQoJYDYz4IuqsYRcfYjqfxg48ziUwHbs2NzgUgNWaFMWtHLYVhvvpSeNLYqslXofjbZL
 iFxgcNGPHYOSMv0D/Eja9RwB+YrpiC+g/2meowBkpdtuqqB8o9tNb0BI6x6LLYW/0AdBUgVMk
 G96r8iOQ/XEibHmWAMsrPRrLcPhHOyuw1j7Ai1Fb/4MIxnSqUGX7YvL8hC3pX+x3b8HxmK9hv
 gNvOvGWU8sshtKx9p9v9qcFnmOukVhkDsPtDCB3S4uAbYZH057bvjrtyhPKGRjoWeIbR9e3iD
 8NOARD7KrLYtL8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 17 Nov 2021, Derrick Stolee wrote:

> On 11/17/2021 9:19 AM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The Scalar command will be contributed incrementally, over a bunch of
> > patch series. Let's document what Scalar is about, and then describe t=
he
> > patch series that are planned.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/scalar/README.md | 71 +++++++++++++++++++++++++++++++++++++++=
+
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 contrib/scalar/README.md
> >
> > diff --git a/contrib/scalar/README.md b/contrib/scalar/README.md
> > new file mode 100644
> > index 00000000000..7898a683ba5
> > --- /dev/null
> > +++ b/contrib/scalar/README.md
> > @@ -0,0 +1,71 @@
> > +# Scalar - an opinionated repository management tool
> > +
> > +Scalar is an add-on to Git, helping Git scale to very large repositor=
ies and
> > +worktrees.
>
> I would rephrase this as "Scalar is an add-on to Git that helps users ta=
ke
> advantage of advanced performance features in Git."

Good idea!

> Git scales just fine, only it helps to enable some features that are off
> by default.
>
> > Originally implemented in C# using .NET Core, based on the learnings
> > +from the VFS for Git project, most of the techniques developed by the=
 Scalar
> > +project have been integrated into core Git already:
> > +
> > +* partial clone,
> > +* commit graphs,
> > +* multi-pack index,
> > +* sparse checkout (cone mode),
> > +* scheduled background maintenance,
> > +* etc
> > +
> > +This directory contains the remaining parts of Scalar that are not (y=
et) in
> > +core Git.
> > +
> > +## Roadmap
> > +
> > +The idea is to populate this directory via incremental patch series a=
nd
> > +eventually move to a top-level directory next to `gitk-git/` and to `=
git-gui/`. The
> > +current plan involves the following patch series:
> > +
> > +- `scalar-the-beginning`: The initial patch series which sets up
> > +  `contrib/scalar/` and populates it with a minimal `scalar` command =
that
> > +  demonstrates the fundamental ideas.
> > +
> > +- `scalar-c-and-C`: The `scalar` command learns about two options tha=
t can be
> > +  specified before the command, `-c <key>=3D<value>` and `-C <directo=
ry>`.
> > +
> > +- `scalar-diagnose`: The `scalar` command is taught the `diagnose` su=
bcommand.
> > +
> > +- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled i=
n `scalar
> > +  init` and in `scalar clone`, for an enormous performance boost when=
 working
> > +  in large worktrees. This patch series necessarily depends on Jeff H=
ostetler's
> > +  FSMonitor patch series to be integrated into Git.
>
> You say 'scalar init' but do you mean 'scalar register'?

D'oh. Yes, I meant `scalar register`. I was thinking of `git init` too
much when I wrote that.

> > +- `scalar-gentler-config-locking`: Scalar enlistments are registered =
in the
> > +  user's Git config. This usually does not represent any problem beca=
use it is
> > +  rare for a user to register an enlistment. However, in Scalar's fun=
ctional
> > +  tests, Scalar enlistments are created galore, and in parallel, whic=
h can lead
> > +  to lock contention. This patch series works around that problem by =
re-trying
> > +  to lock the config file in a gentle fashion.
> > +
> > +- `scalar-extra-docs`: Add some extensive documentation that has been=
 written
> > +  in the original Scalar project (all subject to discussion, of cours=
e).
> > +
> > +- `optionally-install-scalar`: Now that Scalar is feature (and docume=
ntation)
> > +  complete and is verified in CI builds, let's offer to install it.
> > +
> > +- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move =
it next to
> > +  `gitk-git/` and to `git-gui/`, making it a top-level command.
>
> This final one is where we can make the final call about where Scalar sh=
ould
> exist in the tree and how optional it should be. This would also move th=
e
> Scalar man pages into Documentation/, along with possibly the docs from
> 'scalar-extra-docs', and the tests into t/. The benefit of leaving this =
until
> the end is that we can see the entirety of Scalar before making a final =
call.

Yes.

It allows the current patch series to focus on the core functionality of
Scalar. The `move-scalar-to-toplevel` patch series will present an
excellent opportunity to discuss the merits and complications of accepting
Scalar as a top-level command into Git, without having to delay the
current patch series any further.

> > +The following two patch series exist, but there is no plan to integra=
te them
> > +into Git's source tree:
> > +
> > +- `scalar-with-gvfs`: The primary purpose of this patch series is to =
support
> > +  existing Scalar users whose repositories are hosted in Azure Repos =
(which
> > +  does not support Git's partial clones, but supports its predecessor=
, the GVFS
> > +  protocol, which is used by Scalar to emulate the partial clone).
> > +
> > +  Since the GVFS protocol will never be supported by core Git, this p=
atch
> > +  series will remain in Microsoft's fork of Git.
> > +
> > +- `run-scalar-functional-tests`: The Scalar project developed a quite
> > +  comprehensive set of integration tests (or, "Functional Tests"). Th=
ey are the
> > +  sole remaining part of the original C#-based Scalar project, and th=
is patch
> > +  adds a GitHub workflow that runs them all.
> > +
> > +  Since the tests partially depend on features that are only provided=
 in the
> > +  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
>
> These topics (in some form or another) exist on microsoft/git and are av=
ailable
> via GPL, so we don't intend to say "we are withholding these patches" bu=
t instead
> are saying "We don't think the Git community is interested in these patc=
hes."
> There are some interesting ideas there, but the implementation is too sp=
ecific to
> Azure Repos to be of much help in general. These still exist mainly beca=
use the
> GVFS protocol is what Azure Repos has instead of partial clone. We are f=
ocused
> instead on improving partial clone.

Good point. What I wrote does not fully reflect that. I have changed it.

Do you see anything in the remainder of the patch series that still needs
to be improved?

Thanks,
Dscho
