Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C9C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8048761056
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 08:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJUIgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:36:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:51181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhJUIgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 04:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634805221;
        bh=doBmF1ZO3DeX5uSL/3FG2Ka03HS5UZ/au+5STc2ONUc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PFQKuwo69/dcf2D4dkkTP8sNt6wIHCp0w7YY87BY5Jiqpj3/T0PUduT25v/l2faiI
         3EmvWq/DLlryQUHwYK+/LVaYn2mGCy7kMxP2gGwSS3vT08Osw0MmQyk+GK2wSBH70W
         ivIz4x0d3YscOFDpGXIJcXjw4LZNLI9150TtNaSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1nF1C923Ee-00bZ2v; Thu, 21
 Oct 2021 10:33:41 +0200
Date:   Thu, 21 Oct 2021 10:33:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Oct 2021, #05;
 Mon, 18)
In-Reply-To: <211020.86zgr3n698.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet>
References: <xmqq1r4hv7bv.fsf@gitster.g> <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet> <211020.86zgr3n698.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-621983979-1634805222=:56"
X-Provags-ID: V03:K1:y3wAdAHVCzVSlRCwLVqjtR4/CY9MxsO3fuaoJjrncR/gII4WZEQ
 e3eiKKpIlqKbmTcdGrRJbt4O1lti9KeZC+knRDbts+GneRPpsFNsnANi1yW8IYj60K1PtXN
 ViPvVJRVdnT+mC4e0s/oIOzvqj+H5L74J/Uxn2MCLOMEqKuNX1tQD5mAo6XlDdv86JrZdWp
 JH05Ant1clT6khHpOM2eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VP4rVIKfkIk=:cbOj3GnN7p8PN2TLSptQCI
 4b7TmBolwu9cspAbAr2dCV5/n7DXvEABnkf4ria69VYu82Pk9F9dSbgAGEpMo19zC524W5BFg
 5fMWlJ0auQRiBJexiB6cC+0auZJxehAPEqcaLPEafBvEbrewMoJtViSiZ7BCn9+eQqo6g4w0M
 0KQYOcODewpF90bKc8OUdi1sY9YNg1L0aSyZPgThY1ihySdj7678iBE3Mg2rKejG1Z8XrWu7f
 H7992UG9g3NpfPsaFA7Gxt+FuLO/TnGYAC7itRfqEQFAPsiezFZRTR8Gu3mkACUKhF2qfbxML
 D7FVKjo9eAGVD1+bX6yutzC/mP56EoJoTJTVJX+qx4bWWWHnfuWfqhOUihWKLLnK5HIa9Vrq4
 KAEFErEzCXzwTOIwKhSWDkPRCdobPkIDXHLN1bWg0ZJTojoBBXDta1swQQikr4MqvdB5zgWxs
 Eiy4F86NqTPNDEsPsn7nlBp7CRCzEcF76J0UIrleEC20jjOd7qX3UW7kKYRmx9+zj2dhGJjok
 kAdkBGbYLw+pYBTm9CFgFonTIq8C+xjQO6gmoVyVYI16ZpEyUfSnRo6G/PJxGQP3QihV+LwtL
 7fVRNQFVdR3hkLkk/u8N9/QtoWB7J7d/6cSTR8o4IXlAPPgzetVsfKZ3cHQVNGWjnKZFway05
 4JVGx3k1ZkKzSAsveAzMblkpub8dotITQF7DsArfc/EDC21ANyv1caJ94lWtEykRuH7mN43hU
 R3A/WFpyM1kGhVPrfiFU5db1GB5/Cr0DlUidbcsgCBT3dAvkkqGW4PNWB88c55FasIVQCe71J
 xWJteI8FKVhJOwpWJKpfAN5c9hzlwFdSwFFaUDNPzwAIH6JlxG18MEUw6GD6KrmrOQrdjpzR9
 JiOekAlCjAJR325CpCuRWDIad/mZewZvXOGCYrFSwXBw9RRpOGJQTTdAIYWoSob2m9R3Q7f5A
 dgCRqYWrf/HKForzeUxo7MW10ejAknfMmotkG4bD8ddPn47FJ7C30gogeKrheXCeHfoAYVoAj
 BLu0g8ozIov0NrE3p3uGgBvFq12GYH/LJKd/YNggK92Fi5m843CUeet6JdGkDFZXQVoJfSN+h
 quY8YoeIAqzgTI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-621983979-1634805222=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

tl;dr it isn't worth your nor my time for you to focus on the build
process in contrib/scalar/ at this moment.

Having said that, I do appreciate your interest in this patch series, and
I have suggestions at the end of this mail how we could collaborate on it
in a more fruitful manner.

On Wed, 20 Oct 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Oct 19 2021, Johannes Schindelin wrote:
>
> > On Mon, 18 Oct 2021, Junio C Hamano wrote:
> >
> >> * js/scalar (2021-10-07) 15 commits
> >>  - scalar: accept -C and -c options before the subcommand
> >>  - scalar: implement the `version` command
> >>  - scalar: implement the `delete` command
> >>  - scalar: teach 'reconfigure' to optionally handle all registered en=
listments
> >>  - scalar: allow reconfiguring an existing enlistment
> >>  - scalar: implement the `run` command
> >>  - scalar: teach 'clone' to support the --single-branch option
> >>  - scalar: implement the `clone` subcommand
> >>  - scalar: implement 'scalar list'
> >>  - scalar: let 'unregister' handle a deleted enlistment directory gra=
cefully
> >>  - scalar: 'unregister' stops background maintenance
> >>  - scalar: 'register' sets recommended config and starts maintenance
> >>  - scalar: create test infrastructure
> >>  - scalar: start documenting the command
> >>  - scalar: create a rudimentary executable
> >>
> >>  Add pieces from "scalar" to contrib/.
> >>
> >>  What's the status of this thing?
> >
> > As far as I am concerned, the current status is: We agreed that this
> > thing _can_ live in contrib/, and that the `scalar` command itself
> > should not be integrated deeply into Git because the end game is for
> > `git clone` (and maybe `git maintenance`) to learn Scalar's tricks.
> >
> > A concern was raised that `make -C contrib/scalar` does not rebuild
> > `libgit.a` whenever any of `libgit.a`'s source files were modified. In
> > light of the previous paragraph, I believe that my time would be
> > better spent on designing a new `git clone` option, though, than to
> > spend time on a build process that will be soon obsolete (except if I
> > allow myself to be distracted by things like teaching `make -C
> > contrib/scalar` to know about `libgit.a`'s prerequisites). In other
> > words, it is a technical debt I firmly believe is worth accruing.
> >
> > Other than that, I heard no objections, therefore I believe that this
> > is ready for `next`, to be cooked in the v2.34 cycle.
>
> Your patches as they stand don't implement a "make install{-doc,-man}"
> for the new command.

Right. They are just a start.

I would like to direct your attention to
https://github.com/microsoft/git/compare/vfs-2.33.0...dscho:vfs-with-scala=
r,
which has a more complete picture of what I have.

It is a thicket of 8 patch series. I would like to hold your horses until
it is time for me to submit `include-scalar-in-build`, in particular
https://github.com/dscho/git/commit/473ca8ae673.

> I'm happy to help you make that work, but I don't think framing it as
> some abstract objection about whether something lives in contrib or not
> is accurate.

Scalar is headed to contrib/ _specifically_ to make it clear that it is
_not_ a core part of Git. I laid out the reasons before: the user
interface of the Scalar executable is already in use, and hence
non-negotiable.

Since it won't be part of core Git, I fail to see the urgency to integrate
its build process more closely into Git's build process, _right now_.

> For example in your just-sent[2] you say:
>
>     I would like to add a plug for Scalar here. Maybe we can link to thi=
s
>     "opinionated tool based on Git" here? I wouldn't ask if I didn't _kn=
ow_
>     that it helps monorepo users out there.
>
> I agree that would be useful, but currently our documentation build
> would fail if you linked to the scalar from other git documentation.
> Since we lint it and check if the linkgit:* crosslinks would be 404'd.

The link I was implying was
https://github.com/microsoft/git/blob/HEAD/contrib/scalar/docs/index.md.
Sorry for not spelling it out clearly.

> I don't see why wouldn't consider an up-front solution to that technical
> debt, or why you're seemingly ignoring comments about aspects of your
> patches that are broken or will cause that unnecessary technical debt.

One of the many reasons why one might want to accrue technical debt, and
it is my reason in this context, is the expectation that it won't need to
be paid down at all because we will eventually just delete contrib/scalar/
in a couple of years, when it has served its purpose.

> It would be a hassle to deal with when it comes to various build-system
> integration we already have, or which I have WIP work to implement. I'm
> also offering to fix it for you, so it wouldn't be much of a distraction
> to your efforts.

Unfortunately, it is very much a distraction of my efforts. Not only would
your patches force me to spend more time to rework and adapt my patches to
your changes, as they _specifically_ touch the same code that I am working
on. It is also forcing me to spend time on reading all your mails, and on
writing mails like this one.

I would have much rather spent my energy on the next steps: contributing
the `scalar-diagnose` patches, and working towards a new, experimental
`git clone`/`git init` option that automatically registers the worktree
with `git maintenance`, and then using that in `contrib/scalar/`.

It would be helpful to pick up other feature enhancements, in less related
code locations (to avoid stepping on each others' toes all the time), such
as silencing the warning in `scalar reconfigure -a` when an enlistment was
deleted manually, and instead removing it from the `scalar` and the
`maintenance` sections in `~/.gitconfig`. Or to teach `git maintenance` to
already do the equivalent when a scheduled run detects a missing worktree.

Ciao,
Dscho

--8323328-621983979-1634805222=:56--
