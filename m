Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103DC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3061B73
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbhKRAKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:10:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:32875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233149AbhKRAKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637194028;
        bh=Nfw/uLSgE7pRyk4lbuL5df0bcv7Iu+qf5CNnFSGwZFk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FTGjvvFZlgge+sbkReQhWVqNtLVCMel7ixcOGaX/wv/ZiaK1MZyB3lt6Yl9eaVLZ3
         mKuN1CyO7wCzDoVJJsEicGDkF1/hbBFBDcPA1btyuggcXf+el4i+445orYquhU9nUw
         9U+3wOFZIzTlGW0X5M2vbobHPA5k+IiaH0Ah9SXI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1nFeD420Z4-00UH5h; Thu, 18
 Nov 2021 01:07:08 +0100
Date:   Thu, 18 Nov 2021 01:07:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Wallace, Brooke T (US 349D-Affiliate)" 
        <brooke.t.wallace@jpl.nasa.gov>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Config spec for git
In-Reply-To: <D5EE9939-F639-4E69-BD81-10B05EC43A8E@jpl.nasa.gov>
Message-ID: <nycvar.QRO.7.76.6.2111180033130.11028@tvgsbejvaqbjf.bet>
References: <D5EE9939-F639-4E69-BD81-10B05EC43A8E@jpl.nasa.gov>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P+fD+5B6fjEcLI9Oc9ZknsVvyPn++V5ptr7bPgYu1rbz+1VLFck
 zPuG9XbQsprlqOUY65IpGnGOyID+3Tb3Y8PHQAw21Ow3SiA1SVLiA+lKWnKOhTjYAeAra+k
 FDrUSiF+TtpVGKUKWG0mn77eOuUaHKZdKO2iJhFhxP0hOHkwRygvn4W3eyjMO4e11wmEawo
 +UWg7Ia01Inx9VVhNygYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:41zPWTHJGug=:JbZKUbXnbLqIzxDD7ziBGl
 HFoDBiDD2qwdkhneSWcxixmvS/+s5skESbeugvbKksDJLPTlwYAzqy1xa1Tv1iIlj5XMYHQ4V
 PlgdHZDcqpTT3m+24g4R8UqPHrMTSpEU3S6wfKcgxNpOk4PX9+mPEOm0aMjeDZ8hSc1asgBaM
 2SQ00LXlKwSHZRO8LnKPOfuCsqslNOPqmwc+OSA3+avdSPfZ/eZNSxqtIna9MrSF7bQM5/U+A
 8oz0lKMS3sxVj7RizPpIYX511u8bO1MuguzN1akyT+soaSBI9FVFNh4Cq8netj810VRsPc9++
 Y6Yh51Jj2X9m+ohmEAtZe+/cM2j5MICMIVGF/pNuUBDLJ0Pwg4/HaXDEUoXHUXVZFcS0p6+Wt
 YbkcaZEKfRVtfzbi93ZTKpzLZvhJRjzdoka7Kny3koUrz8VfeeDKEQhwVxStGjOmTovYtA5AI
 jbaEqTk4sOLkkllYQqP337rKYAKEhIVQ03qmORn7snaw3Ef1Ol8OWA7Y6Al/A6aON9vbYl4st
 TJNI2YxeViUp8F7tGUe41Pmso44spMHXxxGrzcECGLPawJ7ZgjuVCgDVTneqBRA2A07P94CAF
 hvzM7L8zLlkgMvIN8YeiQ8Bsugzvlj6v5ZzxGOmNGWLB95wxszaTgD1obVSxOlUGmwErJT0qQ
 8dzvt/2vnGxLH9aEWjeS2Lgo3lw5toxC5qlCPL+NxoOsM+2xn3bE83sKohMt52w7xu4GYTbMx
 L19GOgu+Q0El1VJ4Ou0fNCFgu7oKZN0Z2t4oWs8LoZbbdgADQ+gVLQehxUVmblXc9rgNlA1cT
 gd6ee/+DcaIv/3IEjuRA7t8XFvICubzDVLgAWiz0z/5FDgsXNFVmRwVX75FLrMW1m2A8o7Jxf
 XwCnXhv3XlHt7aurNCduW22brFO54BfYFO9aq2cxy6eHAa5u8wKwT5KTmojX4Qsi5lLeJ80ik
 bnSOhzvEcblnQBSYynS5Jqm7wD4dT0h8mx82N1yYlxnxvsPSZvQSQ/eVArb8u71Dw/HIAt83M
 t8/PcyvoQZX5iPrSrpVhagdwc7WnBxyI7borbaJ37yvhre5SDEypRL4FOv+zGXZIr+VfWh6e7
 +597+9Hq9QB5jg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brooke,

On Wed, 17 Nov 2021, Wallace, Brooke T (US 349D-Affiliate) wrote:

> Has any one considered adding a config spec feature to Git or does Git
> alreadt have some way to support the same features?

Since config specs are clearly not (yet) a Git feature, it would make
sense to begin the discussion with a description of the concept of config
specs, as the majority of the readers on the Git mailing list will be
unfamiliar with them.

> I've been using Git for a while now for small projects but taking on a
> new larger project I've come to realize that Git does not have config
> specs and so seems to be missing an important feature for managing large
> projects.
>
> We use configuration specs to select directories from a common code base
> (repo) and map them into different baselines to creat multiple product
> builds with different feature sets. We used this feature in VCSs such as
> Clearcase and Perforce. Ultimately this allows us to manage the repo in
> one directory structure and create product builds with a different one.
> For example the repo has multiple directories for different
> products/targets, but a baseline, the workspace, has only one target
> directory always with the same name mapped to the same location.
> Obviously the corresponding directories in the repo have different
> names.

So from what I gather after reading this, I suspect that you have a main
branch with a full tree, and you want to have a way to check out only
parts of the tree.

This concept has been brought up before, in
https://lore.kernel.org/git/pull.627.git.1588857462.gitgitgadget@gmail.com=
/:
proposing a way to define what parts of the tree should be checked out in
a sparse checkout.

However, it looks as if your config specs also allow to map the
directories in the Git revisions to different locations and maybe even
names?

Such a concept has not come up on the Git mailing list.

There _have_ been ideas floating around in Git for Windows, mainly to
allow for checking out revisions that rely on file names that are illegal
on Windows (such as file names containing backslashes, or reserved names
such as `aux.c`).

Nothing came of those ideas, though, mainly because nobody snatched up the
baton to work on a concrete patch to implement this.

I should point out, though, that the concept of a sparse checkout is
independent from the concept of mapping file/directory names in the Git
revision to different ones in the Git worktree.

> Git supports the notion of submodules, but I see no way to map a
> submodule directory to a different name, remove unwanted subdirs of a
> submodule, or map a submodule over a subdirectory of the primary repo.
> Config specs also allow you to specify a specific branch or version that
> you want to map to your workspace independent of other directories,
> branches and versions.

The idea of letting directories in the same Git worktree originate from
_different_ revisions is very, very foreign to the fundamental Git concept
of what constitutes a commit. A commit is very much a snapshot of the
entire tree. And when you make a new commit, it is again very much a
snapshot of the entire tree, based on a single parent commit.

So I doubt that you will be able to come up with a workable design to let
Git replicate this functionality.

> I suppose it may be possible to achieve the same result by treating the
> primary repo as the configspec. But I feel like there are some features
> config specs support that i do not have using submodules, but might need
> down the road.

I agree that submodules are unlikely to give you what you want.

> I can see that omitting, obscuring, or overwriting parts of a repo would
> not play well with the commit id. So I imagine there could be some real
> complications trying to add support for the notion of a flexible config
> spec.

Indeed.

The only way I can see that you can _somehow_ combine parts of multiple
revisions into one worktree is by transforming those parts into a single
commit, quite possibly by scripting the transformation.

For example, if you wanted to map, say, `Documentation/technical/` of the
tag `v2.34.0` to `tech-specs/` and `compat/poll/` of the tag `v2.30.0` to
`poll-emulation/` in a clone of https://github.com/git/git, you could use
something like this to create a new branch:

(
	GIT_INDEX_FILE=3D.tmp-index &&
	export GIT_INDEX_FILE &&
	git read-tree --prefix=3Dtech-specs/ v2.34.0:Documentation/technical &&
	git read-tree --prefix=3Dpoll-emulation/ v2.30.0:compat/poll &&
	tree=3D$(git write-tree) &&
	commit=3D$(git commit-tree $tree -p v2.34.0^0 -p v2.30.0) &&
	git branch my-generated-branch $commit
)

This would give you a full Git branch that could be checked out and has
the mapping.

You would have to play similar tricks if you wanted to transport committed
changes from that branch back to the originating commit histories.

So yes, it is _somewhat_ possible to replicate what you can do with config
specs, it is just unlikely to ever offer a good user experience.

Ciao,
Johannes
