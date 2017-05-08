Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821381FC44
	for <e@80x24.org>; Mon,  8 May 2017 12:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbdEHMXo (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 08:23:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:61678 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbdEHMXn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 08:23:43 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrvBu-1eBCA001vS-013fw7; Mon, 08
 May 2017 14:23:38 +0200
Date:   Mon, 8 May 2017 14:23:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Port git-add--interactive.perl:status_cmd to C
In-Reply-To: <CAEA2_RJFPZ6-ZMQCjX5pXoA8RL6qscLO4QWP3gi46uWXYyD44Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705081415370.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <alpine.DEB.2.21.1.1705052316250.146734@virtualbox> <CAEA2_RJFPZ6-ZMQCjX5pXoA8RL6qscLO4QWP3gi46uWXYyD44Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zkzf0KfaqtqKbKL/rqu3GezdEKewb470BtsaP4Y3++ABuWUZ73I
 JctJoaP7zxi77UZUw0S7axXgMxdzTBICGbljyvJeFnqvwYJZB+6RRVJsEsztbSxsAnvgvwc
 h5pgI6hPx/4HLAB6hDgIES+sPqRspVMfn1Y2RwfPfH209IrwpUOqzupNt3NFt9VGJJ/EuGd
 Lfec9Rf+9Qktl1gYlZeGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HjGWkYfqUco=:641nz22ks2rvIAPdZQujgm
 UfhipcJgcoBUK+iuGdSHxGUQ1BRLEK0LG4esZkS2PcxUBG5gL8dfelOO2jSWlvymT3ia/Yx//
 7D1Q2UET5reDCPV89IfwM+aQc9EtwoSaQHUwS+4k7LLbrumLGiYbpTdHxjrJWGpn76tElwiof
 +oaRHCcg8hF1j4ok+re0QokRy9G4BY1+tJRoUDyeSR1LEYZds86E3jdQQZuyserqd4jpaQ+L3
 y3KnQgavyqI0G01LzZTnrITLYR09CaGaXMbdnDvVExrMJSQTM3gZgoaHNiAVf/0Y7zTKCLFKU
 erQk+awolstTSzpAsgznJ971zXB7iwhEy3kpYIB24WGx8HQG01jIFqenGhcqg8HsDBIDCTABT
 K57hZ1WHLD+1bKTLQTEaRT3XEv1edo61IUl0+jx7pFdywuiuEPXTRYuJCkQbsidzsSWaLXQPN
 +hAGPvsEq6jF6ed3WLzU8IBgFHhpxv/6n2cyhA7L5r83FHrzMHE5xt/1CLK5DKT0gqukDi8zN
 t3eZz72ALGGcuv2eal/VONSWLlztGMXiWaLpL1milDUPwj82Oa7IqQdA9QJ99txuJ7PZj8Yl+
 +PG6crioHnWR9hBJdSetJKlUPl1UkMB2QxQTglJCCp8iFAQRqomLSqOYtN13NzG7HhtS7RvKY
 zzaE//8YZS+R+LZIhzIy6lZw0BJeD8GzXmsOZtoukavYg1SiYztxIxdhUm5zpdDbEZmM28T8+
 5KL5bB90Yi6NqjyUHdwfy18EDh1rqWvg0V/kwGFeJfzFlfu2XbIAMkKhUAe2kg2N8CVrzgbXJ
 w4i//AP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Fri, 5 May 2017, Daniel Ferreira (theiostream) wrote:

> On Fri, May 5, 2017 at 7:38 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > But maybe you want to keep the naming a little more consistent with
> > the Perl script, e.g. instead of calling the function
> > `print_modified()` call it already `list()` (and rename it later to
> > `list_and_choose()` once you have taught it to ask for a choice)?
> 
> Actually, I named it print_modified() because I anticipated there
> would be no list_and_choose() equivalent in C. I don't think the
> builtin should have the interactive menu + modified list + untracked
> list being handled by one function. Rather, I think a saner way to go
> on with it would be to create functions like print_untracked();
> choose_from_input(); print_menu() etc.

Okay. But maybe then the `selected` field should not (at least not yet) be
a part of this patch.

> This is still pure speculation from what I've written until now and from
> the roadmap I have in my head (I do not know how writing code from now
> on will actually be), but I have a hunch that list_and_choose() is
> already convoluted enough in Perl; in C it might become a monster.

True.

To be honest, I would love for this patch to become part of a
"work-in-progress" patch series that lays out the plan a little bit more
concretely (I typically implement functions with a single `die("TODO")` in
the function body in such patch series). This patch series would of course
not be expected to pass the test suite yet, but it would allow other
developers (e.g. myself) to jump in and complete individual patches...

There would be real advantages in such a patch series:

- it could be worked on in parallel (coordination required, of course);
  may be a ton of fun, and

- the overall design could be iterated according with the needs of later
  patches in the series.

> > Thank you for this pleasant read!
> 
> Thank *you* for the quick and thorough review :)

Heh... I would not call it "quick"... it took a long time. But not as much
time as you spent crafting it!

Thank you,
Johannes
