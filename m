X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 07 Dec 2006 16:23:28 +0100
Message-ID: <457831F0.3090305@op5.se>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com> <Pine.LNX.4.63.0612071554180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 15:23:44 +0000 (UTC)
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.63.0612071554180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33590>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsL5x-0006ee-SU for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937981AbWLGPXa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937982AbWLGPXa
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:23:30 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60514 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937981AbWLGPXa (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 10:23:30 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id C8ED96BCBF; Thu,  7 Dec 2006 16:23:28 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 7 Dec 2006, Brian Gernhardt wrote:
> 
>> When I pulled the most recent changes for git (de51faf), `make` began 
>> failing with the following messages: [...]
> 
> I found the same, but could not reproduce it. But a "touch perl/perl.mak" 
> fixes at least compilation.
> 

I had to do the same. Somewhere, there's a "mv" that tries to move 
perl.mak out of the way and doesn't properly detect the fact that it 
isn't there.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
