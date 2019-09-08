Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187321F461
	for <e@80x24.org>; Sun,  8 Sep 2019 14:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfIHO4Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 10:56:16 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50719 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIHO4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 10:56:16 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 63F92FF802;
        Sun,  8 Sep 2019 14:56:12 +0000 (UTC)
Date:   Sun, 8 Sep 2019 20:26:10 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190908145610.3ho2wo5qqiw3u4lz@yadavpratyush.com>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904194114.GA31398@sigill.intra.peff.net>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On 04/09/19 03:41PM, Jeff King wrote:
[snip]
> The project page has a section to point people in the right direction
> for first-time contributions. I've left it blank for now, but I think it
> makes sense to point one (or both) of:
> 
>   - https://git-scm.com/docs/MyFirstContribution
> 
>   - https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git
> 
> as well as a list of micro-projects (or at least instructions on how to
> find #leftoverbits, though we'd definitely have to step up our labeling,
> as I do not recall having seen one for a while).

I'd like to put out a proposal regarding first contributions and micro 
projects.

I have a small list of small isolated features and bug fixes that
_I think_ git-gui would benefit with. And other people using it can 
probably add their pet peeves and issues as well. My question is, are 
these something new contributors should try to work on as an 
introduction to the community? Since most of these features and fixes 
are small and isolated, they should be pretty easy to work on. And I 
think people generally find UI apps a little easier to work on.

But I'll play the devil's advocate on my proposal and point out some 
problems/flaws:
- Git-gui is written in Tcl, and git in C (and other languages too, but 
  not Tcl). That means while people do get a feel of the community and 
  general workflow, they don't necessarily get a feel of the actual git 
  internal codebase.
- Since I don't see a git-gui related project worth being into the 
  Outreachy program, it essentially means they will likely not work on 
  anything related to their project.
- Git-gui is essentially a wrapper on top of git, so people won't get 
  exposure to the git internals.

I'd like to hear your and the rest of the community's thoughts about 
this proposal, and whether it will be a good idea or not.

If people do like this idea, I can do a write up on "things to fix in 
git-gui" that people can add to (and they get a chance to call me stupid 
for even thinking feature X is a good idea ;)).

-- 
Regards,
Pratyush Yadav
