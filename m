Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7064207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 11:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbcJKL2v (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 07:28:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:56297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752225AbcJKL2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 07:28:50 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LvEZe-1auhoE0TMQ-010ISl; Tue, 11 Oct 2016 13:28:20
 +0200
Date:   Tue, 11 Oct 2016 13:28:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
In-Reply-To: <CACsJy8Aufm7g9SnckiXbMCOOvsLMqESRHLR+Zd94HxPeJj=gTw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610111325070.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com> <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
 <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net> <alpine.DEB.2.20.1610081034430.35196@virtualbox> <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net> <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
 <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net> <alpine.DEB.2.20.1610111142490.35196@virtualbox> <CACsJy8Aufm7g9SnckiXbMCOOvsLMqESRHLR+Zd94HxPeJj=gTw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:44fK5v3ioVDD12+WUUeU9xBsG7ew+f9cZwnIEjfAYLHLZQMENB/
 lE16/mOF0s+JaOVzB1eX7Jn7kZabMYx/QDhGUC2YvsO6OutMNyGKVir6ab7Th94VySGBmAV
 IKuAk/HSIKpaZjzzChG1/zUEKtHDj5i2fLQdxrZqD7rNQMXIM3JOpKwDiOfP2DtjEf3ZP9w
 wTK1N/++t+Xw5zVkWGEew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DOO7jTPuI9g=:I8/9hybK1WiQGOjgaMXFDc
 7yRPFlqyWCxRM0GHtwVaGxJU3nM6rRCyKed27aiJjx809cpxciUVNJAGvHhlBNGe4B/sEUrbg
 fXjewaezaARWmRMhwoDR4CWbg8Yx3CofwFdVHAARNw0zQSESwbILwE9cffGmY7kCc49OjMDTc
 SPc8i6/Es07/nJca8jQpPWM9yuIA7oB247DXDposKGYMWeGdflLLG9i6++TCXnUKUp2nSefvD
 9L+BL5PbBPmYQ7/IcTsjHvp0CVf4/pLKTqXWTpxDrNrP4stAxOoQaU4qRLLry7P7Kx6y7R/8W
 zKDmpB0aImjOKDIzfnZPDzIx61QULkpx/tbM5K50LvjXXoM0bO9xoncNNpA1vOKrplXLb0T79
 LoruUJsF7OmwALgRquoPOoPIWFNoIPQW/vg+3EFCr+Bufg8sLf7QA06AIEnhGEQTeHc8dJDeW
 UJY57PZQpwaAL9JcmvYshL7n2AiP/BL9EM7rhWgdKmBImlHG7HTYoVmwyozn/s9Jqvnpix3A0
 +xAyJKNMpfBq/6tipKChS42iL6f/maKnhuMqE1Nf6f1fuDU1ZlyGk/imS58yyk+0cYKORm0e2
 Oacm/I6KCsjKSpbGahDUOcl6x1tFh52r6iAbMwC+V49fBUCYk0ggSpADyc+9oGff9+WgT5mNS
 dRjoZXfbgma+CcgmR4QKMgWIwpJTDyPtH8cZfhWcbkzLJT+3vLrhTQ/+jplPb2qqjaEqjacrn
 Sv9tdHXhxIxIRkt3lk/wn5jSAXEYv2I1TmMMnfMV2DRzRLhQV/kHqeLJL5sA53NoXe6SPB1tw
 vV27FxL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, 11 Oct 2016, Duy Nguyen wrote:

> On Tue, Oct 11, 2016 at 4:44 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sun, 9 Oct 2016, Jeff King wrote:
> >
> >> On Sun, Oct 09, 2016 at 06:32:38PM +0700, Duy Nguyen wrote:
> >>
> >> > > If you mean ambiguity between the old "alias.X" and the new "alias.X.*",
> >> > > then yes, I think that's an unavoidable part of the transition.  IMHO,
> >> > > the new should take precedence over the old, and people will gradually
> >> > > move from one to the other.
> >> >
> >> > Do we really need to treat this differently than
> >> >
> >> > [alias]
> >> >     d2u = !dos2unix
> >> >     d2u = C:/cygwin/bin/dos3unix.exe
> >> >
> >> > ?
> >> >
> >> > Another similar case is one d2u (could be either old syntax or new) is
> >> > defined in ~/.gitconfig and the other d2u in $GIT_DIR/config. In
> >> > either case, the "latest" d2u definition wins.
> >>
> >> Yeah, that's reasonable, too. So:
> >>
> >>   [alias]
> >>     d2u = "!dos2unix"
> >>
> >> acts exactly as if:
> >>
> >>   [alias "d2u"]
> >>     command = dos2unix
> >>     type = shell
> >>
> >> was specified at that point, which is easy to understand.
> >
> > It is easy to understand, and even easier to get wrong or out of sync. I
> > really liked the ease of *one* `git config` call to add new aliases.
> 
> I was about to bring this up. Although to me, "git config --global
> alias.foo bar" is more convenient, but not using it is not exactly
> easy to get wrong or out of sync. For adding alias.$name.* I was
> thinking about "git config --global --edit", not executing "git
> config" multiple times.

Right, but many of my aliases get set by scripts, so your `--edit` idea
won't work for me.

> > Not sure that I like the need for more such calls just to add *one* alias (one
> > config call for "shell", one for "don't cd up", etc).
> 
> We could add git-alias if more alias types pop up (and in my opinion
> git-alias is the right call, we've been abusing git-config for alias
> manipulation for a long time).

Maybe.

It is also possible that this issue is a good indicator that we are
complicating things [*1*] more than necessary...

Ciao,
Dscho

Footnote *1*:
http://thedailywtf.com/articles/The_Complicator_0x27_s_Gloves
