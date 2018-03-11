Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976A11F404
	for <e@80x24.org>; Sun, 11 Mar 2018 15:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeCKPrZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 11:47:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:41479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbeCKPrY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 11:47:24 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCPhl-1em0eL2Lej-00982E; Sun, 11
 Mar 2018 16:47:16 +0100
Date:   Sun, 11 Mar 2018 16:47:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com> <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com> <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com> <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3f57nFz7ZwHY2PGjcTgwiVydLsIrqV+hmc2+UTFm6j9r4qSbAmv
 uLTVKTTsdtDj18wISKk6CJsuUlLpJtsCzoQFhps00XAqAduE9bXlg7VJ2PnJRxPg1rOrJ2k
 kng5qzU0d+5G8AnZ5SnjTY2FprFhQ2wBrSVZmMZWixdV31Xqi59zkWv9S6e7Nn2S3S1kuyh
 kUyc+gbd0FKO6d8V8L3zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RYAnZLqezdw=:OzV1zLuO/HL5tKNlJDIkaS
 4tG+y82AL/ScR8emdP/TZAdCAV1RRTTBTLksRg6Qezyt8B96iur4z1oWRPQR2QedDguI9becu
 iEDu+tMoe4TvLZakJgj59OL0uoun5Exe7Vj1MwKouIpTIaL2x54jeukyqqGKKSIn5H2Hfm+l/
 x2tpDFs6YKRLWbhyT9XWWg8as1Epbi/8L2+b0dgJnXiUrI2BO9+JRviVkye5Cspse8akgc0bb
 zV0+YPMpMIX0PcBn1wiqCv9wqgl1X0c+1kUgXpaFqv+1NyYHX85iRuY1shGTx7Gpy3rFy53XL
 tIodhS9I4zucibBIaiGK/bvyGES4y2J6eQk4ueemHISrwjBcTza5Wy7fxr/uFKz3Pp4Vs0D+L
 gF0FwEy58RP5CmyN96LxuxXGjgiBvEztQcFlDEsulV+f33itf5bqpkWwd2vGgIOCdeUk3f605
 c6yBIkI7Jk8ozmpNhdpbLt6fkzHQRKCxAB1cVzlBiDZ6vQaHZFcnilfo8TUXFIQQ5aigao9Vy
 3ZpFW8WNy7t4K0wYvC0GVR8wtE0kitAwWl62DQDtMzCWUcei+n2O2WXtxQSX8s80G3ais0sTi
 wspfdf0/YTo+q9pTlmkZP0A8vXoE4uo0LlM58H3N0SRgJwbi/aH5ak7g9PmigbdRBf0uCSP+i
 DzSAtHTir7l1uth8f1DJrNBaeM5wG2aExFimKbC9yET898xc1y4g9L9QIoannhn8p0xEGSMAm
 KfDbeAgBD0ww5CDTYT5OxNrb0orQKtuI7aCvZ6k2C72R2xVIoRsLuyK+SSiab0x4z/8sn1ogd
 Q2CU4Zstq3mvO5VL5Q3pLfxkfiauRIU+TsKnJu1C69cTShqkAscZLkyG+49vdq6JY/1Xjfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Fri, 9 Mar 2018, Igor Djordjevic wrote:

> On 08/03/2018 20:58, Igor Djordjevic wrote:
> > 
> > > Phillip's method is essentially merging the new tips into the original
> > > merge, pretending that the new tips were not rebased but merged into
> > > upstream.
> > 
> > [...]
> > 
> > Here`s a starting point, two commits A and B, merged into M:
> > 
> > (3) ---A
> >         \
> >          M
> >         /
> >     ---B
> > 
> > 
> > According the "patch theory"[1] (which might not be too popular 
> > around here, but should serve the purpose for what I`m trying to 
> > explain), each merge commit can be "transformed" to two non-merge 
> > commits, one on top of each of the merge parents, where new commit 
> > brings its original merge parent commit tree to the state of the 
> > merge commit tree:
> > 
> > (4) ---A---U1
> > 
> > 
> > 
> >     ---B---U2
> > 
> > 
> > Now, we have two new commits, U1 and U2, each having the same tree as 
> > previous merge commit M, but representing changes in regards to 
> > specific parents - and this is essentially what Sergey`s original 
> > approach was using (whether he knew it, or not).
> > 
> > When it comes to rebasing, it`s pretty simple, too. As this:
> > 
> > (5) ---X1---o---o---o---o---o---X2 (master)
> >        |\
> >        | A1---A2---A3
> >        |             \
> >        |              M
> >        |             /
> >        \-B1---B2---B3
> > 
> > ... actually equals this:
> > 
> > (6) ---X1---o---o---o---o---o---X2 (master)
> >        |\
> >        | A1---A2---A3---U1
> >        |
> >        |
> >        |
> >        \-B1---B2---B3---U2
> > 
> > ... where trees of M, U1 and U2 are same, and we can use the regular 
> > rebase semantics and rebase it to this:
> > 
> > (7) ---X1---o---o---o---o---o---X2 (master)
> >                                 |\
> >                                 | A1'--A2'--A3'--U1'
> >                                 |
> >                                 |
> >                                 |
> >                                 \-B1'--B2'--B3'--U2'
> > 
> > ... which is essentially this again:
> > 
> > (8) ---X1---o---o---o---o---o---X2 (master)
> >                                 |\
> >                                 | A1'--A2'--A3'
> >                                 |            \
> >                                 |             M'
> >                                 |            /
> >                                 \-B1'--B2'--B3'
> > 
> 
> Having explained all this, I realized this is the same "essentially 
> merging the new tips into the original pretending that the new tips 
> were not rebased but merged into upstream" as Phillip`s one, just 
> that we have additional temporary commits U1 and U2 (as per mentioned 
> "patch theory") :)

But if the old tips had been merged into upstream (resulting in the new
tips), then the merge bases would be *the old tips*.

I am still not sure for what scenarios Phillip's strategy is the same as
Sergey's (updated) one, as the former strategy can do completely without
temporary commits, and cannot introduce ambiguities when rebasing the
changes introduced by M (i.e. the "amendmendts" we talked about).

Ciao,
Dscho
