Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D0AC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF99611C0
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhKDAFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:05:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:48869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhKDAFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635984148;
        bh=oM2ht84gMJfjl2ZNpyGXEuycBarifda579SaCAvLSyc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dfuqaY4JhC+Npu3ejfH1aVgDG4lXtfAjnflTQKQhO7GxKjPZOCvBZF/n42wP9VxVP
         l7xZz6Au22P0LjlV0PYR5O5ESicMQix0lh/ezz2OJxqHgY2UxnOahl5nqcG3DyqSdW
         4Hl6PN2NH2I7WeCExVgVa7L9NY+gSQi+M1zvqB7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1mbAwJ1Da7-012oRg; Thu, 04
 Nov 2021 01:02:28 +0100
Date:   Thu, 4 Nov 2021 01:02:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Federico Kircheis <federico.kircheis@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git aliases and GIT_PREFIX
In-Reply-To: <20211102172644.cnsro5p3m6o6b6po@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111040047540.56@tvgsbejvaqbjf.bet>
References: <2e328484-d0e3-8801-61da-07544cc93eef@gmail.com> <nycvar.QRO.7.76.6.2111021520370.56@tvgsbejvaqbjf.bet> <20211102172644.cnsro5p3m6o6b6po@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/o0ZnzYXoLaMxegv9tPPCNHPlk+A5aCHlB7RCpaPoHI7nduO8JC
 puL6aJog993/ECK9CAJYsSlqvtLP577iJJdsUUOvalQMHDNbx8JQkXzKhAfjs6OAkfGliFl
 u67eoQI8Rct0iVv31RDQXSt4XvBHXcqjM3oUTF9YPKNulwBIg8vVhlbHizjKynzgioaBdB1
 jCv5b085+D6gF+MqE2Cjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x+73VeQgZZ8=:gazKAsNcexceEra3yrqbY7
 sB7ZsRKeZ4oSZv7H9bxexcciKwxj8mNMEicy46+QbfaLUGbjT6ENNf9ZKtwbY/k1JdX0BWu1i
 8FW79KemwPr1nWeKN12i2YyK5lcYX+ltPHVlvqaKRSA4r6wTUCZqR90wyichzro90QC7WZljW
 DGiGN9diL4QMr8MpymnZREUYyshq6bnP3xJp7pSODFBDvfC/nVw1gw8SDx7ZWsjL1Wi1t65xe
 yv1fyrkRJ3ipZlHgVujCfxEJ1sExGZ0JBIw1IMHCddY9ZOvIcvSkXzi1AL3l9xoAqRn+uOrnd
 cftuy+jyAV9pv/gWRkxpdrNmaKZOHdDvDtO3+wW1Rd/K07kFgyOjc51oLqERDKexAa2ioqkle
 h3cz08QDr9S5NU3gA6S2Nt6xRTuLiVq4ix+n8ry6oAl7SK8rFg8J+NPZpjuEZqpS1a8UFK9Me
 qUEmzzyEtfjq3izCOX6JF1YolXy0K0sgEiHhFFigh98BHmTLUhr8HXYekQnaMSY70EjJ5WBu7
 GmZjArJDfxHaqijhEWty5vSShRk9WTprpjdJJXramQKPB/ABaOlGepZq2FNBKh2li8vrxVM3J
 Ovsve7vaZ3mDXPJZkHg7EqsqvsxU7C7mWvuvHQw9J6a+Tmxg5PXivc8DIqvugg6bnrS/xdXxX
 BMK7+cgXPAqeuZVPKGHuvfxBplElPCMkqCLdLgkXHbDqg2avYtEzuF6j6Bahl0qWA2cqKgjxi
 0xkgbh3U21QXJ+KTX32+JGUgvFPSPg/c+yzgjiN1IUQp17/Bogqd+SqrmBElqZ2xQFWXK4sWe
 r25gz0Y5i20Oi0olpRqtMXuoW3TYd5wVJwBhKNvYlFl+qOB8MVlssT6+0e8bsL7dBEyJpEt3T
 WgW9s9QFgp1Ua4GLR0KxOjHisyP27EyEJrP6roR6LAVgF2HFoxupYbs1Om8BzVXRYKMx9u2Qi
 7AbSGdF+khvbSr6Gdbv+jq3COSV5gPOX0AcuWM1p/hgE1QttM8uCw1/DxNxvIh5GA9hlZQSuc
 dZ/msPdS8TVpCVdUp6ahhEijFq9D/njHMl0kjkSUNJ9qZYxcuIta1Ue2WcaG9uDs4C3XvJPm0
 6ONAhbZtbKKXEM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Federico,

On Tue, 2 Nov 2021, Federico Kircheis wrote:

> On Tue, Nov 02, 2021 at 03:26:05PM +0100, Johannes Schindelin wrote:
> >
> >On Thu, 28 Oct 2021, Federico Kircheis wrote:
> >
> > > today I reported what I believed to be a bug on
> > >
> > >  https://github.com/git-for-windows/git/issues/3496
> > >
> > > and learned about GIT_DIR when working with aliases and git worktree=
.
> > >
> > > It's annoying that GIT_DIR it is defined only if (as far as I've
> > > understood)
> > > working from a worktrees or submodule, as it does not seem to be rel=
ated
> > > to
> > > those type of repositories.
> >
> >To clarify: `GIT_DIR` is set when executing an alias in a worktree othe=
r
> >than the primary one (and probably also in submodules), but not when
> >executing in a primary worktree.
> >
> > > This is also irritating because apparently working aliases breaks wh=
en
> > > being
> > > executed from those repositories.
> >
> >To clarify: an alias that wants to switch to a different repository and
> >execute Git commands there works well in a primary worktree. But when y=
ou
> >switch to a different repository while executing an alias from a second=
ary
> >worktree, it will fail because of `GIT_DIR` having been set.
> >
> > > I believe it would be better if GIT_DIR it's either always set or ne=
ver
> > > (could someone enlighten me why the variable is needed in first plac=
e?).
>
> Yes, sorry if I was not clear, your clarification are what I meant to sa=
y.
>
> >The fact that `GIT_DIR` is not set when calling an alias in a primary
> >worktree suggests that the behavior in secondary worktrees is not by
> >design. We should therefore be able to stop setting it there.
> >
> >The question is: what code is responsible for setting it only in some
> >circumstances but not others?
> >
> >Federico, do you have any experience in debugging C code? If so, it wou=
ld
> >be good if you could take a crack at investigating this.
> >
> >Ciao,
> >Johannes
>
> Yes, I have some experience, but never looked at the git codebase.
>
> On GitHub (https://github.com/git-for-windows/git/issues/3496) there is
> already an hint where those variables are set:
>
>   https://github.com/git/git/blob/v2.33.1/git.c#L354

Well, that's a call to `setup_git_directory_gently()`, and obviously we
already know a couple of scenarios where the `GIT_DIR` environment
variable is _not_ set in this function.

Unfortunately, this function is a bit long and calls other functions, too:
https://github.com/git/git/blob/v2.33.1/setup.c#L1206-L1339

I actually believe that the `GIT_DIR` is set (_when_ it is set) in
`set_git_dir_1()`:
https://github.com/git/git/blob/v2.33.1/environment.c#L332. This function
is called, unconditionally, in `set_git_dir()`, so my best bet is that the
`set_git_dir()` function calls in `setup_git_directory_gently()` are the
reason why `GIT_DIR` is set sometimes, but not always.

And it is further my suspicion that calls to `set_git_dir()` are used to
potentially turn a relative path into an absolute one, by passing a
non-zero value for `make_realpath`. And this might be the reason for the
calls in the first place, not the `GIT_DIR` variable.

So the first step would probably be to write a test case (see the scripts
in t/) that creates a secondary worktree, then calls an alias that
verifies that `GIT_DIR` is not set when run in that worktree. This test
case would be marked with `test_expect_failure`.

Then, you need to debug that test case (e.g. by using the `debug` function
to run a given Git command through `gdb` and then setting a breakpoint on
`setenv()`). Once you have the call path of the offending `setenv()`, you
might find an elegant way to avoid setting the environment variable.

On the other hand, you could also simply unset `GIT_DIR` and friends
explicitly, by adding something like this after
https://github.com/git/git/blob/v2.33.1/git.c#L364:

	strvec_push(&child.env, "GIT_DIR");

But then, you might actually break things. The `GIT_PREFIX` variable is
required to let aliases know in which subdirectory (if any) they were
started. For example, if you run this command in Git's `Documentation/`
directory, it will actually print the path of the top-level directory:

	git -c alias.pwd=3D'!pwd' pwd

This is long-established behavior, and the only way to go back to the
directory from where the alias was started is to call `cd "$GIT_PREFIX"`.
That's behavior, therefore, that you cannot change.

And if `GIT_PREFIX` needs to be set, maybe there are scenarios where
`GIT_DIR` actually _does_ need to be set?

Hopefully these explanations make some sense to you.

Ciao,
Johannes
