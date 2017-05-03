Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C30C207D6
	for <e@80x24.org>; Wed,  3 May 2017 09:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbdECJrQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 05:47:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:44394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752355AbdECJrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 05:47:14 -0400
Received: (qmail 30980 invoked by uid 109); 3 May 2017 09:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 May 2017 09:47:11 +0000
Received: (qmail 21338 invoked by uid 111); 3 May 2017 09:47:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 May 2017 05:47:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 May 2017 05:47:09 -0400
Date:   Wed, 3 May 2017 05:47:09 -0400
From:   Jeff King <peff@peff.net>
To:     Rashmi Pai <rashmipai36@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: Git Stash; spelling mistake of stash followed by a
 yes prints character 'y' infinite times.
Message-ID: <20170503094709.rn252pina4vdm6lv@sigill.intra.peff.net>
References: <CAOqCAXTN6_dR=+As_i6yxOL+A3dOzs4bM5Lzbj6qzyT_3ecRcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOqCAXTN6_dR=+As_i6yxOL+A3dOzs4bM5Lzbj6qzyT_3ecRcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2017 at 03:16:06PM +0530, Rashmi Pai wrote:

> Below are the steps to reproduce.
> 1. create a local branch and make some code changes in the same branch.
> 2. now checkout another branch. git says Your local changes to the
> following files would be overwritten by checkout.
> 3. Now do git stahs ( spelling mistake )
> 4. Now git says git: 'stahs' is not a git command. See 'git --help'.
> 
> Did you mean this?
> 
> stash

After this step git exits, and you're back at your shell prompt...

> 5. Now types yes. and you will see character 'y' getting printed
> infinite times!.

...so when you type "yes" here, it is running the "yes" program. Whose
function is to print an infinite number of y's. See "man yes" for more
details.

-Peff
