Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD04CC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B419461130
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJTL6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:58:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:46865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJTL6P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 07:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634730945;
        bh=TBzdd//mHQteqAE2r3S+AEht0DEdZMyJ55X1Ga2exKA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z6QzCnAFvf6k1KU6xk4TAvC4YFZsvlLt0d2afRvPFYbwutUGQVLKOC+HLWmCabuxC
         kyco2/shXI7JENSPxgQhw/SPnklN/he2StIDa8haWble9V/y0if7uHIeooW/7n+w8Y
         7bGJnfquJIhsoTQOCN6OkMndmVo1XP+6q+8kcUqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1nByaV0JLy-00heok; Wed, 20
 Oct 2021 13:55:45 +0200
Date:   Wed, 20 Oct 2021 13:55:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] gitfaq: add advice on monorepos
In-Reply-To: <20211020010624.675562-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2110201349570.56@tvgsbejvaqbjf.bet>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net> <20211020010624.675562-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JxOb3jG8oOfETkzSkhYD7SVPiXfA08yzc9i/oeutGsd1OZMcOdy
 n9IcWsQWKW9xDDHomXLlsCGv9yIazKYK3ptBsJxXi8XBV7+knD5ROpFz3sPUYjpuF425Ak1
 0HblHmzVivdv19hZ4VjnoAb92Drp1qgjE8/ZR6HcvYJAdp4OulmcjiK9xsChLuSy+A08S5P
 x9LBuI+3OJ+QQZwL6OqvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zD4pFGvWuv8=:bILig9uUnKi0Bfx7BiSxg5
 wLs71BI1hcPo2Fs1b6zNwyeSuVDJzDVHbpkrA0H1nzJN7gMAwm1tHgIyWMpVpdKCy8dIqh4dD
 lKFzReNuq/BqAHHgQwuaQB3dGDPwAqY1g3qfBUAQmBdLMN5BHZCyRRdCgs1H4seJXM9Gz0zAt
 94qKJclDNlrK/Eowc7weHlfqfg4SByqx50qXbIBDYGvnhO++pxQ5B6KiKRDqLssDqJcRVbHW9
 miru4EVgZuCmUNWLw+QkCaRPMfswV4B3d9I1XmOZCad72l00nsKkZjWiiMvbhLjTBAzWHIMsv
 NbcMb+x1xPcjE70mZJpqX17/wKdSlqJveC85l0BWl46s4cVRqRKG+MFVTz3/PPO47rtiNSGsw
 PgyT/U+TzceGhd4z8mBvCNu+8P+gaKu6fM7YX1vLhWDypipfsrW3o2O0IMHV3dX3bxNkXp9uG
 lK+0tW0+cAZSzsdiMcCUyC1Ztx4rTLTMiAmnenDaDtS63HYR5vGvye7XN9ei639t7lPwGTtob
 9gHryytW+7dXMtBR3Z7amkWzIA+tYG3hWS2BmYGyivCZ1V09+l7bBSSq6ccmAuG2l1leRGe6X
 uidjtjmVUwoKtPCXHeNeARTCgKEZ4CPP5viyQp2Ha1JW/1h6R9NkfunzxbHwjeSBF7MmJBqy+
 37dyKWOLIDBcqhMLloR3BEASPDq4vssne0UWkFgolFZiBmmTHptEiLmkCin9kJqF9gnVsrBE1
 IIWDQHCcCeBLKHL8cHBUmvDZwaS/THflpSIY+c1C3fHPhXw/TfG1ct1up66OJ0AQZXsStlvLT
 oiMnAHXZAnDYzxwykG7nPDiqHEWQKkei0BgCO7Qu/bV7EKS1b/9MirzzUKNPwIRmfLLhAIw6H
 AW6S92GcOvE/v7uIWl5X+lh7tolXYDA7PpPl7bO02PMO9b6htMduW93e2SqxBX4M5efG4Oz4r
 Ptbl6cA72p6I6rRPrvnAAaZGAWOIMirrjoyIqG9mb6yjL22rZuPRLb4qU1JQEOY+0rvB55r0f
 bP0WEpY618xbf9vUAxq8B5xuZyusB/bzQmgSW5gV+PDGNY9rtRrlc6GkuTCClKLu5HV5P4wtc
 vethLIk4gpnRu8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

thank you for this excellent idea to talk about monorepos.

On Wed, 20 Oct 2021, brian m. carlson wrote:

> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 8c1f2d5675..946691c153 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -241,6 +241,32 @@ How do I know if I want to do a fetch or a pull?::
>  	ignore the upstream changes.  A pull consists of a fetch followed
>  	immediately by either a merge or rebase.  See linkgit:git-pull[1].
>
> +Design
> +------
> +
> +[[monorepos]]
> +Should we use a monorepo or many individual repos?::
> +	This is a decision that is typically made based on an organization's n=
eeds and
> +	desires for their projects.  Git has several features, such as shallow=
 clone,
> +	partial clone, and sparse checkout to make working with large reposito=
ries

May I request taking out shallow clones? A user new to Git might think
that shallow clones are a sane way to clone a large repository. In
practice, this only makes sense for "throw-away" clones, though. As soon
as you fetch in such clones, performance will be so horrible that it is
frequently a better idea to start with a partial clone instead.

At the same time, I would like to swap in "sparse index" for "shallow
clone" because it _does_ have the best potential of all currently
discussed new features to improve performance with monorepos.

> +	easier, and there is active development on making the monorepo experie=
nce
> +	better.
> ++
> +However, at a certain size, the performance of a monorepo will likely b=
ecome
> +unacceptable _unless_ you use these features.  If you choose to start w=
ith a

I would like to add a plug for Scalar here. Maybe we can link to this
"opinionated tool based on Git" here? I wouldn't ask if I didn't _know_
that it helps monorepo users out there.

> +monorepo and continue to grow, you may end up unhappy with the performa=
nce
> +characteristics at a point where making a change is difficult.  The per=
formance
> +of using many smaller repositories will almost always be much better an=
d will
> +generally not necessitate the use of these more advanced features.  If =
you are
> +concerned about future performance of your repository and related tools=
, you may
> +wish to avoid a monorepo.
> ++
> +Ultimately, you should make a decision fully informed about the potenti=
al
> +benefits and downsides, including the capabilities, performance, and fu=
ture
> +requirements for your repository and related tools, including your host=
ing
> +platform, build tools, and other programs you typically use as part of =
your
> +workflow.

I wish we had a good article to link to, here. Yes, it is a decision that
should be fully informed, and yes, this FAQ entry is not the place for a
thorough discussion of monorepos and how Git can be asked to handle them
more efficiently.

Do you know of any good resource that we could use here?

Thanks,
Dscho

> +
>  Merging and Rebasing
>  --------------------
>
>
