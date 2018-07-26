Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00B81F597
	for <e@80x24.org>; Thu, 26 Jul 2018 10:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeGZLr4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 07:47:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:32809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbeGZLr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 07:47:56 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ltr89-1g9lGE2rsD-011Edz; Thu, 26
 Jul 2018 12:31:35 +0200
Date:   Thu, 26 Jul 2018 12:31:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Joan Daemen <jda@noekeon.org>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>, Keccak Team <all@keccak.team>
Subject: Re: Hash algorithm analysis
In-Reply-To: <f5bb91e8-5189-7f61-e018-91447c42845e@noekeon.org>
Message-ID: <nycvar.QRO.7.76.6.1807261221050.71@tvgsbejvaqbjf.bet>
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com> <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net> <f5bb91e8-5189-7f61-e018-91447c42845e@noekeon.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wH3NvVzRatVZ8yefU0akbcYg3/IANhaKvllTuKlXCQFCqJ12AVV
 9PzweGGv6kzDi7HhOPCr09mJRj6PFgjfO4BwpmeUsFeclHQz/PjVTS1nosD+fSqlT7Tc26R
 fjA8K7dGcKYkeAwQ2/7DKwTYtSLMx1v4yTDrgKp5hj2/STTmHyhAhgXTRfEX2rJ72odIMl/
 LohJL1Bvv5KqSwtaXiorg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X/pGBjBlq0U=:LKqMCgDyfrJE2bPmYi6Qnj
 qNgHQdYggtcz79faESOLUhpZB28LxT6AFxoYjNfsc9WxwbyXQng837LHYORCDAd5G4crPMGxO
 yn7fY0cmIWRIbOrk/3kAULifqlnLCrpi5tjKnTAJSbfkRS5R2A+5jrHsx+3DrUefCcySX1DGG
 wKi/mJGsQvS7/iDT3RUzeG65QIV+Rtj7gv/QhEwiKBoFdw1FDH4F1bhEqzngVjMsvUbcEHHL6
 O1yI5tYPJWGqDJKrymHsjTAkEJHC2yhdC/+61y9WoeN8bvbr5O5lQS3OVSBN1thqXWIlQxnje
 nedzhrutqOTVGvfrwi2V/AFX3Bi4suai088h+KbsVynocdwrLwiwiq8yNhq6bHeJsh4+HayTQ
 K7WfOQOwHlgCRYfnGcxjWu1EbNKZ8aBiafZ54Rg8qAaA4e2Rl8iQkwhdpa8G9++K1RexedXXs
 nfMhtwywf1rY0aRil+WbIlRjtv7+Hb/B+Vx64UiVbt1GauXG3+KwYBt8qYmUOUMTF5GDpUEIR
 OuW9xp8u61MO/6xmWadKCUefLjHxZw9qSQxvHtP6wMLJVgYGwU42mROzeT8MaZdg+XlM6XPkY
 IG3wppAnddzVvAnkiKjymkKeZfcaWRidO+ZEos/mYzxse0cAUQ/bwDJwg/FReRQtg8EWLgtaj
 fAIzOKRR2YFMxF6nhJJiHkVqyMdNM3uklh8MpK4LiIWY9uoESBgjc20Fw8AYr56v6XmF4mvox
 AsiOXVmWiX3X3KhQEsNq9zJoklb8uuHmS/72AmdrGPXZqYXGlo38RsCKOBb6VRMUYCskwIJFr
 Kzs+3vS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joan,

On Sun, 22 Jul 2018, Joan Daemen wrote:

> I wanted to react to some statements I read in this discussion. But
> first let me introduce myself. I'm Joan Daemen and I'm working in
> symmetric cryptography since 1988. Vincent Rijmen and I designed
> Rijndael that was selected to become AES and Guido Bertoni, Michael
> Peeters and Gilles Van Assche and I (the Keccak team, later extended
> with Ronny Van Keer) designed Keccak that was selected to become SHA3.
> Of course as a member of the Keccak team I'm biased in this discussion
> but I'll try to keep it factual.

Thank you *so* much for giving your valuable time and expertise on this
subject.

I really would hate for the decision to be made due to opinions of people
who are overconfident in their abilities to judge cryptographic matters
despite clearly being out of their league (which includes me, I want to
add specifically).

On a personal note: back in the day, I have been following the Keccak with
a lot of interest, being intrigued by the deliberate deviation from the
standard primitives, and I am pretty much giddy about the fact that I am
talking to you right now.

> [... interesting, and thorough background information ...]
> 
> Anyway, these numbers support the opinion that the safety margins taken
> in K12 are better understood than those in SHA-256, SHA-512 and BLAKE2.

This is very, very useful information in my mind.

> Adam Langley continues:
> 
> 	Thus I think the question is primarily concerned with performance and implementation availability
> 
> 
> Table 2 in our ACNS paper on K12 (available at
> https://eprint.iacr.org/2016/770) shows that performance of K12 is quite
> competitive. Moreover, there is a lot of code available under CC0
> license in the Keccak Code Package on github
> https://github.com/gvanas/KeccakCodePackage. If there is shortage of
> code for some platforms in the short term, we will be happy to work on that.
> 
> In the long term, it is likely that the relative advantage of K12 will
> increase as it has more potential for hardware acceleration, e.g., by
> instruction set extension. This is thanks to the fact that it does not
> use addition, as opposed to so-called addition-xor-rotation (ARX)
> designs such as the SHA-2 and BLAKE2 families. This is already
> illustrated in our Table 2 I referred to above, in the transition from
> Skylake to SkylakeX.

I *really* hope that more accessible hardware acceleration for this
materializes at some stage. And by "more accessible", I mean commodity
hardware such as ARM or AMD/Intel processors: big hosters could relatively
easily develop appropriate FPGAs (we already do this for AI, after all).

> Maybe also interesting for this discussion are the two notes we (Keccak
> team) wrote on our choice to not go for ARX and the one on "open source
> crypto" at https://keccak.team/2017/not_arx.html and
> https://keccak.team/2017/open_source_crypto.html respectively.

I had read those posts when they came out, and still find them insightful.
Hopefully other readers of this mailing list will spend the time to read
them, too.

Again, thank you so much for a well-timed dose of domain expertise in
this thread.

Ciao,
Dscho
