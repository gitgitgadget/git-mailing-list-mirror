Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983E31F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409605AbeKWWES (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:04:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:34751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbeKWWES (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:04:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvQkh-1fPURI06ux-010Yjc; Fri, 23
 Nov 2018 12:19:59 +0100
Date:   Fri, 23 Nov 2018 12:19:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, mhagger@alum.mit.edu,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, dnj@google.com,
        prohaska@zib.de, john@keeping.me.uk, stanhu@gmail.com,
        richardc@unixbeard.net, Joey Hess <id@joeyh.name>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like
 "git-init"
In-Reply-To: <20181122160656.GB28192@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811231219200.41@tvgsbejvaqbjf.bet>
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-1-avarab@gmail.com> <87k1ld1f51.fsf@evledraar.gmail.com> <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com> <87in0w25gc.fsf@evledraar.gmail.com> <20181117063940.GA31057@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811221344360.41@tvgsbejvaqbjf.bet> <20181122160656.GB28192@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z4M/NDCid/SRENUwgrI+fPr5Degva1q0dJrO/6omBGKK59/69QE
 L67pPbQJ9/JAcmUs0+dhCm4/hEHNA1QhwdP2JjFRJA8WvgndKoh/lJPAob96ql10mDvr67+
 Rp2vu81yv7LqtXb9niAFq0ypYxI3+dtham7o+W7V7XG1VfewNOWkXmNHfZyzNMLV82epzS4
 l8FDlhVBKi0vsVhAs0PGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QWEBISzk06Y=:MuTAe3OBPt0r/a06dpuA5e
 YtmQXRo5N4aN9ygvLkWddPuXn1egh49zhTRLgM+agFoisE0NlbVCPh2rWnrIVG1iseWgm+Bcu
 jNJ6uMh784jo4ueTtM19QYrOrIcW6WF4Nf4srrbRuM3IpPVxbtyCLgpj91STmMFkSmfDACXck
 w6LqQegtxJASbOOe08t9dJCqkGy4scNDDF0TekdHniS6zt6FXFEB8jhq6mI2/ktTGu5f6Cnrq
 l1aJbRutkaYs0tpZN3O9FY7j90NjlCaeLcKz+wlXFzdh/l63cEXBuGA8pvKeLC62kzR4ySI3u
 Y5s5JIBOrsOjN88zCzQ3x3lqrK4L9oFZtwrVKTSTVOb3UGh5JhRsunCsjZxiKYWZhAQop6KVp
 vzxRMYxJEmEDAAV/sHMeEI7zUIH9c1JQkkgMiPXEhHs39RyMDWf22X9j1+/T8fBuh65AMOaF+
 bzUqU3xb1IqqnJGERWfqlXakKQe/vHKPKQ6nKDdPeEXn/7ysijXcrL+G9o42UNqxdfYi3zxHz
 GLuuZ4WdCjqvSYSFjZ8K4OT8PA4WZQqLf24AG8mD3OG0qbHqvGOZfUmVgLHugMtAZNEIQbRVH
 WKCLofwE0G+NDvBnxiQPasbcxQBwVBVuncbTJMsCxaMc6URCQb99LOWCZZhCgzgeJuGQwiucM
 X6qy52zU+FWYBbz32TupJeQGtwHH7ucV8TGEMUWeMlrU+J+jC4/1k43IWJlOXBXLA6AV3UiJW
 xhdu+9WihcOanp1PmLZEAd6CQ6jei7+nOd+pZDiOqLAMV9NSwNYIUGwMhn6oRV2Y802jSJTDB
 RhsRsG614b2Jv4RLylPLcB5XsgBXfUoF9Alc/6mvYdc7x4kyKjFNfNTyvUKHWSq5zrRC2t/FG
 xTWVtoKxvc2cPgtXxlx+/0UuQ8WBz+ZxkMrmtaJYhfTvOpF6kTdcwZUBf1m7Jd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 22 Nov 2018, Jeff King wrote:

> On Thu, Nov 22, 2018 at 01:48:53PM +0100, Johannes Schindelin wrote:
> 
> > So YMMV with git-<tool>s. My rule of thumb is: if I want to use this
> > myself only, I'll make it an alias. If I want to ship it (e.g. with Git
> > for Windows), I'll make it a git-<tool>.
> 
> I have a handful of personal git-* scripts: mostly ones that are big
> enough to be unwieldy as an alias. But then, $PATH management is pretty
> straightforward on my platforms, so it's easier to drop a script there
> than to point an alias to a non-git-* script.

Oh, my Git aliases pretty much *all* point to a single script that takes
subcommands.

Ciao,
Dscho
