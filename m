Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C50C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CC22158C
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 21:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGBVPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:15:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:37330 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGBVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 17:15:08 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jr6Xx-000C1W-Cz; Thu, 02 Jul 2020 22:15:05 +0100
Subject: Re: Consensus on a new default branch name
To:     Whinis <Whinis@whinis.com>, peff@peff.net
Cc:     bturner@atlassian.com, git@vger.kernel.org, james@jramsay.com.au,
        me@ttaylorr.com, msuchanek@suse.de
References: <20200701215744.GA952178@coredump.intra.peff.net>
 <16f1c63a-8b30-e95e-50d1-c5baa9a72fa4@whinis.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <4bbc8658-4dad-10ef-65a4-8f0f4f4fffd4@iee.email>
Date:   Thu, 2 Jul 2020 22:15:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <16f1c63a-8b30-e95e-50d1-c5baa9a72fa4@whinis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2020 13:21, Whinis wrote:
> Peff,
>
> With all respect I have yet to see any evidence actually presented
> against master either. 

The earliest claim I can find is from 2003, verified at Snopes in 2007
[1] and reported in 2003 at [1] (and elsewhere)

I would not expect that the original complaint had been withdrawn. I
don't know if the relevant US/local laws have changed.

> The original list makes the claim its offensive and everyone I have
> asked on other forums just says its obvious its offensive but cannot
> say how it is without resorting to `Do you not find enslaving humans
> offensive`. About all we have is twitter where you can easily find
> people saying its time to go and that changing it makes them feel
> worse as they had no problem with it and yet its being forced through
> in their name. L makes a case with research that the initial claim was
> also not made in good faith at
> https://lore.kernel.org/git/20200621195023.3881634-1-lkcl@lkcl.net/ .
> The link is also more on the master/slave depart but many of the
> points researched cover this one as well.

A recent blog post on racial bias in AI [2] highlighted that "Algorithms
are our opinions written in code",  just as many of our naming
conventions are implicit stand-ins for unsurfaced opinions and biases.

One area that is far more obvious in the UK, is the use of euphemisms
and innuendo, which can be grossly misused. It is quite easy to create
subtlety different phrases which actively discriminate that wouldn't be
noticed except by the careful or 'in the know' listener.  This can
easily be done with 'master' in Git.

From a comment in [3], the link [4] provides details of the association
of 'master' with 'slave' in Engineering literature, beginning in 1904
for a pendulum & clock arrangement. In electronic clock circuits it
wasn't till 1966 the use extended to flip-flop circuits, while hydraulic
master/slave cylinders started in 1959.

>
> I like that you want to err on the side of empathy but based on how
> most of these changes have been forced through their communities I do
> not think the ones arguing for this would do the same for you. As can
> partially be seen with the claim that there is no amount of work that
> can justify continuing to use master or a host of other terms.

Branch names are meant to be ephemeral is the wider Git ecosystem, so
Git should be able to allow the user to chose their own default name.

>
> My personal feeling is it should not change as while many on this list
> certainly are speaking in good faith and want to help the momentum
> behind the change very much is not. While I know its not part of this
> list check out the gitlab issue where they finally opened it back up
> for discussion at https://gitlab.com/gitlab-org/gitlab/-/issues/221164
> and it adds onto those that seem to argue for attack any who argue
> against.

The other issue is that Git doesn't do unique masters anyway. If you
have the correct commit hash you have a perfect, indistinguishable
replica of the original object - It's not a master (in the old 'version
control' sense) any more, so we don't need that name for local clone's
branch, unless it happens to be copied as the remote tracking branch. 
Though that is orthogonal to this discussion.

> If a change is going to be made that will affect million of developers
> and possibly break thousands to millions of applications

As I understand the change process, this will not be the catastrophic
change many are suggesting. Existing repositories will still continue
working. New repositories will have options for choosing the defaults.
The usual level of great care over backward compatibility is being taken. 

>   I would say that you need a mountain of proof and not what has been
> seen so far.
>
> If I may ask what is the intended result of the change if it cannot be
> measured?
>

Anyway, that's the back story, with references,  that I've been able to
track down. Hope that helps.

Philip


[1] https://www.snopes.com/fact-check/masterslave/
[2] http://news.bbc.co.uk/1/hi/technology/3243656.stm
[3]
https://dev.to/educative/understanding-racial-bias-in-machine-learning-algorithms-4cij
[4] Stable URL: http://www.jstor.com/stable/40061475  "Broken Metaphor:
The Master-Slave Analogy in Technical Literature "
