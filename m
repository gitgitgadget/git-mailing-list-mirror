Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0ED11F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbcHPPhx (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:37:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:50425 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbcHPPhw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:37:52 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M1W5x-1bKDur3CFF-00tVa5; Tue, 16 Aug 2016 17:37:36
 +0200
Date:	Tue, 16 Aug 2016 17:37:35 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
In-Reply-To: <20160816145532.nfooqmkaostc2e7t@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608161732390.4924@virtualbox>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de> <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com> <xmqq4m6mhsvj.fsf@gitster.mtv.corp.google.com> <20160815184315.cyhln2bxg465lq2l@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608161502240.4924@virtualbox> <20160816145532.nfooqmkaostc2e7t@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:of899smEuT4YhkzMhjPyJdvFdPweis1hFVx+kMxFK4nNeez32Nf
 FRsNRrH6OF2oUGkJjyK/SFYqhamtkbH89a33Ht5xy8vRVt3LW6V4tVhJhQHNmSSzEUJ/UsL
 eo2jaYhKLEUB/zs1v5XuUIJeqPU8Yir2D7L+obFMtJDG5Gzo1uY5I6w265U8UIRDVT/jlR4
 gNvSDJWMPvyrFX4m5/q7Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pQXhJGX1pW0=:yXzzvvjEjHTPRAxyJ7poLy
 wiz4vmflIsIHPgjzQk+gNhLmt4xw8cE9FQOANn+q5QxW9WoDI/zw8fGWgM0R2FYBeXh9EmfUE
 2ZbdO2TL6owBZNy5xtsd4lmfJ6LOrD/eWw8Z8ePWDINzDt+eurDGl9rJUHTgWBqd3U+EvcLWd
 xOvdF6awff47KNHxWcN/98kamvJplW3ExlmElOMS5+4rTU2IQDd8KB/yvm6Qbl4HZZQ0B4WmJ
 2L3UAze5gzTPhA5eekqaY8FtcBWTgr8DRMpUoSUEfF+YB8lII8g2KaZyCGTPWGtbOmJG1BB03
 qNRS4GP6XMnPqQcsuN+fwCW0x0FrZiuPbUtdVsJ11CfJv8/lgJcuzjYWhmk3HZch18vaTtPPx
 rz4BsdsmbIjqSvGsLHDfIvCc/CsBOt/uLAKit49X+/PDuCsz5rUWtGfNVK4yEjmqMU1JFdTl7
 qVV74ZTS2Anpnh7X+IEJUx78WOgGNG8T5ygVeFBti/Z6GYhZtJvftC7xDyu5PEZWhXlSdwxP/
 JfY3E35LT4BzTuPdM0RVq1xkrUUB6Hg3Q8FoMtcGxQJBlNCaZa2vWzfTfPmQ/qGMG5hUA6wCq
 v/Yl3A+pX3HDjmHKSneTjo07XnX/NMfRniQBSNi5ol92x5mh4O5grnZfrLyzZE9U2O1x4bvDf
 dTSPxJUwC0Mkm1WunO5pl0THsHaa21Wx8zHzF+kkHuW7tx+KeD09xuuBMaVfD3FT9KiZnCUXT
 Hsl1Tg3rGgY/EWlwgx8lFg2zGysOHiDMd7n+GmGvX0nWS3J8Hx/vGHKPEqSzJo0vmXzLXjVOK
 ib6AUFh
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Tue, 16 Aug 2016, Jeff King wrote:

> On Tue, Aug 16, 2016 at 03:10:46PM +0200, Johannes Schindelin wrote:
> 
> > > I am not convinced this mechanism needs to be built into git.
> > > Because it happens to be about filenames, git at least has a hope of
> > > making sense of the various project rules.
> > 
> > Both of you gentle people may recall a conversation in December 2014
> > when we scrambled to plug a hole where maliciously-chosen file names
> > would have allowed to wreak havoc with a local Git repository's config
> > (among other things).
> > 
> > We did plug it, but not before I proposed to exclude many more file
> > names than just maliciously-chosen ones. For example, I wanted to
> > exclude all file names that are illegal on Windows when
> > core.protectNTFS was set to true.
> > 
> > If we were to implement this "let's help cross-platform projects"
> > functionality, it would be at that same level.
> 
> Hrm. I am not sure I agree. At GitHub, for instance, we turn on
> core.protectNTFS for all repositories because we do want to be a vector
> for attacks.

I trust you meant "do *not* want to be a vector for attacks"...

> So the tradeoff is a good one: the restrictions on filenames are not
> that big, and we gain a lot of safety (i.e., a known remote code
> execution bug).
> 
> Whereas if core.protectNTFS started disallowing trees with both "foo"
> and "FOO", that is a much different tradeoff. It is much more likely to
> come up, and it is protecting a much less valuable thing (it's an
> annoyance, not a security hole). Projects which do not care about people
> on case-insensitive filesystems will be annoyed to have their commits
> rejected (whether they are right to be so uncaring or not can be
> debated, but I am not sure that GitHub wants to enforce a hard policy at
> the fsck layer).
> 
> So even if we wanted a similar mechanism, I think it has to be triggered
> by a separate config option. And I do not think general hosting sites
> would turn it on. It's really a project decision, not a hosting-site
> one.
> 
> There may be some rules that are in between. I.e., names that are
> illegal on some common platform but are extremely unlikely to be chosen
> in general. I'd have to see the rules to give an opinion.

Good point.

What I meant in my curt language was actually not to use core.protectNTFS
per se, but the same code path. That is, I would rather have any such
"cross-platform helping" code in verify_path() rather than
write_index_as_tree().

But you are correct, this hypothetical feature (pretty hypothetical,
indeed, at this point) would have to be configured differently than
via core.protectNTFS=true.

Ciao,
Dscho
