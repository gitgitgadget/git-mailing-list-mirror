Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BD220966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdDBToD (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:44:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:64022 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751240AbdDBToC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:44:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MY4Ls-1cYiHH01E8-00UtwG; Sun, 02
 Apr 2017 21:43:59 +0200
Date:   Sun, 2 Apr 2017 21:43:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC] Proposal: turn git-add--interactive.perl into a builtin
In-Reply-To: <CAEA2_RLX+0Yz-wcdAaEj3Pp0qOKWdHu32T9Vvkk2KSFkzUx7Cw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704022140420.3742@virtualbox>
References: <CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com> <CAGZ79kbyW79wToWqoL_F5n+jOFwFH=z2jY3Du2YTyv9tS9L=JA@mail.gmail.com> <alpine.DEB.2.20.1703300142230.4068@virtualbox>
 <CAEA2_RLX+0Yz-wcdAaEj3Pp0qOKWdHu32T9Vvkk2KSFkzUx7Cw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PZaMX2HFiBx4IYgI4rHdCf3mJvgSncyZdu+R70toJJ3iIiZq3u7
 +Lrmne3b75R61oiA/MZYfiqon2lmxxzLX3Fn00hi7qmL1+9m2XhxjbDGXlCX/Lpm0Tb7UwZ
 OKuLfQc7jSkxJ3j/sebbqmLGiDQcvAA1m3YXijwZoQBLyEhkrqgHR2ZlVdlfF/f0el++OYn
 7xJyJoNi705+nCGnJo/Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i9zA7MLH4vs=:9uV87Is5P0Lzy8fTk0a+0b
 KdkEOw8t6cQxEdp5xLdywyV/TkzT3J7r6QSTRChgZlvhawL7SB8z+Yn1xpQwzvem4sgvMQrgP
 CHRq2YafZQ7v9JrHBcGqGAW8kKQzAsXlWMF37VudF065hZOzWk4Hi/3IaioIu+YqPN5Vh2V9Z
 Al5Q9kOBliF+LLHQ7dwF5+krz75O6FDp+bphsmP23MrCjvzq8DTcSVli5zlVMuCewUXQeoMa0
 T2HDVn+WdBe5P4J6nvbL8NEpGkB0/RVy7wYhchzfnBPL2RF9aS3avbzjBklVgnrFgEqLL3Ui9
 RdnROLB/N+gb40450okCk2G2NCCe0+EaiDxC0FqKiQh5cSq30YJ9NEBnUOAxDLJX7rcSM1Sba
 c0WoAHApMlRLBfpW6BmZafCwLPV6a78anS6jDzyIZ3nEuRQR6EYwTDuWHAPZdAM4wTxKRMdRe
 b42oe83B8VJl5vcjrbJXLnqEfZVn+pnfRhFNegkRj0u12FEigUxw1dA8UNVj3mHvEximQTxCb
 4VgT0EGe4Cg+cL0l1I1vbAHbqGoHzmzrO9HvmruaIcDusubNdzF2ijBxq7VfDmKHFBxG5Lhyn
 6/do8xuYYQsbSkTMeQdVs8FStLtfTZ44izcGrJKJmL52N9YjLT/3elmVNfGAVjav4WRew9iin
 0u7xGcnqiYdGKKaVoH1o6Nh++OgmdUUm4rf9S1sj7pIf8Xe7A3vGeitXWvUXjS8aEdqoUccHp
 OF3Wp3N+HAwTHS5n1D3pKEpudGLKQy/w8ek4fZ1YXcJiblrC0aiTUvBNOQjuBvrbFUyvoxkcr
 /vxXSgQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Fri, 31 Mar 2017, Daniel Ferreira (theiostream) wrote:

> Question: do you suggest any pending bugfix to git-add--interactive or
> to something related that might give some useful knowledge in advance?
> (for the pre-code period). My microproject involves playing with the
> dir_iterator interface, which is a great exercise in code refactoring
> but really does not teach me too much about Git's architecture.

We ask to accomplish a microproject before evaluating the proposals for
one reason: to have a good understanding how well the students would
interact with the project if they were accepted. As such, the
microprojects really are about the flow of the contribution, not to tackle
the project already.

Meaning: I would recommend staying with your microproject, in particular
if it is already in full swing.

Ciao,
Johannes
