Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD1B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 15:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeIGUCW (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 16:02:22 -0400
Received: from ikke.info ([178.21.113.177]:47066 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbeIGUCW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 16:02:22 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2018 16:02:21 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 24A624400AB; Fri,  7 Sep 2018 17:15:43 +0200 (CEST)
Date:   Fri, 7 Sep 2018 17:15:43 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: Mailsplit
Message-ID: <20180907151543.GE27205@alpha>
References: <6663238.U5hdlisbr1@thunderbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6663238.U5hdlisbr1@thunderbird>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 09:17:29PM -0700, Stephen & Linda Smith wrote:
> I thought I would use "git mailsplit" to split a mbox file (which downloaded 
> from public inbox) so that I could attemp to resurrect a patch series for from 
> a year ago.  
> 
> The motivation is that I downloaded the series [1] and applied to a tag from 
> about the time period that the patch was sent out [2].  
> 
> The "git am -3 patch.mbox  quit 2/3 of the way though.   I resolved the fix. 
> and ran "git am --continue" which didn't apply the rest of the patches in the 
> mbox.
> 
> So two questions:
> 1)  why would git version 2.18.0 not appear to continue applying the patches.   
> 
> 2) where do I find the command "git mailsplit".   The onlything in my 
> installed tree is:
> 
> 	$ find  /usr/local/ -name '*mailsplit*'
> 	/usr/local/share/doc/git-doc/git-mailsplit.txt
> 	/usr/local/share/doc/git-doc/git-mailsplit.html
> 	/usr/local/share/man/man1/git-mailsplit.1
> 	/usr/local/libexec/git-core/git-mailsplit

This is the mailsplit command, and should be executed when running `git
mailsplit`. What does git --exec-dir return?

Kevin
