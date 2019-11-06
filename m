Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207041F454
	for <e@80x24.org>; Wed,  6 Nov 2019 22:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKFWQV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 17:16:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:47021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfKFWQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 17:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573078560;
        bh=72qiCgxJllyHjxnKxqBF3VHnoX2Bo5eIF7V4++gkj/Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NiqhNVV82gIU4+WoHe/Vs4SKyFvdZMgimbt7eaEaUbDVEzJaGiZbgZbPYedvRxMpW
         O6JtNvwlBJ/DQO+w1JwlnbpjpWx+IyrSQqT/XBP0lVjqr72lpdjRdTjUcYONjzwqlU
         9zwQeeyqqlZoN7CpiVcNIh/wIINwM7VoUoX1Eyx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1ieL9h0vgT-00CV92; Wed, 06
 Nov 2019 23:16:00 +0100
Date:   Wed, 6 Nov 2019 23:15:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: Forbid to create local branches with confusing
 names
In-Reply-To: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
Message-ID: <nycvar.QRO.7.76.6.1911062101580.46@tvgsbejvaqbjf.bet>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yhbzgwmTh9Nvy8jcXk/j5sGP46f2hCLKBiQZKpwohTecHxuNCmX
 3O+xeNBIxV6naU4a1SrydDPynNVaNd9rBkXGt5YE0RrlPfL48R918QKjOgpxOYgj/7tYNnr
 AFMVnb7IDxALZDRdzYowjibeMLZ5L1zh4QoaiqL7JDyHhbszpcghmRPqFskBJLXsh5QeZzc
 AbtoFxfMfXvxLHKv2sTGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yNF4ZC5p8Hc=:lEYACAjseBb8mZZtIVgk+h
 wyIK34JhV+/Sp55YxyLifEW3mL9BMRkKNoIyK5pXMBIQs1BEOSMvZZ+yxR8qtmxmhuS1gMhjI
 eWyQket5HGGTwS2Ly1sHbp0dlV2XK+IKvDXRXT8X/o2fh0SQxfmL6FHyadwsl0v2KIn0B6b8j
 ECR4t9lvaFuA2tIgVR3slDLU6Gkw34rBf9uzURgGys3EubA273IKQJM0Bz8h0OSrBpKmO3DBR
 EEK4ldOsGiscuuUuZXZvanV16uNyTosZinrER5JNiCSvlgkkHVGz/JpUXfzjWn0q4YoYZS0sV
 RxLFnoSXIYe4MXLKsytNZmWeHLdgA6DJrdvacD8Qc9/2+pWLPzdnuNXHoWQZgU3Iv+yoMFdzx
 5fn1nlCVCP4ox9JXkFF1cv71m139l2Vf4ohqcY++GKhi+2q22zXguNKeHyHk0LhmZ1iaHn4yh
 oD6/JwA1rBk8pYu6PI+BSjn7BXpzv5vq1A4txeSBswmhC10s/+Oo2qGeqYmr+F+2zMjiqJbhh
 iy5KGDVG9KrT/v2z73p0gxorr05lg19nCa9IRKMeE9YCGkS0wzyB9ea6mABvIixocwiB4MarO
 5VQ2EuwehnwBXfPKl0mc1BHmsufuCC/a0UJmEuxQAhIJ/tPLijmWsLufdnlVRiyf18SMsn2c5
 bGaaQH9n1jdOK8h3sJerO0Q7Ph/WaL681nRoCb8jx9urd3/YikTtbBn/ZUr6znNGgk1k22i9Q
 HUJ229XZFaeaXJmd9/jOdFdSWgOf3JMGiMfWeMoN2cVb4W37p0kpXrkKbkGzTrcICdQaO1NHx
 7Dceh08mni+0v69J/4/JYXJfSvx16OAONA9KYajPEU/ZgL0BvWUV2jGympWXdy+wUr/d2U6Tp
 Prd9Ax7x/HGqR7eeNv08woRHu1d0jr3829M55CEKfdvJ7HXiPKTSIoCEvG6uTEDS9klDkW8u8
 aOvqYl5d/oS0MuLgiWTrW+zCkkTs95ShJaLo1yYpNop5o84/sF7G9VxEEUdJ9aIlE1ENcW26R
 H7TDndyC/xrukRVDKPD5dPCqZ56+k3AGREFtXa6DjqzXUffWqg8/gvZ7tRfcFbLj2luZAMY3u
 R4hcY4ewMdno3NHTSIpYR5AdFXVYVG8QKV29I0e1KVDY2MV7mvgFeVDNWiQZk9/s2xACBULoZ
 eTboFMzO5IcZVDOxiaLtXEiZl3eptP9nhL0XZs+071aKRMGCecsJeoMLeNEKkR+3ugu1y14CG
 73SyGRoQ9E2bA08W13D/ZUWecCLwg2SCyzLCs4tyG7qTAZyzEF/OIwod3FiU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ingo,

On Wed, 6 Nov 2019, Ingo Rohloff wrote:

> Without this patch, git allows to do something like this:

Maybe start the patch with a description of the problem it tries to
solve? In other words, I would have appreciated a first paragraph that
starts with "Many Git users ...".

>   git branch remotes/origin/master
>   git branch refs/remotes/origin/master
>   git branch heads/master
>   git branch tags/v3.4
> All of these local branch names lead to severe confusion,
> not only for a user but also for git itself.
>
> This patch forbids to create local branches, with names which start
> with any of
>
>   refs/
>   heads/
>   remotes/
>   tags/
>
> With this patch, you might still create these kind of local branches,
> but now you have to additionally specify the '-f' option.
>
> Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
> ---
>  branch.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
>  This patch refers way back to the discussion from 2014:
>    From: Josef Wolf
>    To: git@vger.kernel.org
>    Subject: error: src refspec refs/heads/master matches more than one.
>    Date: Fri, 14 Feb 2014 12:31:36 +0100
>  See for example here:
>    https://public-inbox.org/git/20140214113136.GA17817@raven.inka.de/
>
>  The origin of the problem is, that git has (almost) no constraints
>  what kind of names are allowed for local branches.
>  There nowadays is a constraint that you are NOT allowed to create
>  a branch which is called HEAD. See commit 16169285f1e6 ("Merge
>  branch 'jc/branch-name-sanity'", 2017-11-28).
>
>  In the old mail thread a lot of potential constraints for local
>  branch names were discussed; in particular a lot of strategies
>  were discussed what kind of local branch names might be a problem
>  (the gist is: avoid ambiguities, by finding out which names
>  lead to ambiguities NOW).
>
>  I personally think it makes more sense to forbid a much
>  bigger class of confusing branch names.
>  In particular I think all local branch names starting with
>    refs/
>    heads/
>    remotes/
>    tags/
>  should be forbidden (per default, can still be forced).
>  This also avoids trouble for an unforseeable future.
>  Example:
>    git branch remotes/blub/master
>  This might not be a problem now, because you have no
>  remote called "blub" right now.
>  But if you later use
>    git remote add blub <URL>
>    git fetch blub
>  you very likely run into trouble.
>
>  The above approach still allows you to create local branches
>  with a name of the form
>     <remote name>/<something ...>
>  but I cannot see how this might be avoided; remotes might
>  be added later so what would you do in the case that a local
>  branch already existed named like the remote or a remote
>  tracking branch.
>
>  With the proposed constraints you are at least are able to use
>     heads/<remote name>/<something ...>
>     remotes/<remote name>/<something ...>
>  to differentiate between the two.
>
>  This really is an issue; people seem to stumble over it
>  and I guess this is particularly true if you control git
>  via scripts. See for example (two years later):
>    From: Duy Nguyen
>    To: Junio C Hamano
>    Cc: Git Mailing List <git@vger.kernel.org>,
>    Subject: Re: error: src refspec refs/heads/master matches more than o=
ne.
>    Date: Wed, 23 Mar 2016 18:17:05 +0700
>
>  So with this patch I want to pick up this old discussion yet again.
>
>  This code can probably be done a lot better I guess, but I wanted to
>  send in something, to start the discussion.

A lot of this text should probably go into the commit message itself,
possibly with accompanying Message-IDs or even public-inbox URLs right
away.

>
> diff --git a/branch.c b/branch.c
> index 579494738a..e74872dac5 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -256,6 +256,16 @@ void create_branch(struct repository *r,
>  	int dont_change_ref =3D 0;
>  	int explicit_tracking =3D 0;
>
> +	if (!force && (
> +		starts_with(name, "refs/") ||
> +		starts_with(name, "heads/") ||
> +		starts_with(name, "remotes/") ||
> +		starts_with(name, "tags/")

A more common problem for me, personally, is when I manage to fool
myself by creating a local branch like `origin/master`. Clearly, I want
to refer to the remote-tracking branch, but by mistake I create a local
branch that now conflicts with the (short) name of the remote-tracking
branch.

To remedy this, you would not only have to ensure that `create_branch()`
verifies that the branch name does not have a `<remote-name>/` prefix
where `<remote-name>` refers to a valid remote, but you would also need
a corresponding patch that teaches `git add remote <nick> <url>` to
verify that no local branch starts with `<nick>/`.

What do you think?

Ciao,
Johannes

> +	)) {
> +		die(_("A local branch name should not start with "
> +		      "\"refs/\", \"heads/\", \"remotes/\" or \"tags/\""));
> +	}
> +
>  	if (track =3D=3D BRANCH_TRACK_EXPLICIT || track =3D=3D BRANCH_TRACK_OV=
ERRIDE)
>  		explicit_tracking =3D 1;
>
> --
> 2.24.0.1.g6c2c19214d.dirty
>
>
