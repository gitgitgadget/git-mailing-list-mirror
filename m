Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79910202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 00:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbdJWAgw (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 20:36:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932142AbdJWAgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 20:36:51 -0400
Received: (qmail 1681 invoked by uid 109); 23 Oct 2017 00:36:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Oct 2017 00:36:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31492 invoked by uid 111); 23 Oct 2017 00:36:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Oct 2017 20:36:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Oct 2017 20:36:48 -0400
Date:   Sun, 22 Oct 2017 20:36:48 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
Message-ID: <20171023003647.4pvzmhk7v5t6zqm5@sigill.intra.peff.net>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
 <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
 <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
 <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net>
 <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
 <1508682297.6715.15.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508682297.6715.15.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 22, 2017 at 07:54:57PM +0530, Kaartic Sivaraam wrote:

> On Fri, 2017-10-20 at 13:45 -0700, Stefan Beller wrote:
> > 
> > The git-test from Michael sounds intriguing. Initially I put off using
> > it as I had my main working dir (or rather test dir) on a spinning
> > disk, still. Now I test in memory only, which is a lot faster, so I could
> > try if git-test can keep up with my local commit pace.
> > 
> 
> Excuse my ignorance but I don't get your statement correctly. What do
> you mean by "I test in memory only"? How do you do that?

I assume it means pointing "--root" at a tmpfs or ram disk in
GIT_TEST_OPTS. That makes the test suite run _way_ faster.

-Peff
