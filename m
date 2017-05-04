Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE04207B3
	for <e@80x24.org>; Thu,  4 May 2017 11:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbdEDL0f (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 07:26:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:49579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEDL0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 07:26:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjdS8-1ddMjP2Ubg-00bYzo; Thu, 04
 May 2017 13:26:31 +0200
Date:   Thu, 4 May 2017 13:26:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     ankostis <ankostis@gmail.com>
cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: CYGWIN git cannot install python packages with pip
In-Reply-To: <CA+dhYEX0f206pZ+7seOce7McnfZ9ZfXLvSn7YH3Ykgqk+gA8gg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705041324030.4905@virtualbox>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com> <alpine.DEB.2.20.1705031147040.3480@virtualbox> <CA+dhYEUCJghqDQyBrL71Q=JKokcH-nhQ9WZzBb19-gonxi7o=Q@mail.gmail.com> <alpine.DEB.2.20.1705031630540.3480@virtualbox>
 <20170504094719.GA3238@dinwoodie.org> <CA+dhYEX0f206pZ+7seOce7McnfZ9ZfXLvSn7YH3Ykgqk+gA8gg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Dynfhb4lb8FanDDu6iRVdfixQd5iQIQ2AkhmoYY0CnpMqyeSVLG
 OaRsBJT6gXveQdjMnYMg9pH3nn/juENL7WOw6XrY6WjO+JA+3Z4oflJMCXmeunichTjHF8Q
 bGr7A3E4qBmYNXdmtq6SllOkCb+recvmxoLpr62iOc3PB3Z6b13mUd31svObr5qu/I32+yK
 Ygwh6WIiwhnygQcuUec6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JSIgNDD3u+0=:9cftHJOFXHlVEkzXmVJk+0
 Qpw/elFYHtP7Ax8pJumzDQnBKASIPY6uLgsvELZ48Ojg38LaHH98mYPIKYaAOFpVSK3Faq1fO
 1HvI6jbQdxBc8eza/t6QqO3KB0M1TCPxA2c00WfvV9oG0Czezjxv6U1u7aqX3EkYV70er/YJX
 nS0Hlvh9UiMCCWh+cQv3ELvp20LpqEzbL1L9uuUj+vl9u0l4exZTvvZ9q7AlrJFxUMzVuEEqM
 IKUg1JDUhK8Q/TW7m/cWp1ENGNp0LvUyA5s0x31sO5UtKtZc6eWy4WO1TYcSIoFJ59Qp6hnbn
 l5R81qiXUDlRj1DUTeLN8DxFvXzV02ZTluDGSLfZXOc7/Aa5os+pmKOOSlqp82pCKzOqqpRhI
 jRAJDP12Ls4yTQCzqgTKpdNMHjqnxM3ni9904yj1NJ1mFjfq9a5a9kKSeLOkRONcXk2CXEXcF
 eOU28NsLB3tDKal586k5DPrPuSrpA/X2jDWyjOsSVVXY5s/IRFLmWSyBfKie6ntFC8eecBHU8
 QRJH4U9LSC7+dA2juJwohgBnxVUIbsrQk6D2mQZSz1G1vBYhyqdNex1QDq7uq3Sfv/MXX95V5
 ajBtE1QZgQgBTPHhDSfQ/obqfNnQxnVo+6aCarVFvH0DsHtWnbZw1oOYFppUe9PsyxDJKgX/C
 k8ui/qpsBRwmwgGAogWd8iVzoEFPMBl8BjrQ6Gu5hbqOGCOpTWFIMEpPftxcDuVM1jBcZ5bbr
 oXrJaKQK37g86FYX0kDbkx0TuECRtXdBj7/hRvqNYbXOTDo8ys9bF2Ge+fMgtzc80SojKqUGP
 JxSIvOp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 4 May 2017, ankostis wrote:

> On 4 May 2017 at 11:47, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> > Confirmed: the Cygwin project as a general rule doesn't support this
> > sort of mixing of Windows and Cygwin tools.  Either use Python and Git
> > packages both provided by Cygwin, or both provided by Windows.
> >
> > Mixing and matching does work sometimes -- as was apparently the case
> > with Cygwin Git v2.8.3-1 -- but it requires care and you're generally on
> > your own with it.
> 
> MSYS2's git-2.12.1 also works fine, so there must be something
> different in this build of git that breaks this long-standing capability.

MSYS2's runtime has auto-conversion functionality, trying to guess what
arguments passed to a non-MSYS2 program may be Unix paths, converting them
to Windows ones.

So what you may see here has nothing to do with MSYS2's Git *not* having
the change that breaks Cygwin Git for you, but MSYS2's runtime saving you
from trouble.

> Judging from the error-message, it somehow concatenates input & output
> paths.
> Isn't this something to research about?

It is something to research about. But by you, not by me. I need to focus
on bigger-impact issues, because I do not scale, and Git for Windows'
users generally do not experience the problem you described.

Ciao,
Johannes
