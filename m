Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896AD1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 15:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbcHSPaW (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:30:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:60137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754388AbcHSPaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:30:21 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MBFgr-1bQYc633g5-00AHby; Fri, 19 Aug 2016 17:30:15
 +0200
Date:   Fri, 19 Aug 2016 17:30:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <20160818204902.GA1670@starla>
Message-ID: <alpine.DEB.2.20.1608191720040.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JyQhQ7bC8m4HM6nwdO6Gwy49Ej/tpRfe8kX1/dmfASjL2fQoe92
 hO3uGwGw7WMO77n5Ze0eLL0/XC6+aZ5TYmJOWl/dnz0jt6VvqiiYXQRxhVb7rgsgxgcPKg6
 JUeZ4B2adox+Raxde8uQIUREf/59txPgzClP94EyLXZMmPrs6HgHkgIKKo8O3sY0FZc0B2Y
 nVOvfLLz/3Nv+R0f6V88g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7nZBf8jFHIQ=:1/nR07zbfJwemILz+1JjaM
 tJ3mg9gGoBtJyM7tFQ2wQUBEY/21dzsmZ5rL7nW0AmJ6/9dv7MO5V2GLcYnXIOgBq90WrTA6k
 WaZfTWXkJ3eyniceg3UtcEQfwMFHPK221ozQuXjPW8nN0b8yupN7wwVBPPFxcu5ELS7zIL5Tw
 OyvZZNRPjm2Nr6nOE/vy0z3v+NsqVmfNmBkb2Q1Fh+rPITaY1vypIakeskfzVICYavxTi6ezz
 X9ZR2L/IeWMrqp8LrFklnJYn/gPEfvP+96/OCIVnIxmpCZWdWhRlmiD6v7hBlNXU7dQdqlWRo
 xkT7DtDC8ImN0zbtSo0Vbgd9OB0REa6pWCY07zs2ncoA6bIW1ssDTP556wmNmhYAJJTh+SRD6
 /KUZngMvLqPk5/Fj+DKRdugqCpt8ZO+NZU5QVIz6M8bSDxIWBlwUt74OaoGb9vtjQk6FWzFcI
 CS0cRWpRekNLFyLm2TVzGJ1hWVO9pRhY9bEgaIXnymr5T+L31AER32CiHLdeYuQMMSrIcZUV/
 BhPdb6lzi0RNVFkebyDR+8NweSb4a0AOP0ntmPKw9hL6ia/awguQgesn2r2Q8EiJmC7qv/Vqe
 vmXbUa/8dRl5Wtvvw3VKUYLJ+zX7nt4Fxk0e6xR7vo7ABllm2qYr7b+7L+G1vEnqbgoug5fcU
 /nW37m2ZmwOu9aWBrJPWMTJEJDfEgRvi1EipwMUsPUzkv6BgMRyV5WH+IEDhUo5OXL9s8pJpl
 JA+AfhSW3mQoTY0IlLVJIzSufvL2uhFQMf4bJ8Srhr+1VYY/7h9nH8LLlXlHeojIHFfkMVcIU
 WaZr6Vg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 18 Aug 2016, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > Old dogs claim the mail list-approach works for them. Nope. Doesn't.
> > Else you would not have written all those custom scripts.
> 
> git and cogito started as a bunch of custom scripts, too.

The difference is that neither git nor cogito were opinionated. Those
custom scripts are. They are for one particular workflow, with one
particular mail client, with a strong bias to a Unix-y environment.

I work really hard to make Git for Windows as easy and fun to use as
possible. I just wish that we were working together to make it as easy and
fun to contribute to Git, too.

> I see a choice of mail client as no different than a choice of
> text editor.  Neither my mail client or text editor is heavily
> customized.  The key feature I rely on from both tools is piping
> data to external commands.

There you go. That key feature seems to be unavailable in the most
wide-spread email client: Outlook. So by not restricting the choice you
should make it possible to use that mail client, too, right?

We do not even have a section on Outlook in our SubmittingPatches.

Okay, if not the most popular mail client, then web mail? Nope, nope,
nope. No piping *at all* to external commands from there.

So you basically slam the door shut on the vast majority of email users.

That is not leaving much choice to the users in my book.

> OTOH, today, I see people using git aliases all the time which
> look more like ASM instructions than user commands.

I see this as a completely different beast. Aliases help users accelerate
their personal workflow. Whereas anybody who is already willing to
contribute to Git *must* go through that non-personal workflow we impose:
paste the diff in a very specific format into the mail, and don't you dare
use a mail client that mangles whitespace (which is, like, pretty much
every single popular mail client out there).

So *allowing* users to configure their own aliases, and *forcing* them to
figure out how to transport patches through a medium hostile to patches,
is pretty much two diametrically opposed things.

> Users ought to be able to pick, choose, and replace tools as
> they wish as long as an interchange format remains stable
> and widely-supported.

Right. Let's talk about the interchange format called mails, for the data
called patches. Is it stable and widely-supported?

Can users really pick and choose the tools they like most to send patches
to the Git project? Like, the Outlook client? Or the GMail client?

> Even today, at least one Linux kernel hacker still uses quilt to
> generate patches: http://ozlabs.org/~akpm/mmotm/

Andrew does not count, he lives in his own universe.

Ciao,
Dscho
