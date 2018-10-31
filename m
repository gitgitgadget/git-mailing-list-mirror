Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CB71F453
	for <e@80x24.org>; Wed, 31 Oct 2018 11:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJaUCN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 16:02:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:48409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeJaUCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 16:02:13 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYsEZ-1g50f60slv-00VcxQ; Wed, 31
 Oct 2018 12:04:31 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYsEZ-1g50f60slv-00VcxQ; Wed, 31
 Oct 2018 12:04:31 +0100
Date:   Wed, 31 Oct 2018 12:04:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] mingw: prevent external PERL5LIB from interfering
In-Reply-To: <xmqqtvl2ye3b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810311151170.4546@tvgsbejvaqbjf.bet>
References: <pull.62.git.gitgitgadget@gmail.com> <xmqqtvl2ye3b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:53QW54x0LjiP6b9qNRq9TQsRZPGM5gVWhjBFvGf36gZty8EhQdS
 /dZdirfdljz7IlQ4UkvXm4tPY+UzjR6NAlCe9N+cYVSXuuqPMASFMK9Kzauz2P+gnXPQNo6
 rnqSm00MBEjC58QS2GXgeUXEIti3EhACEQgFmVseXvSzomPVL6BEs3C69W2Q6CXeoURTzwi
 4KsqBnwqBOTH9k1oErJ0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0n5ZzzyfIQM=:4+PhyI7Qhmyf7v/ZB0UeUC
 GibYkFgOTw9R6tIfrxL5/UaXHTE9nxaOKalhTTMdbZ4N4jdHo+jDF2GfZMFL2rNNdbB2tBXWJ
 ZUtsxchI9FKglg5jp+BvPrpaY/pjTIkE1OiG2wiqBLm7ODTkKtNDXAC2os3VV6f/8zwaorTjL
 ln4fpbWWvZvpIdKhUKgRh7FWkiPh9l1TeqFzRz/6rHe1npTlI+uOCCzNT8bFX6PDsAqNa4Vd+
 ASH0vRuAqMz3I6Sp+nJGt80cC6Dnj/ALjc6EJ3xt2z+bdcFmCD6E6hndC/7wMyrpFxb8ONQ2U
 V9SKOGtcVC9UlowEeOt7CT1Vn83HB+YeEC/LmYfTJHOD/Hqa3UWKwi6/YAis3yD/h9vWJM9g0
 uh8/LZHw7nbiYmEJp897pLtF5f7hOWKrcXq/kF9KWx5WcUag3gUmijkZAdNJ7NDCJKHRgetFF
 Az1QBaaoS669ZJe3iMEEDUZ2PTikuEciFMhSf2DpmdXlBoQEzs03tB8m3Hbp4EvWjacS1mwc+
 9WnQNF2tJBQBCEl29uK38NoLNn0sLryZYmJDk1B8jyCxOHE3tK+dQLcCuBCJN7bBZhHJfKC5W
 WFiKQ9qlwda89obGU22RuX44ybKvofKpUhooOex0P/x0dslPNpCI7WDfo9vm6ZMKPup3O+HjQ
 BHHwI7yYjYP8eYj3iNbIJb2Et0Y4Hb9S32jaOzTmX3ZbggM8ApNhAhIeRAeU4+64HAJI4RsCi
 K2eaE/TL2di9rfKb9+r9OOY+/svoKZeqxPbQaO6ZyoqHhscFpI3EelIqYrL3lL02QLcPZga0B
 1pLeEA22WttgUAlJnwCWujJHEu4OaS4W6kjS7Nyc2KHkRKCaM8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > An alternative approach which was rejected at the time (because it
> > interfered with the then-ongoing work to compile Git for Windows using
> > MS Visual C++) would patch the make_environment_block() function to
> > skip the specified environment variables before handing down the
> > environment block to the spawned process. Currently it would interfere
> > with the mingw-utf-8-env patch series I sent earlier today
> > [https://public-inbox.org/git/pull.57.git.gitgitgadget@gmail.com].
> 
> So the rejected approach that was not used in this series would
> interfere with the other one, but I do not have to worry about it
> because this series does not use that approach?  I had to read the six
> lines above twice to figure out that it essentially is saying "I
> shouldn't care", but please let me know if I misread the paragraph and I
> need to care ;-)

Well, you might want to worry about it. Or not.

The approach taken by this patch series is to call `unsetenv()` for the
variable names listed in `core.unsetenvvars` (if any), just before
spawning off the first process (if any).

What I meant by this comment in the cover letter is that I thought about
doing it differently. We already have a perfectly fine function called
`make_environment_block()` that takes a "deltaenv", and then constructs a
new environment block from the current environment plus deltaenv. And this
would be an obvious alternative place to "unset" the variables, as this
function is only called just before spawning new processes.

I was weighing both options, and both back then as right now, there are
other patches in flight that conflict with the second approach, so the
first approach is what I went with.

From a purely aesthetic point of view, the second approach looks nicer, as
it really only affects the spawned processes (and not the current one),
and it allows for changing the list between spawning processes.

But to do it right, I would also have to use a hash set, and it would
complicate the code of `make_environment_block()` even further. And it
sounds a bit like overkill to me, too.

So I sided with the approach presented in the current revision of the
patch series, but I wanted to describe the other approach in case you (or
other reviewers) have a different opinion.

> > While at it, this patch series also cleans up house and moves the
> > Windows-specific core.* variable handling to compat/mingw.c rather
> > than cluttering environment.c and config.c with things that e.g.
> > developers on Linux do not want to care about.
> 
> Or Macs.

Or macOS. Or FreeBSD. Or Irix. Or any other, that's right ;-)

Traditionally, we did not really care all that much about platforms other
than Linux, though, which is what made me write what I wrote. Having said
that, I get the impression that this is changing slowly. The benefits are
pretty clear, too. After all, it was a *Windows* build failure recently
that let Peff identify and fix a *non-Windows* bug...

> When I skimmed this series earlier, I found that patches 2 & 3 sensibly
> implemented to achieve this goal.

Thanks!
Dscho

> 
> >
> > Johannes Schindelin (4):
> >   config: rename `dummy` parameter to `cb` in git_default_config()
> >   Allow for platform-specific core.* config settings
> >   Move Windows-specific config settings into compat/mingw.c
> >   mingw: unset PERL5LIB by default
> >
> >  Documentation/config.txt     |  6 ++++
> >  cache.h                      |  8 -----
> >  compat/mingw.c               | 58 +++++++++++++++++++++++++++++++++++-
> >  compat/mingw.h               |  3 ++
> >  config.c                     | 18 ++++-------
> >  environment.c                |  1 -
> >  git-compat-util.h            |  8 +++++
> >  t/t0029-core-unsetenvvars.sh | 30 +++++++++++++++++++
> >  8 files changed, 109 insertions(+), 23 deletions(-)
> >  create mode 100755 t/t0029-core-unsetenvvars.sh
> >
> >
> > base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
> > Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-62%2Fdscho%2Fperl5lib-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-62/dscho/perl5lib-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/62
> 
