Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B50208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 22:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbdHIWdd (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 18:33:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:61780 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbdHIWdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 18:33:32 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTSrf-1e6LUM1ZWZ-00SR4i; Thu, 10
 Aug 2017 00:33:30 +0200
Date:   Thu, 10 Aug 2017 00:33:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
In-Reply-To: <20170808182324.GB73298@google.com>
Message-ID: <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
References: <20170808012554.186051-1-bmwill@google.com> <alpine.DEB.2.21.1.1708081404200.4271@virtualbox> <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com> <20170808182324.GB73298@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:niwNWC4oit84SKzGKNUXutvzyThx7SkZ+xHgktm+2oWf3Ddkx0M
 ULC7WEkqQ8ngI8p0knGfDtMcdwEDpbhuHsdij8sy7N696hKIZAUD3cXl5i4lKawz+JxZ6J8
 Wv0B3v9VWHCMt8qd6s4lO1PuBWr+DS8jjRXtyasBaBcPrygHj8SL1Nb7ncHRl/5EVWAc/Pm
 /b9WkxIc3jX93L/+COMtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qm3sWmj9BwQ=:Xosvo0IIUCRwrj5cONFw+G
 0WsEBezYPaQVPC/HRaMAylwbr/6B9wkaOClq8uonX9iw/C33aYrqcI0JbTDLNvyJapmqmgF8G
 vx5yZeE7wUt56+L3LUh735vKkKdTh1pU0fGl0rrczNSX+pFtYogzXyTNqtcQYE/+Paok7XQSo
 /0a0YvTgkT0rja6Bd/u+O/SzfUdZArEd3ug37faH2Rt5QLNDKJXZcmUZqgGTixWSD10+rEuM0
 eubEmpjcUwomZ55dIqqhlVS5Y6iROFCC3vqMiczIYWJBxIPGfPg9gZ2KR+IdNNdqQTzMVdCdI
 SgK6snPoJJs4DdUiDVTICBA4fBSaJnQRKDLfFMUZccagKHilR5IzEDmqs1UaLMjDmQga5Ta3m
 /loPa94hQrvGF70a5QYaXBV1H3ZjkahhsmYGT6JPtZduj9o86tRTsGrzAysFBKxub9I1ZHIDy
 /YJN+aDRvyHVLGI7Rh+SgYUNK+EpnoSo/fW+ZdxmG6f+DrGlX5Smok8aGGjfb+I8N1oXdlT62
 ZlLqxZ+PwwjxEvEr4IS2uTJmWX6309lRT17XadVjuBtOlbImomQ9M2XV+DNOi8jk1hZ6hydis
 Tgu8GAZNWzz5hzOIpb9Uu5q5EvJ3dlCh5r0dyFSQh+sR5VFyWd/feqAovMwWgUozm0eyCgRB8
 cRP/OZF4axIEULWj8hU3Pf0LOWTLCnh1hxUS9/QHU8KopJsQSwnB5z9KwcbG+sgv2TUjEhrG2
 NU5kRYqswpuvI3nGgizXg9uMhhMO/r5wok2vgxo+VspoFc1FY0dvkYm6QBCJ6RRcSKnYs3goZ
 y3S4GgewaH9mV43JXzmvwq0vyxLcNvIvZRawTHw5NnOLIhrLy8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 8 Aug 2017, Brandon Williams wrote:

> On 08/08, Stefan Beller wrote:
> > On Tue, Aug 8, 2017 at 5:05 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > Hi Brandon,
> > >
> > > On Mon, 7 Aug 2017, Brandon Williams wrote:
> > >
> > >> Add a '.clang-format' file which outlines the git project's coding
> > >> style.  This can be used with clang-format to auto-format .c and .h
> > >> files to conform with git's style.
> > >>
> > >> Signed-off-by: Brandon Williams <bmwill@google.com>
> > >> ---
> > >>
> > >> I'm sure this sort of thing comes up every so often on the list but back at
> > >> git-merge I mentioned how it would be nice to not have to worry about style
> > >> when reviewing patches as that is something mechanical and best left to a
> > >> machine (for the most part).
> > >
> > > Amen.
> > >
> > > If I never have to see a review mentioning an unwrapped line, I am quite
> > > certain I will be quite content.
> > >
> > > Ciao,
> > > Dscho
> > 
> > As a thought experiment I'd like to propose to take it one step further:
> > 
> >   If the code was formatted perfectly in one style such that a formatter for
> >   this style would not produce changes when rerun again on the code, then
> >   each individual could have a clean/smudge filter to work in their preferred
> >   style, and only the exchange and storage of code is in a mutual agreed
> >   style. If the mutually agreed style is close to what I prefer, I don't have to
> >   use clean/smudge filters.
> > 
> > Additionally to this patch, we'd want to either put a note into
> > SubmittingPatches or Documentation/gitworkflows.txt to hint at
> > how to use this formatting to just affect the patch that is currently
> > worked on or rather a pre-commit hook?
> 
> I'm sure both of these things will probably happen if we decide to make
> use of a code-formatter.  This RFC is really just trying to ask the
> question: "Is this something we want to entertain doing?"
> My response would be 'Yes' but there's many other opinions to consider
> first :)

I am sure that something even better will be possible: a Continuous
"Integration" that fixes the coding style automatically by using
`filter-branch` (avoiding the merge conflicts that would arise if `rebase
-i` was used).

Ciao,
Dscho
