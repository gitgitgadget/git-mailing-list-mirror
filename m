Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C161F404
	for <e@80x24.org>; Wed, 28 Mar 2018 16:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeC1Qet (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 12:34:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:40147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752670AbeC1Qes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 12:34:48 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNw0t-1etpW73uHr-007R0u; Wed, 28
 Mar 2018 18:34:41 +0200
Date:   Wed, 28 Mar 2018 18:34:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     jfrey@redhat.com, git <git@vger.kernel.org>
Subject: Re: Bug: duplicate sections in .git/config after remote removal
In-Reply-To: <CAGZ79ka_dd=4-EVmoKrBVC_y4+eVPSz959BVNmzZkOwiZh_24A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803281110260.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAP6Vx84GRRxgMZF5P6tb6F4rJ8ozxx-d0o_LsNe=kEYVRkBTKQ@mail.gmail.com> <CAGZ79ka_dd=4-EVmoKrBVC_y4+eVPSz959BVNmzZkOwiZh_24A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/e761BjC9lwXUUrVIqzlHyBRqfUCjszDmXUP4i6VZ5os5Qtp83/
 Oyf9fW1m5+SDGemAutB/n2CQe93Xet60K09Tu4XEurDQAu/Pv4kSLjew6b/XjG8dX+Lns1l
 vLyHB444nGIAeGcXJ9jcawu4mkc+IP+3mbs829CCECy6JEXSuspnFVOAPR+FpRyD4obaCO/
 DTwIW6OQfnX0g7AP0pqpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2r+7QpoR8vg=:Z2HxJTzNYGFnOFI8cPZocl
 KR2B2Wq/ardgHdwWe3oPegi+Ih6Si2hC9nHXKcWzZJlPEJCj1YHNt738YnoIvjBlAQ59KY4yn
 p6k4xEmJtptAGH8nGPZ62C2HXR5wFvwdYM26DfyAXLlrlBLH3wxdbCnKSgep86zn2e1rlqY3w
 BcFaoAoxW+ADgPN2FKVAszH1eQW7ck4fP9vj5zB0ggjADn3axgrZkqldY51wFUQ/8yJgWlFH8
 axhi15t0qSas9RYnTvQ8c5S2IwyRJ7CJaE5oyc07VrZuLQGXdwa6tB22QubKKPj//PYXenoC1
 ekrvuzOSDUmlOcc+GaAxf749NhdCTYuWuARvfXz03dCa0NUGyYYdD4KikLvrvFh//P24XKM5Z
 5ruYNwH9kbgfV86PNBzfqvTF2AMpJ5wKURjAgc7ogUewbjS7jl1MVojyqUxyvvrt7atgEeysZ
 uZoJMQyD9VcrKQSugpxwU5zCvpLYizVUIV+XAZSrqRDUPipFxhLnZDuW+NxkfIXYOCgWZ45mS
 aobQlGw4nZo+Jshco4Rd1GjPiEE9pTJ5NkUOs7uBG2gPM7+N+i+U7yBk2FVRRmIvK3g6Rmy9D
 LkkPTlhlXDkxDWVtP2hyvNbN8gyvy2zRSg3HOosZMOjb5tl6lA6ScyqmnG3D7+x0fh4jaGMQU
 DKBUXwjElN6k7mqr/XcZA/5NHmHwlzIUa3NMgZ6fPg7MvKRT0f3WffdQJBgpW5/JQOdrEjxul
 b4FHdWrXSKWzxXAaD+3A8kmRHsmyt714EC4TsRaS5G5iU7G3dzGdyqB4xW8eIAOJ7mlZXixk1
 ZMB34f8KxMM8gkX9EPkl98/KzdJAgpPQfe1wUaPRAbv9Pw7TehKVKf2q/MbdG3jVKbIQv2B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan & Jason,

On Tue, 27 Mar 2018, Stefan Beller wrote:

> On Tue, Mar 27, 2018 at 1:41 PM Jason Frey <jfrey@redhat.com> wrote:
> 
> > at which point you can see the duplicate sections (even though one is
> > empty).  Also note that if you do the steps again, you will be left
> > with 3 sections, 2 of which are empty.  This process can be repeated
> > over and over.
> 
> I agree that this is an issue for the user, and there were some attempts
> to fix it in the past. (feel free to dig them up in the archive at
> https://public-inbox.org/git)

Note: as far as I remember, the attempted fixes were exclusively trying to
remove the empty section. But this report suggests that we could instead
*keep* empty sections, but then reuse them when a new value is added.

> IIRC the problem is (a) with the loose file format (What if the user put
> a valuable comment just after or before the '[branch "master"]' line?)
> as well as (b) the way the parser/writer works (single pass, line by line)
> 
> (b) specifically made it a "huge effort, but little return" bug,
> so nobody got around for a proper fix.

Yes, (a) makes removing an empty section something less of a desirable
thing. Unless there are no comments before and after the section, of
course, and yes, (b) is a real thing.

On a positive note: I just finished work on a set of patches addressing
this:
https://github.com/git/git/compare/master...dscho:empty-config-section (I
plan on submitting this tomorrow)

Ciao,
Dscho
