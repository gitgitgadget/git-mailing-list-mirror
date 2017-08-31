Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1331F4DD
	for <e@80x24.org>; Thu, 31 Aug 2017 06:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdHaGm4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 02:42:56 -0400
Received: from ikke.info ([178.21.113.177]:51134 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdHaGmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 02:42:55 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 77249440216; Thu, 31 Aug 2017 08:36:14 +0200 (CEST)
Date:   Thu, 31 Aug 2017 08:36:14 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Aleksandar Pavic <pavic.aleksandar@nsinfo.co.rs>
Cc:     git@vger.kernel.org
Subject: Re: Bug report
Message-ID: <20170831063614.GI3839@alpha.vpn.ikke.info>
References: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 11:25:00PM +0200, Aleksandar Pavic wrote:
>  I have a file
> 
>  app/Controller/CustomerCardVerificationController.php
> 
> And when I take a look at changes log, I get this (no matter which tool I
> use):
> 
> 2017-07-31 19:41 dule             o membership renew payment email
> 2017-06-07 08:59 Dusan Tatic      o cc refund clean
> 2017-04-15 00:16 Miodrag Dragić   o refound admin payment
> 2017-03-20 12:02 Dusan Tatic      o CardVerification card connect
> 2017-03-16 15:59 Aleksandar Pavic o paypal
> 2017-03-10 13:34 Aleksandar Pavic o Production branch
> 2017-03-10 13:01 Aleksandar Pavic I Migrating dev
> 
> However if I manually browse thru revisions and open revision from
> 03/27/2017 07:05 PM
> 
> I can see the change in that file which is unlisted above, at revision
> ff9f4946e109bd234d438e4db1d319b1f6cb6580
> 
> And I'm at master branch all the time...
> 
> We wouldn't have noticed that if it weren't one important feature...
> 

What does git branch --contains ff9f4946e109bd234d438e4db1d319b1f6cb6580
return?

Where did you find this commit?
