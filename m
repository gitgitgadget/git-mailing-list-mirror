Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CBA1F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 14:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768236AbcHROYI (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 10:24:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:62686 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768008AbcHROPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 10:15:51 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LyWAQ-1b4t8S44Os-015q0C; Thu, 18 Aug 2016 16:15:43
 +0200
Date:	Thu, 18 Aug 2016 16:15:41 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Stephen Morton <stephen.morton@nokia.com>
cc:	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
In-Reply-To: <f58933df-352a-9d2b-a35a-9c48cb2d958e@nokia.com>
Message-ID: <alpine.DEB.2.20.1608181612340.4924@virtualbox>
References: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com> <CAP8UFD04Z7JpoAA1kXkYFk5LD-GngbUDkbnpCEc3DNDXUgetEA@mail.gmail.com> <f58933df-352a-9d2b-a35a-9c48cb2d958e@nokia.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0fFVmmcfT796XtCH0eLhf5d7sE5sv5aXT86qLLCDlqiqDwwa2wP
 UlsfXPVN9MG+f3GotEBBR0z5G765GmRrHNGUfycupiUFqTNTTBHlk5qajg+tlQKPuhMoQjo
 uhCTYF8GqaOirBPwHdmpBow54yoBqJHNA74qp0zMk500p2uZGGpu/7oiVI0KZfr24Cs6U0+
 wwRt4kiietuvjx6P0S6tw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uxZKEKdUYfU=:+mxNtU2ts9wyYvcdCXVAk2
 4qYOkA0xVH1p1CGNs1Nzf0Ax6Q116neO0SaGByZZpQcVS1K3DaQTjPrcVjmdEz0h8lTywSAu9
 CpVQKmJMTK8/UWk4AvuhYRsh7hwvlDe5TSjvH5iU1AMNck34vrWCbIIzqH4ZOzMf8+iuemNHj
 9SiAmuTNWsETYvbo+2xuDl8EWNKJI/Cb2bZ8CI6vHOApqHXZ8OXSjeQuUpLW4W54NVBH0byjz
 NF6pjAPxRF6exC2OLb1DOGRMnL2uSjTMjRpINUIKNwVuRI9mZP6XVxzmtYLyXUniFHM16jVga
 +HU3byFJZkoGocd/3ycMQUdwvloQdaMUO/stUqlNQmJf912P+u0iR6MTVyfMT9M0FSWLMLAHt
 I8vhegfstYCvfXt6uoUWe5hjFyzcPb1T4T/dbY1js71mPB5QXzBCop6b/dQg4QLrE0zd6uwRX
 q021Q/R/snBhcjGxbCwrXCc8mo6AogUaHBfxCtbnQZt/PuqSUKDKhUtFxRhaeT6sv3LY1seik
 zv1HQok+bz/iA+Pv19pdujUybStdU33V222YiFx9yPCybBXluUZ8RQkxJdaxtKEroHdbga+5B
 OsGhqGRD2vXt9XbYY31FUOtJAfB6k5nuV/oitLqJ3LOz4ssCKY2ZYrbstccWV8n2Bapg71ypJ
 GIfDWIxmSK5nTN+iVdrTpuBS4LmnEibi43xqOl5TzgAg8FkHPlXTBd/i4v74RUNEnbSj0nG4e
 B2iNIFQh/5vNT7iyS0PYQk2j1Z+UsEgPQC7kQ1CGpDT5alNHR2YuB769hhz9D3vxkWd4kZv5/
 r4WiZj1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stephen,

On Wed, 17 Aug 2016, Stephen Morton wrote:

> > multiple_commits = (todo_list->next) != NULL;
> > Why not "last_commit" instead of "multiple_commits"?
> 
> Because it *isn't*.

Personally, I do prefer to have the simpler instruction if the commit
happens to be the last one cherry-picked.

I do not follow your argument that it makes sense to decide based on the
total number of commits that were to be cherry-picked whether to use the
more cumbersome or the easier command.

Instead, I think the user should be given the simplest advice that gets
them out of the fix most quickly. And if `git commit --amend` is good
enough, we should not advise to use `git cherry-pick --continue`, and that
is that.

Ciao,
Johannes
