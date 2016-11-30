Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3861FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757571AbcK3V3H (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:29:07 -0500
Received: from ikke.info ([178.21.113.177]:55148 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756715AbcK3V3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:29:06 -0500
X-Greylist: delayed 1082 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Nov 2016 16:29:05 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C2177440659; Wed, 30 Nov 2016 22:11:00 +0100 (CET)
Date:   Wed, 30 Nov 2016 22:11:00 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Peter Urda <peter.urda@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "git add -p ." raises an unexpected "warning: empty strings as
 pathspecs will be made invalid in upcoming releases. please use . instead if
 you meant to match all paths"
Message-ID: <20161130211100.GA18680@ikke.info>
References: <CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 12:31:49PM -0800, Peter Urda wrote:
> After upgrading to version 2.11.0 I am getting a warning about empty
> strings as pathspecs while using 'patch'
> 
> - Ran 'git add -p .' from the root of my git repository.
> 
> - I was able to normally stage my changes, but was presented with a
> "warning: empty strings as pathspecs will be made invalid in upcoming
> releases. please use . instead if you meant to match all paths"
> message.
> 
> - I expected no warning message since I included a "." with my original command.
> 
> I believe that I should not be seeing this warning message as I
> included the requested "." pathspec.
> 
> ~ Peter Urda
> 
> http://urda.cc

I can reproduce this. Note that it only happens when you specify '-p'.
Without the --patch option, the warning does not appear.
