Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEC61F453
	for <e@80x24.org>; Tue,  2 Oct 2018 13:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJBTpd (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 15:45:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:56677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeJBTpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 15:45:33 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN604-1g58SJ07vk-006cLN; Tue, 02
 Oct 2018 15:02:03 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN604-1g58SJ07vk-006cLN; Tue, 02
 Oct 2018 15:02:03 +0200
Date:   Tue, 2 Oct 2018 15:02:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
In-Reply-To: <3b2f13c5-c315-7156-5126-8f469956d645@drmicha.warpmail.net>
Message-ID: <nycvar.QRO.7.76.6.1810021501420.2034@tvgsbejvaqbjf.bet>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net> <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net> <alpine.DEB.2.20.1609061827290.129229@virtualbox> <alpine.DEB.2.20.1609061839370.129229@virtualbox>
 <alpine.DEB.2.20.1609061843120.129229@virtualbox> <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net> <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net> <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com> <20160908200305.okeeh35xmrvcveyg@sigill.intra.peff.net>
 <xmqqzinidqfi.fsf@gitster.mtv.corp.google.com> <3b2f13c5-c315-7156-5126-8f469956d645@drmicha.warpmail.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uEx2GileMV7XifInjZw05OgmlYjk3mFD3ej11W0Nx9ACV1Er11B
 qjUATIyfiMfDcMX5Ra6lDBXp39yoshOfzjuLEzyglcK/EZtMzBWT5lFgApQMTKqPBPs3LSQ
 1LQ9LvCifK4OkLmP8Un0/WkhEFWgo1gyLCQzBfLDkaja33SusH5VL96E2h+if0H8EVjMbCP
 xO2jdbvY4bliUXcyTMKuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dPA8NKQB7fo=:w2oyZ1ebWUXl+XU4T07+Fq
 kMn3GV12NPXInk+oKW0KnK9YAUPuN9nXGz56R0egmHD0pQdRMy2j9nmP1SLRgoSctL9liJc1m
 OVd0IaLqUfqN6Q8yS3nFwqBvp4QkgDeQPgIVY4uoqlpJzPLZ4/ngwYrqR/W8mihdNyPjgLI7s
 1A5K1Qa68/j/VWUDPzwMVZZRsuTyIg+A1aXTzF+TFKA7LBW0bUHQ631zbKrk7q1X/iACKsVZ7
 EbUk5GSZO3ZYqBzGFnsHJfyxXqQg6YSBBnn5jz+2Xxl85zro7Xz4Y4hatsuLgRHs3KqTd8XdS
 qo+0jeqtcWVkM5gXXDfP/n+OdfLZhwK52TUZs6thmt9FgBsjlHFfa7Bs7VfxBXnKLb5oRtdTx
 bHCcT/UBl9fcvdr7Ct2mGWbJF5xkJ8qy8IoFKBRgiNNrfS/yScOOFL4G5qTwACAK+zHirCJvL
 uuU4DS71Ic684ZLu15C20zpWZooqDPof03ZYYqhCjKUJ4c3A0TllcHr635Sbx/SryscJp7QLg
 W1zK+wzecLGmodFzX3k0Gg63Gz2yhvZgHIy4+d3wVTFeV52chN2nPNMTLx2g5MJVTMUbuLdr8
 kK598xfi9lpEV7MyTh3pq9TTIf4wBnEHEz44fy/2ZsfRHkd09ue3qhCt+Ljbui04EdfFKTfgH
 ldnn5NC6/Lrh189QFC81cVjQNSp9+3A5Uk0zyxHY5Y1xn/GDTsOYFWD2y4q/plQyy6qaIN2LY
 PN9V6+xg4krxEUqRY94mNngoDy/i0gKAuj9EddN1zGhqtyJgZqAYfOQF/WTWOau3JZNNsTZs8
 PfPDf75H5mCJtpj+mWTR4TEFheSwRYN2uw/jhxmKQmchK38Hu4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

[blast from the past]

On Mon, 12 Sep 2016, Michael J Gruber wrote:

> As a side note, I'm wondering why MSYS-gpg version 1 is bundled with
> non-MSYS-git.

Those are two questions:

- an MSYS version of GPG is bundled because it was the stable one
  available at the time when I had to decide: in summer 2015.

- GPG v1.x was bundled because, again, this was the version bundled by
  MSYS2 (and I have to rely heavily on what is bundled with MSYS2 by
  default; I could not run Git for Windows if I had to build all of the
  components from scratch, and maintain them, in addition to Git
  itself).

The good news (ahem, see below) is that GPG v2.x is now bundled in
MSYS2.

The not-so-good news is that this can break existing setups. My own
setup, for example, was broken by this under-announced upgrade.

But other things, such as GPG-signing commits in a rebase, should
actually be *fixed* by this upgrade, as GPG v2.x has a working GUI even
on Windows (in contrast to GPG v1.x, as shipped before).

> It's an honest question - there must be good reasons for that, and git
> should work with gpg 1, 2 (maybe) and 2.1, of course. I'm just trying
> to understand the situation, and the question goes both ways:
> 
> - some Windows user(s) in the Github issue apparantly had wrong
> assumptions about which gpg they're using (via git) - why bundle it at
> all?

It was bundled with Git for Windows v1.x. Skipping it would have meant
regressing existing users' setups. I am not willing to do that
willfully.

> - If bundling it to get a known working setup, why not gpg 2(.1) which
> runs gpg-agent automatically, giving a more Windows-like experience for
> the passphrase-prompt?

Again, this option was not available at the time.

> On Fedora, with some things still requiring gpg 1, gpg 2.1 installed in
> parallel, things can become confusing quickly because  of the 1-time
> 1-way migration of the secret key store. It's probably the same on
> Windows with those two gpg's used in parallel (and probably answers my
> second question).

Well, to be quite honest, I am still not convinced that GPG v2.x has a
truly Windows-like experience, as it does not integrate e.g. with the
Windows Credential Store. But it is understandable: traditionally,
Windows and GNU-licensed programs were at odds. I think that changed in
the meantime, so who knows? Maybe GPG v2.x will sprout support for the
Windows Credential Store after all...

Ciao,
Dscho
