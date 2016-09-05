Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DD220193
	for <e@80x24.org>; Mon,  5 Sep 2016 07:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754935AbcIEHx5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 03:53:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:62391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753280AbcIEHx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 03:53:56 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MEWPx-1brX983f6v-00FiEX; Mon, 05 Sep 2016 09:53:31
 +0200
Date:   Mon, 5 Sep 2016 09:53:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Fixup of a fixup not working right
In-Reply-To: <8F7471262D1C45D9A7BD1C29277004AD@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1609050950130.129229@virtualbox>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>        <55512A8927384A0790DDC7F526B09053@PhilipOakley> <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609040923390.129229@virtualbox>
 <8F7471262D1C45D9A7BD1C29277004AD@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7U5mUCqrhKMOLiVvdW9AxV1/mdxkbqFfbCbrtzHMp4SEJnDdYSa
 SsBc1BDvnz1bzBQaX92I2XIz3kDhAg1EYJCeWjV/YyAG7c5s5X/XOmtFYrD1NSLGfJ8J061
 hr+IAjGihvcnnSigTz/pfkJPTMQqtlUUNVn5BARQJRG2fTZcRq1EKTbFApskC/lFI6bll8T
 GKc4XDabS6wvPCkPTMbDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qD9mnihS6AM=:LFStbvE07RuZ7HnIXEewQ+
 jQB7Nr+kFkYnq4JNddDcCOtH1djpdttYjOxv71p2EtNznrpQ7T31/qZUTQpDxubOcF+JSIQki
 5p1Jg3Tmls3ho7Y+orQN0waJ8NQfgf9vSpILY5XB2YW1+ouKNpch4+HmMIQTLa4XSv+6gNtYR
 b5+XBsxWZYQBZqM/txq350J/q1KfHGoCJXnNuelC8TTRdZ1UvvmKXOjU/yZjxk7CATOcYzo1K
 f9JB/unfWOYkTadpilLF0b6zc0JqO90NeUq9rHWVGhDExjKqJPHlFoVqms8AUERKLwfwWP4yh
 R7RYQ79D94elH579Ps1Qz0gA2LLINW8SPJLXF1LGePkSh8oZKQ8vMlE5Qum/jLWBeP1d22tqB
 Unbv6N1fZAHiLY94QVODYRys5ALt3+pAwRxvM7udAbe/XVLbpye4vKjJRvBlcrN7aaJMqMM/N
 i54E5FQiFvHRHN2MTtwJMhrFMP688hIrYonlkwU69+pMtg2NRQ7/vERzXy3c10N4yPezdvAXq
 fDxSyD7g3UctlpARPQtKLmMac7/wXCW92xs/WlA+sZ+1o6c+O0JfYUhNedZMzyfD9fKFlC9iI
 SPY4iUHF+zJBWFHFCf3Zx1Tpg3SAev383jCF1LoPdMS7AoTn8j9sdNnC1cawNTDEr3RbDLhUL
 SGkGfaGmJwxgJJzpGJAEOzW5ZqZMawbU/W7b0q7ASVFiPPk427DrfkMorjigPnb22WCX6EEC5
 6uMkH3CGTnjLC6LJU4fDQfn4tuhN67lSNXvcRfX74K+xWV8FGX8jTIUoSA7l1QT2rUOGQo4hc
 bToyq7L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, 4 Sep 2016, Philip Oakley wrote:

> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> 
> > The point is that fixup! messages are really special, and are always
> > intended to be squashed into the referenced commit *before* the latter
> > hits `master`.
> 
> I think it's here that we have the hidden use case. I agree that all fixups
> should be squashed before they hit the blessed golden  repository.
> 
> I suspect that some use cases have intermediate repositories that
> contain a 'master' branch (it's just a name ;-) that isn't blessed and
> golden, e.g. at the team review repo level. In such cases it is possible
> for a fixup! to be passed up as part of the review, though it's not the
> current norm/expectation.

In such a case (which can totally arise when criss-crossing Pull Requests
on GitHub, for example, where a Pull Request's purpose may be to fix up
commits in another Pull Request before the latter is merged), the most
appropriate course of action is... to not reorder the fixup!s prematurely.

> > In short, I am opposed to this change.
> 
> It's not like G4W doesn't need fixup!s on the side branches e.g. 5eaffe9
> ("fixup! Handle new t1501 test case properly with MinGW", 2016-07-12)

Yeah, well, Git for Windows' `master` branch is special, in that it is
constantly rebased (as "merging rebases", to keep fast-forwardability). I
would not necessarily use Git for Windows as a role model in this respect.

Ciao,
Dscho
