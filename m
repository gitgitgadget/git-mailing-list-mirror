Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969381FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 12:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbdA3MaI (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 07:30:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:55599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752814AbdA3MaG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 07:30:06 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLvGW-1cZH1q0u0y-007p28; Mon, 30
 Jan 2017 13:29:54 +0100
Date:   Mon, 30 Jan 2017 13:29:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
In-Reply-To: <CAGZ79kaa5WJmZkyFROfkfNb3++t37qAuAebKJTon2iD2bh+sWw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701301328390.3469@virtualbox>
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de> <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net> <alpine.DEB.2.20.1701261321010.3469@virtualbox> <xmqq4m0l64pg.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1701271127520.3469@virtualbox> <CAGZ79kaa5WJmZkyFROfkfNb3++t37qAuAebKJTon2iD2bh+sWw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N5SqJEDwRJh3jsP0wFo6xRDLFpodlDDMqkDbuzy+/jck0v8UlLT
 Zj5+4GARTw1BaKjojIK5R5zMUJtsTWYXd4KziGvdEiFOrjeMnxY9Aa5FhPbruweYHlNMDBf
 xasc6wAbaTTpgv68f3Ih7oItrkvvukXb3eSmFjSMV7tuB7JLk+u9NlFz36cwUB5h1w16BGv
 E8S91251LeBOSH5gOn5IA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+NhEGgQ5LuI=:ng6YuuSdJTMVP/BqJnkm9g
 L7r+tPhnBorwPciXBg4I7PmsqhB+JR64aTLtpR2mWKQlFEucJTzy6YmfC7cNVcbsjk3fhDVYL
 QihjvlIRvnAaXk9+95kehMT1SxQdPi0zJ7Ybs1+uDsvItqd1MxCatb01Di7/6422012Du01b6
 Bffly/dU+4fF3m9v/ZILtsaJLVYRR7nxZqehLJzsT2XoNYJcfkn8wciXg21YanPNq4K4weasI
 l/5u4CWCTw5SFvaqdY9eYyEBSUh9pM5KxAsu+bw8VPUhjz6LlsOG32r0BIQ15vZ9XynVzf9HV
 vOpY3yRoyB/PmWTAtzibB8SFAt9Pe3Dszv8ccpNciLQ2/uo4bm9sqi0oUYQn55f+AbKOJQ1Io
 mzGqHnXtxZlElOaZJ26REKIdhlxHw2PBQgM4PCCmyD+/sVSdxq7NhPEy30ldzA8oiLa8Nf+i9
 63UzL6ftwvnohldZXBEOU4y2R6yQrfC27RnRnfaz5LID6SZNJkBVuSmNC64gkoQgT9Q4UYpnW
 0Pxcz2VbDDrE9r0MowtbH6ri+/j6YyEtD11h27onDTTc+//aLxW1vCCp6texRBOfh7E0UC/RX
 TtIxO77IxNkk0TAJ3+Fhidwfuz90Me3h2NyU6Obg1c88MozDkvSZ9ui2tc3wFG3/3MAuxEg7j
 cl7wMl+96K+16it5JEwljBLAhe3IuppK7z9rQgwONIRoWStNUFg9s7U+KYB1d1Z6swCGm0tFR
 JWQK4mah6cGj10ZOxmSyo3Hmem5QAAFmuixQ2d4cUONWEEqHzNX6KAtq4/h+hedV0UNeXzYJA
 9jHN3E6YiHh0k65oqa8ju5CYpTSqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 27 Jan 2017, Stefan Beller wrote:

> On Fri, Jan 27, 2017 at 2:29 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Junio,
> >
> > On Thu, 26 Jan 2017, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > On Wed, 25 Jan 2017, Jeff King wrote:
> >> >
> >> > v2 coming,
> 
> The commit message, while technically correct, seems a bit off. This is
> because the commit message only talks about .exe extensions, but the
> change in code doesn't even have the string "exe" mentioned once.
> 
> With this discussion here, it is easy for me to connect the dots, but it
> would be nice to have the full picture in the commit message.

I just sent out v3, using a slightly tweaked version of the commit message
you proposed.

Ciao,
Dscho
