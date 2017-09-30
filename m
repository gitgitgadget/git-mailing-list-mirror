Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27B52047F
	for <e@80x24.org>; Sat, 30 Sep 2017 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdI3OdB (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 10:33:01 -0400
Received: from ikke.info ([178.21.113.177]:56306 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdI3OdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 10:33:00 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id AEF844403B9; Sat, 30 Sep 2017 16:32:58 +0200 (CEST)
Date:   Sat, 30 Sep 2017 16:32:58 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-checkout", man page is inconsistent between SYNOPSIS
 and details
Message-ID: <20170930143258.GA20886@alpha.vpn.ikke.info>
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 30, 2017 at 05:27:22AM -0400, Robert P. J. Day wrote:
> 
>   just noticed that in "man git-checkout", the SYNOPSIS contains the
> line:
> 
>   git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]
> 
> implying that <paths> is optional, but further down in the
> DESCRIPTION, one reads:
> 
>   git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...
> 
> suggesting that <pathspec> is required.
> 

Hello Robert, thank you for this report.

Git checkout has 2 major modes of operating:

1. Checking out branches (and then update your working tree to match that
  commit.
2. Checking out 1 or more files from a commit.

The first four lines of the synopsis match mode nr. 1. The next two
belong to mode nr. 2.

The pathspec in the synopsis line you are quoting is required, because
that's how you tell git you want mode nr 2. That's why it's not
mentioned between [].  The last section under description explains that
mode. 

Do you feel this distinction needs to be made more clear?

Kevin.
