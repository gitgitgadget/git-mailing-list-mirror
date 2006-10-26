X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: shortlog, was Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 15:45:03 +0200
Message-ID: <4540BBDF.1020204@op5.se>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de> <45409D79.8010909@op5.se> <Pine.LNX.4.64.0610260937070.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 13:45:23 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64.0610260937070.12418@xanadu.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30217>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5Xl-00031V-0w for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161366AbWJZNpI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161370AbWJZNpI
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:45:08 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:7571 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161366AbWJZNpG (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 09:45:06 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id A94FD6BE20; Thu,
 26 Oct 2006 15:45:05 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 499476BDCA; Thu, 26 Oct 2006 15:45:03 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:
> On Thu, 26 Oct 2006, Andreas Ericsson wrote:
> 
>> I keep writing
>> 	git log --short
>>
>> when I really want
>> 	git log --pretty=short | git shortlog
>>
>>
>> I'll have a look at making it work if I get a spare moment.
> 
> Why don't you simply drop the --pretty=short altogether?
> 
> 	git log | git shortlog
> 

Dunno. Mainly because I saw the "git log --pretty=short | git shortlog" 
construct somewhere, I guess. Either way, it would make more sense to 
have it as --pretty=by-author or something like that instead.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
