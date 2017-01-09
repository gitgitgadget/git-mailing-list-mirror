Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B796420756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965070AbdAIKuY (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:50:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:57407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965056AbdAIKts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:49:48 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN748-1cOLfN3qMC-006c2a; Mon, 09
 Jan 2017 11:49:38 +0100
Date:   Mon, 9 Jan 2017 11:49:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
In-Reply-To: <xmqqy3ylx75g.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701091127570.3469@virtualbox>
References: <20170108061238.2604-1-svnpenn@gmail.com>        <alpine.DEB.2.20.1701081250580.3469@virtualbox>        <CAAXzdLVXUdCAcJL6DratNwLFUSN4UAV+TmALSZe-zSSTAJcWWw@mail.gmail.com>        <alpine.DEB.2.20.1701081953330.3469@virtualbox>
 <xmqqy3ylx75g.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Uhqne6yW7PmVUQxbzzhRYXdoehpBjFYJSFilw3MQQKwuC7dWgIw
 mHiE02cftgkfIFGFN75PbV3HfX4BlRbkehk4MjT+Oa/BEcud+PxiQca6PN33vrwV25tWWBu
 F4da4FM7Jm4CkpSRlrcWcvHr0FIPKk3UlLdV01KWhaW304dbFXpvTtBXYuGBQNGEcP4AUPF
 BAvzhNppKn2ocpHgKTNCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rV2Y8FpZ6mc=:W7TcTcR30LqesnznDw8A7B
 oacKVYglIg54G0iodylGsTeTs3hvsXreCuFjm8ZxTHChn8el0cFNNq16DIGP85T9ObM2qjJRb
 cwvpbQdYESZAF9xIWX0V/7ig6na5n3OjXKH8TblinnYG/pAaFXjwBlEMlJFMtrw0HGns37Fau
 07b+9avRZMo/mB2+3ZP5uJIM8y3zuS9D7PjjtT3DoG7ab94aVetyh9TpEUlXB6leAtqySsWLq
 fM8P+cYfPyPan+NZxWq0+W272B2duGoAJD3Q+3ZCx/zJXrscqjaD9R65W7BdNfGb4BcY49akb
 g7MnHV2Z+G2FZ36Mkiuqtu5WtszUhmgWb02MOEEIhws0/qJQvLvoAlIzSexJ1R/VZmISTJijF
 TK+HyJU2RLG7ajD1AcnvrW7I8cXLIfbnXsukiXMRVdU61FWb2FEGsj9YiPP+oTdEKnS4D/Qzc
 IoXhEBiy9T+gI+20SFH92Kjv0+5UzGqKoYxJH4qkTQkfMGb+opHoRMSlhdAsIyIfjrymrm9bp
 fpY/j8qWPs801Umru+S0tIbSpv7qCk2za92VHfvwfogBvxQp9bALPNaFAWDCxHiGu8OYh56iq
 mOFWTEm+PqdDZ0v8a8epIIz+saAEGlz1S6T1rbDvDNuhC5ziBeYD66L9BvP0Lak3qpyVcuYrz
 LZUyLMYfmDyoGGqyiO7W2V3at2RP4auz0yJTclHYcHJTCZp60Zc5oFvPkOZI//BQ3q2dYWQdN
 V5GkD1Me51AkHOIXq+H7/wFs4Cyj4A8ilE4U+kzYdx/Slug0rCL4jbuKJtR0LxBrnuuNNnV7p
 c2NXcUBWL3WOg9cqZPJIsAldowvBwr3RaUtkgG4HeNzfObj12EW5quKB7a77n6lzlid3+auQ0
 1KnkA65flFU8WjXyejoulaMaKh2OTV1k0faX/homrS+rInzsg3hLps46+WNBUzPhhXmjpBNUD
 WZ3wJq8YBrmPaehM1eQb+3Pf0cfpTbJNZU4WawC2/NHluq4/3CHZ2To3Yhmi5ERCRDoervwcz
 f4QPz7w0oDyZ+c6DukKEBQoR71omBqNJReYaDARzvmn4feSIzYo+CDXk7axc5jD9JQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 8 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 8 Jan 2017, Steven Penny wrote:
> >
> >> On Sun, Jan 8, 2017 at 5:54 AM, Johannes Schindelin wrote:
> >> > I am curious: how do you build Git? I ask because I build Git on
> >> > Windows many times a day, and I did not encounter any link
> >> > problems.
> >> 
> >> My end goal is to build static native Windows Git via Cygwin and the
> >> mingw64-x86_64-gcc-core package.
> >
> > That is certainly a worthy goal, and I would highly recommend to
> > mention that particular cross-compiling setup in the commit message.
> > It's not like this is the easiest way to build native Git on
> > Windows...
> 
> In addition to the patch being explained well, I also care that it
> does not break existing builds.  I do not think it is the case for
> you, and I do think the patch does the right thing, but just double
> checking to see if you have objections to the change itself.

I just double-checked and it still builds fine on Git for Windows (as
expected).

The reason it seems to have worked before, too, is that somehow -lcrypto
does not require gdi32.dll here. As a matter of fact, we do not link with
gdi32 at all:

$ printf 'include Makefile\nprint:\n\t@%s\n\t@%s\n\t@%s\n' \
	'echo all: $(ALL_LDFLAGS)' \
	'echo libs: $(LIBS)' \
	'echo imap: $(IMAP_SEND_LDFLAGS)' |
  make -f - print

all: -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup
libs: libgit.a xdiff/lib.a git.res -lws2_32 -lntdll -lpcre -lz -liconv -lintl -lcrypto
imap: -lcurl -lssl -lcrypto -lcrypto

It is a bit curious that -lws2_32 *does* only show up in $(LIBS), but I
guess it is simply the fact that we use a newer GCC (gcc.exe (Rev2, Built
by MSYS2 project) 6.2.0) that allows Git for Windows to be built even
without this patch.

In any case, it does not break things, and it helps Cygwin, so: ACK

Ciao,
Dscho

P.S.: I pushed this to Git for Windows' `master`, too:
https://github.com/git-for-windows/git/commit/f05a26948b
