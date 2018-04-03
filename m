Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F9C1F42D
	for <e@80x24.org>; Tue,  3 Apr 2018 16:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeDCQAV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:00:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:49027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeDCQAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:00:20 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lp3sy-1eZZNj2hb2-00esOb; Tue, 03 Apr 2018 18:00:07 +0200
Date:   Tue, 3 Apr 2018 18:00:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
In-Reply-To: <20180403132717.GC18824@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804031758160.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <87fu4hwgfa.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1804031150030.5026@qfpub.tvgsbejvaqbjf.bet> <20180403132717.GC18824@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q7Cnc1QJo1YbK2FRDSmzaXPFFuFKNB4CtLWWJvHi+co3e+tcz/u
 SGSTiOZQsFW/bhTwKb+Z2wrrAlzqpAfQt824DLehyEzmSmFZAnoBr7Eo+OH5YzQWO4Ze44r
 EgesyyQv+2bu3xk3KfoFVle3aaB6/LfIXLGuAjcPInT786dvNV8mWGx8lAQNcmZZ0d+UHWC
 NenKkdYpK0lBVxlRaN36w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MmjNGoJX5ug=:I5K0adJMZXat3kqgWj8Qav
 IQ/NSD2yNWFeS6HFNP5u7qfN4b2UYq9x8vQVTt/E+nmGfJ1UkaJOFDi3EF1EU5xLENyr3xVYJ
 kQa7K535Iw5VncAi34T0TdB1LqigdrlX8dYEu2FtGEyQ/oUYzfr/BNIXWGWxY1is8Hk2bUS95
 30t5oMAnN3iOcl0BKshRzA5D0gBQhgAhn8DYeAyj63SBjXsZDFa7k1WZPSwvrSS7uFlUpmrYE
 eSB4EmyeCtQizG8q0kyCGBDSOmUZZUEmmmCavx+2DZc+QeDnJDust+iNWLgnGGF2vB9GNFoaS
 ioVyyTmGIoQ6w6dC8QbbIbVKdY0nLRQWtXr62YEqTkVLqoYon8WcCy7KPdkn8slsxxv3ht5R7
 MbJp53VR6rRACn8kM8JrE+she8DiZgHBP+nx8hRYWOEK/ndncuzrTQhsCafMhsTbb43j6/SyH
 eYhwD9MrjGRbff+nYJsGDhmytNNBDFjevHXaYK981C7jtCKSnk90NFFiTZ9+SJphPjbu3ztda
 EYmOoHitj25Q6BH46WoqmjFIHIFrjE/KlWZgOcv8F8wtJ8Qvktok3Kl/0RNpChCYWFgtFJar5
 CQFk2xuUE7Ux8ArOGTIKHngM8/c6eO+JsRYqMU3vWkFknGeM4sFsoRHiSntzgVDvNuO+REiJU
 TPbFztaf+6yG0wpCV5k+XamFjpoascSItQlf1d1I06MDHIiscaMoIqEYEcGaXugM+hYAH3YHX
 PMMqSK/ZT7eSa5qHSFLNwBQ+6jjWcb/qQmozOsHSYV0ZAVGstL013nXXFWok7D84DrPpLwNwh
 Vmnr5QboPVKbHhbsmvKLksKTzoWTorUZSV6D008SyJfNYelBkcE0c/vjp3d+WaNc5ngDvzN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 3 Apr 2018, Jeff King wrote:

> On Tue, Apr 03, 2018 at 01:43:10PM +0200, Johannes Schindelin wrote:
> 
> > > I don't have time or interest to work on this now, but thought it was
> > > interesting to share. This assumes that something in shellscript like:
> > > 
> > >     while echo foo; do echo bar; done
> > > 
> > > Is no slower on Windows than *nix, since it's purely using built-ins, as
> > > opposed to something that would shell out.
> > 
> > It is still interpreting stuff. And it still goes through the POSIX
> > emulation layer.
> > 
> > I did see reports on the Git for Windows bug tracker that gave me the
> > impression that such loops in Unix shell scripts may not, in fact, be as
> > performant in MSYS2's Bash as you would like to believe:
> > 
> > https://github.com/git-for-windows/git/issues/1533#issuecomment-372025449
> 
> The main problem with `read` loops in shell is that the shell makes one
> read() syscall per character. It has to, because doing otherwise is
> user-visible in cases where the descriptor may get passed to a different
> process.

Thank you for the explanation. Makes tons of sense now.

> There's unfortunately no portable way to say "please just read this
> quickly, I promise nobody else is going to read the descriptor". And nor
> do I know of any shell which is smart enough to know that it's going to
> consume to EOF anyway (as you would for something like "cmd | while
> read").
> 
> If you know you have bash, you can use "-N" to get a more efficient
> read:
> 
>   $ echo foo | strace -e read bash -c 'read foo'
>   [...]
>   read(0, "f", 1)                         = 1
>   read(0, "o", 1)                         = 1
>   read(0, "o", 1)                         = 1
>   read(0, "\n", 1)                        = 1
> 
>   $ echo foo | strace -e read bash -c 'read -N 10 foo'
>   [...]
>   read(0, "foo\n", 10)                    = 4
>   read(0, "", 6)                          = 0
> 
> but then you have another problem: how to split the resulting buffer
> into lines in shell. ;)

True.

> But if we're at the point of creating custom C builtins for
> busybox/dash/etc, you should be able to create a primitive for "read
> this using buffered stdio, other processes be damned, and return one
> line at a time".

Well, you know, I do not think that papering over the root cause will make
anything better. And the root cause is that we use a test framework
written in Unix shell.

I will have to set aside some time to dig into the bottlenecks there and
figure out what parts I can safely convert into "test builtins", i.e. into
the test-tool Duy introduced, to avoid having shell scripts do the
heavy-lifting.

Ciao,
Dscho
