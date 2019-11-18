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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A10C1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 18:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfKRSi0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 13:38:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:47733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfKRSi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 13:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574102290;
        bh=jSlHpJ/A8gyTbKTz+zpmUjJNulOtCA8Ycfr6uf9fYmw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R/1XmuUvflGK63Ma8rrKhZ3rSP0XwoT/GAmE8V6u9h0cOnvNAlF3lKlE8SwOKpxzh
         zFY7IerGqswJ7dN1XpzBPKiTFXuQE4oWguyZ6Z1iALh+n/1XY59gRXZdPQl2+998xT
         QevRV6vVZmAPvf4hJPcLPF9b+fS/F0bHRilw8y34=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1icoau1JCE-00G2Bm; Mon, 18
 Nov 2019 19:38:10 +0100
Date:   Mon, 18 Nov 2019 19:37:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
In-Reply-To: <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
References: <20191109020037.GB60198@google.com> <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet> <20191113011020.GB20431@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet> <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dx4d4gnqIKzcgaXly8JrE66ZH6sssOEWF8cqgpfSN4Y+S5beyk2
 Sh1gvFeP35k8qVG2h1kWkOVzs3BHjfHLIH9y0hTFimHcizwfOOmOjIwTZhyAZR9PXdt5SeV
 LAFKXDO3DCILXT/F871fGGOA5ZuYZ2xDB2WAvcaGmprxU4U6dupkkW9QrLnnhqDNO80exNO
 Mop+1fQ8LYJ1Ue3IBkQUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e+F3ywD1Twk=:Zl30dWxm2c8juAEv4d55mG
 oHPqRYSa1VX5SQGRcgC0RlI5ceZCD0xC6i2GofXiyfON+auZJiRVr9C38MfIxGc0rm2wpGS3m
 E54k9/pFuUptijeAt4tH1wHYLiQxTwMjieqj2/JeoAWrLWQW+J370cqyEtgG1hQX35yQ5iE7e
 cXJFRI3Izz4KcimMbFPn+gXQPRMAPeRruTmYGwMJbl07WeXkHkAK8wOvi47MpSMIdR+6t0eFj
 WSpwp12QgTHj62epLpypePnvCuQoU6wz9cR9VpwGNY+YHsQcALjr/haAVvZf9/Kwhs45nWFVH
 +DzZnKa66PyypBOx4Tvijrld7uaaC66hWUWS/1t48qNHh4/D+lGBtqRG4fBD+FcDYSKf/Kvvb
 lDBrEksQ64VKEKQUI1QjqrWDi9J0BVh5hpjaoAggzm1HxsP4yWaTe4lZKkdo7KG95S9XQxP3l
 OryoFJgYstQjpYpgboMH0khcH5ns/nfj4Uf1poNTjTIlwdXSl6A0eWuTPDsue+Cj9Yjm27G/E
 BoIc1j/tU63N/FcHdQuWmwnqqSzjWlpTU7TRQbFHaXMRThIW26jtrOL0OzP84SaIvMHlqVg9E
 HCnbRomHAiw+7cI8bSUwxPfsdHUMoKuCsbnxpv6Zc8/STxzGnlT4yQFjn2Kzz6WI5JfxK6PM0
 P2AFvk3zp1K69JTFonaSL5taWvrJdwwRSGUfOvUIsiCB+Nd00GhZswdzjiGMqGEEo4WNYTDKH
 2C1y3qCxODh1x5oMkSc/cvtJXi/LoQQx4ixSGfQwvgvU9Ihu67+dkY1GD6y6lDi7zLAWW522c
 DyIWMheozVLLHy+OckrbtYlSIldm2w0t8PWoP0QFf35oaTP5G8kZU7mYZQm+sUUk1GO5n1hTg
 Wp+phAafBpT6COb3zcw3J5/8rb5oUbZgkGQYaj+6+wu9mL0tsVd+rikgVRGp+lCIZWBpOpC9L
 BSNmv99WJ6KJyFu5N0DxgTLbhddSbsc4XwLqf4+kMCdNEjU2WWOfkE5tugwROvwq8LA3DqTk0
 nfukrjLuAwWKwItE+QbYDISCi1Wr8ElknroOO+IgaedrTmmGE/9bygT0BkqeXMTAu8TJIZkYG
 /xxXjZ6bYHjqsyBE+stPKdJQdscRyLGGptYwTS27A0/fw2OYO+e6fEBhhzDfDwQvXgeugfc1R
 R0ZU0o7anSOcy79SCLAXpqezn7vPmKODjga5K+Lk87BO5f3gGPDetStG3lhacR149XtChaGQW
 DJHmV7GU1Q9jNqKkPLiZtfonZghw1UzdfttSofAoWnb5RlehtL8c23H31uiM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 15 Nov 2019, Johannes Schindelin wrote:

> On Thu, 14 Nov 2019, Jeff King wrote:
>
> > On Wed, Nov 13, 2019 at 01:04:35PM +0100, Johannes Schindelin wrote:
> >
> > > > We talked a while ago about having GitGitGadget operate on git/git=
,
> > > > rather than on a separate mirror. That would automatically help at=
 least
> > > > one class of PR-opener: people who want their patches to reach the=
 list
> > > > but didn't realize they should be using gitgitgadget/git.
> > > >
> > > > I don't remember what the technical blockers are for getting that =
set
> > > > up, but it seems like a strictly nicer outcome than auto-closing t=
heir
> > > > PR.
> > >
> > > Okay, here are a couple of technical challenges, off the top of my h=
ead:
> > > [...]
> > > Not an easy, nor a small project, I am afraid.
> >
> > Yow. That's a lot more involved than I was hoping for.

Yeah, it wasn't easy. But then, who does not like a little challenge,
especially the challenge to test things outside of production? So here
is a PR: https://github.com/gitgitgadget/gitgitgadget/pull/148

I trust everybody with even rudimentary Javascript skills to be able to
provide useful feedback on that PR.

To build some confidence in my patches (as you probably know, I do not
trust reviews as much as I trust real-life testing, although I do prefer
to have both) I "kind of" activated it on my fork, limited to act only
on comments _I_ made on PRs (and sending only to me instead of the
list), and it seems to work all right, so far. I cannot say for sure
whether it handles the PR labels correctly, but I guess time will tell,
and I will fix bugs as quickly as I can.

Question is: should I turn this thing on? I.e. install that
GitGitGadget-Git App on https://github.com/git/git? This would allow
GitHub users to `/submit` directly from PRs opened in that repository. I
am sure that there are a few kinks to work out, but I do think that it
should not take long to stabilize.

> > Thanks for writing it up. Some of the points raised were interesting. =
I
> > do think we'd want git/git (the repository) to remain read-only if
> > possible.
>
> I guess you're right.
>
> We should probably try to restrict the permissions as much as possible,
> not only deny write access to the repository.
>
> For example, one thing GitGitGadget does is to add these "Checks" to the
> commits of the PRs which contain links to the corresponding commits in
> gitster/git (if any). Those can actually not be removed, there is not
> even any API for that. So it would probably make sense to avoid that in
> git/git.
>
> This would mean that the git/git part of GitGitGadget does not install
> those commit mappings. I guess that's okay, they _are_ kinda hard to
> use.

I made it so. The GitGitGadget-Git App only requires write permission to
add PR comments and labels, which I think should be okay. It
specifically has _no_ permission to push to git/git.

> > If GitHub's permissions model is a limiting factor here, let me know
> > and I can try to bring it to the attention of the right people.
>
> I actually don't think that my use case fits any sane permission model
> ;-) After all, I want the GitHub App to _span_ repositories (even orgs),
> and that's not really the idea of Apps.
>
> After sleeping over it, I don't actually think that it is such a bad
> idea to add a second GitHub App with a more limited permission set.

The name _was_ bad, but I did settle for GitGitGadget-Git in the end.
Not the most elegant name, but hey, it works so far.

Ciao,
Dscho
