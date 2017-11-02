Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B69D2055E
	for <e@80x24.org>; Thu,  2 Nov 2017 17:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbdKBRVG (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 13:21:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:54274 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdKBRVF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 13:21:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSeH-1dLb8Y1z7R-00p1wa; Thu, 02
 Nov 2017 18:20:55 +0100
Date:   Thu, 2 Nov 2017 18:20:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle
 redirection
In-Reply-To: <xmqqr2thsby4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711021819430.6482@virtualbox>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de> <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com> <alpine.DEB.2.21.1.1710311807420.6482@virtualbox>
 <xmqq4lqevbmk.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011726030.6482@virtualbox> <xmqqr2thsby4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a6RbT7TWVm1Fs4vuHeD6vXqYDXPpqlH0w912ArULIiQc0hUaYQn
 1kIHBDhO7Uxka3T5Xc2dtPqrNb6laQCt4+szv2F+Xh0rpv+s82RR3FnecYTxopw2MzcL5NJ
 ylkWUUF8FqOFKLxtouvs0X0DwxbMANRAupsv8I9QESIAOrAgmIn8y6dVwBVP0SBnCQkeLdM
 hfFKqzbAZ7tdgTty4pgAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q+qQ6HpZ7Uc=:jB3NmSvNkrM0/dvUqHroLt
 qKIAcSg7loMgUZ0FSoKses18t4yqFt3nX10jhzWtKYmguo+BdNQvD+Bnf6VL3LQ1KTcvIxnZc
 DEquBR+qFj0Chypm7yV9HjyYJENGJBeYZaCKVIehF55I9SwbL/1GHjzeKQYInjezG+jVuG8PH
 05ZgGAVHkTEiT74q5j0+mg0dwt+jWI4xS5zCyAWdNZy8TQ4khX25dmuadQxyd+hd/K9UrSDyE
 k89cYk66NQc524JNrAY1lhRfsENKDplcqcm3wZpT4DdVECZ87agsmAnRHb2jUaOnWV3Wk5cf5
 536SOsoCFegGTUWrhC/xBrdVpyCcHx7Qitd6ID6OxU3/4FX5rgvi7o6+h6rM9TCyIpJfvN9ru
 TkQWwE7OPL+LKRijIZ8q7EP6yMTgHUgguaN/wR3KWeiWrywsRTUkgsum+2zTkiE1ichwxEmcu
 YrUv0RgY0avAnPHv76qK8G7b2XVqwpVFugWUYc2UdjDQ/5aBj+GF8cp2KAmVsJQY/HC7/zl6x
 o6W+wKPJ5UGMIj8GeJbzfkaKKL/mfpkDsMRKnTLVz7IoHmZv6ynCPCt858s6OfoORkDtFztB5
 n/K9yg5gaWoHgxPUeLc9h775uJZRmdz6hUCgIhUEimsiLevpojxGzWtm8yb3f81Zu9+BXISLs
 3eO8QFN11kZfGHoYi7PLtqVPAER6YKE7YHOt277KaTJYohs3Dv8mggPz0aRHkyHG54OjiIb95
 0OIcSrtzZujZA+Ufk5QGeBH0bM+uNp5HBRwap77Tw2xeYoU0NX8MGW8OqvlMzLbMq5h0PKU0U
 PIjqw+yXKhcJyhVZ9PWg4KaBaXx9z/H6cn5+qLF7CmbwrAgk00=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 2 Nov 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > I feel this is the wrong way round. `>/dev/null` may sound very intuitive
> >> > to you, but this feature is Windows only. Guess three times how intuitive
> >> > it sounds to Windows developers to write `>/dev/null` if you want to
> >> > suppress output...
> >> 
> >> It would be just as intuitive to write '2>&1' for dup-redirection,
> >
> > No. You misunderstand. I was mainly concerned with the `/dev/null`. Every
> > Windows developer knows what `>file.txt` means, and many know what
> > `2>error.txt` means. But `/dev/null` is not Windows, period.
> 
> Actually I did know that much.  
> 
> If I was correct in assuming that "2>&1" is just as foreign as
> ">/dev/null", then we should be shunning "2>&1" just like we shun
> ">/dev/null".  That was all I meant to say.

Did you know that `2>&1` works in Powershell?

> Are you saying "2>&1" is just as likely to be known as ">file.txt"
> and my assumption of foreignness of "2>&1" was incorrect?
> 
> 	Side note: would ">NUL" look more familiar, I wonder, and
> 	can stand for ">/dev/null" for the target audience?
> 
> > ... It is so not
> > Windows that Git itself translates it to `NUL` (which you Linux die-hards
> > won't have a clue about, I would wager a bet).
> 
> Ah, you lost your bet.  When can I collect ;-)?

As soon as we meet in person again.

Ciao,
Dscho
