Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8291F453
	for <e@80x24.org>; Wed,  7 Nov 2018 11:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeKGUzw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:55:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:55913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeKGUzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:55:52 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXIGf-1fziR82RL3-00WH1b; Wed, 07
 Nov 2018 12:25:51 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXIGf-1fziR82RL3-00WH1b; Wed, 07
 Nov 2018 12:25:51 +0100
Date:   Wed, 7 Nov 2018 12:25:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Windows: force-recompile git.res for differing
 architectures
In-Reply-To: <xmqq36sdcl9t.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811071225230.39@tvgsbejvaqbjf.bet>
References: <pull.67.git.gitgitgadget@gmail.com> <87794514ef3a83f95d81f89287b81aeed5c92296.1541516148.git.gitgitgadget@gmail.com> <c4e3790e-4c41-0d15-38d9-79fa288fb9b3@kdbg.org> <xmqqk1lpd65h.fsf@gitster-ct.c.googlers.com> <ad98ab16-c6bf-7294-f498-d0e7295105fc@kdbg.org>
 <xmqq36sdcl9t.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VpkoxolDUC1Bxtz2umHBVWfOQnfFqqV5DQxoM1VTP1h7MCDDZPX
 A3CrRM10IT4zi2x7nkglD593OSIr4RnwH5i/p2zIau5iCpqwcA1bb+DbLHPu5UUmWvoKsxG
 j0nijmI0Hjfb6J4UXNIbN/tXVgqgQL5SuYIagZSjLz7uWFhg2URFOhEUsZbQUXr4EfFF6sZ
 EKMjij28StfYfqnfle8/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T8XpkBymLhw=:izR9wUyLCakXyZ1qRAIzeP
 WberfdFNzQC3sJ/BY4owB6Mb7NrNHKMUV8pXUh0xc/VzohaQkQpTuIHFhhepjt6EnYbl/+wNp
 hF41dSNVORPoj7MmFR2zweOgM3QwTHiPQcLgrkVcHD5rvGz7pEx8ecVxMgp3n+fGr8e7B48Tl
 sko55AwyUUlZaWMAcblp7Q29f3ASimig2I9jz34x0pDKUpoUVh07rnF3SszaXhWFqT/E+hhZ2
 LAp4ss6HIJ9hD1iNyUQ+vaqreLXfy5DUhTfBqupWX+Cfy9ZC/nkKbaMJPLsQAZkN8582d0osT
 vYuZ1QdyuPQyvoW28eYwzVliiX3WMpo4KW+GSld9NCc8baky6uADJvfmLQBHVtx/1bZ1LYwj4
 vf6ioiDam0eRdCS/zcyG/SH+57gY7dCbRmaHStXtUZiMzjiiA2lmtiavgdQNU8Ln3PB8KuJSF
 UYklg5M22fIdz1oKgJnzB4kXmjf0+xjY3Io1qBy4/euWDhoUIXTRN3m9UpOoFOFkfsYf2j6m9
 dP6EUOAO+eDRDSLXkCpuzDzg61DCVvlLAcBl+r+brZ4sponRkwQvyDpWmOp2fwxcqMXllYZq+
 sX1pbAUzT80Lq9JdQrH63crFvbZxLNYFzPt+siX+xNKEYgNcL7SDPFWgXTJOsGWuwRqo9Z+zH
 xZ3aCglRSQwQ62fHfWKQE3tpgI93/VKgCxU7X9I6PipnVh7CXrAiEwXP1meG9rdiWJpbkyn+J
 OG8TgqvDbUmpxOxWHelC1nth8JWlve6tc/3z6/Zf8OKHgLDffZcK/sJj7FjX/iC9gs79tMpKq
 51UXIUFut1VLRzcEWDOyDksAfahdklFvTnQRFvAI0otuYiwM+Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 7 Nov 2018, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 07.11.18 um 02:32 schrieb Junio C Hamano:
> >> Johannes Sixt <j6t@kdbg.org> writes:
> >>> On Linux, when I recompile for a different architecture, CFLAGS would
> >>> change, so I would have thought that GIT-CFLAGS were the natural
> >>> choice for a dependency. Don't they change in this case on Windows,
> >>> too?
> >>
> >> Depending on GIT-CFLAGS would have a better chance of being safe, I
> >> guess, even though it can at times be overly safe, than GIT-PREFIX,
> >> I suspect.  As a single user target in Makefile, which is only used
> >> by Dscho, who intends to stick to /mingw(32|64)/ convention til the
> >> end of time, I think the posted patch is OK, though.
> >
> > I think that it's not only Dscho who uses the target (my build
> > environment, for example, is different from Dscho's and compiles
> > git.res, too). But since the patch helps him most and doesn't hurt
> > others, it is good to go. No objection from my side.
> 
> Yeah, that was phrased poorly.  What I meant was by "only by Dscho"
> was "only by those who share the convention that GIT-PREFIX is
> changed if and only if targetting a different arch".
> 
> Anyway, I just wanted to say that GIT-PREFIX may not be precise
> enough but would give sufficient signal; GIT-CFLAGS may be a more
> cautious choice, but it may change a bit too often ;-).

I am fine with GIT-CFLAGS, too. Do you want me to "rick-roll" a v2?

Ciao,
Dscho
