Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661141F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 11:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeCZLuV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 07:50:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:52239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeCZLuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 07:50:20 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfiFU-1fEdZB2CTk-00NAeK; Mon, 26
 Mar 2018 13:50:13 +0200
Date:   Mon, 26 Mar 2018 13:50:31 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <87r2oph3cj.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803261348410.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae7ykys.fsf@javad.com> <nycvar.QRO.7.76.6.1803080746460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87r2oph3cj.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2yyetcEon+t97NHGPlmYZcYLXnZ67kUUGcKPC2IRL3TRhwkAw4n
 py5tiZirBCRK8RkhMqzuQRn73S2kJUQWCMUaPTFhqxS8mVOihDgFQuMkioHKTs3MgIMiREi
 nMVZvHqk0GUGVX9nUHRCkFhulEAwo7zB9Xrb+PgboVf46ccktXMjrX3m+OmJ4l7wp+2fsVb
 eTynO39lcRMWZmv+wihvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A4/SML+ZE/c=:PlkePCxKYXIeseVBZp2zi2
 nieC2a2nMaTB+5CooHLdThKW8Xxy7FeiekcXy77ucGCL5i6uqS2+yTtjGhEhMp13s9qvrLJEM
 leX0vk8CoH0SSpNTUQJ/3osBLlPK5a8/xYXOzs7xuzsJZmHqLMvUw5CoPaw8ThewcbiY1E069
 EdSeQH+mP4ouY5+95s9+gvVOa68j7qOBT+jsMbaR0AnKIvnRm6r8XOe71DOoyYFioAZvFINib
 ixRcz5sdRWnK0oD2KAScU/NLx7cHkceASpEsttFGpv/KwySjOi4gJBASsQ8dK0+tJBWSwkqzO
 bFoJLcH+MrXXhdmnrKjQiVpBgfN8hBddZQQAblTqO76FH0NyQF6oaUOh0/cSK47KHwb2b7Y3Q
 Yq+G63ML4LM+8JdvjI8KBh/JjuoRWGtmJjLMT8B+Ix7x/JmXq50hnAL7bZ1Q7Sqr+cY37MOpa
 0aiXMyc/RirYYZWb5NVSLKKTqMNShGlB/PXD/R5Vm5eO+3LS33iqHqf6d8G6JGq+baE1W5Jfn
 ibPpGPuiDn/x2Ru24keaR9hTeSsdXdb9vcP6IJn0xMmAxxZ89dK5t/hhQrD5afJFKGTFI5GP2
 gWScme6kYNveoC7RhzzvHqNSAGg+cXZYu83rTeSq5TVIgxkjZEGeXSym5lWV2lVi3ky0rgpfM
 qcF9zBegXCp/ySzyHIMzzkdxSdjHgPLYu5CpCFgYWSdC5uEeHqj0N9ujcCWHh820x1bARcWSw
 5BSD4/xJ7QwesAijGwfXcEN7kTOWtPpQkuH7XVBU7sK3ChL1hqtoJa7LKUcUnkBAtFN4nSzQV
 oW+w8ugRk756B7SPMeZuFE4Tf7I65DwD4fwX+CzFWmksav+gzt94mINQC0V7HfO36/RPp6O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, 12 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Hi Sergey,
> 
> [...]
> 
> > That is misrepresenting what happened.
> 
> No, it's you who are spreading misinformation, probably unintentional,
> but still.

Way to go, Sergey. Way to go.

> [... more of the same...]
>
> > Let's focus on that strategy rather than going back to the strategy
> > which has known flaws and only an unsatisfyingly complex explanation.
> 
> Not that fast, as it now has no known flaws and still has surprisingly
> simple explanation. It also has its own niceties that are currently
> being discussed elsewhere in the thread.

I find it surprisingly complicated. Of course, that may be just me, but I
am not exactly a noob when it comes to interactive rebases.

Ciao,
Johannes
