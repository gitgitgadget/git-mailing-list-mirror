X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: latest git and git.kernel.org
Date: Fri, 27 Oct 2006 11:51:58 +0200
Message-ID: <4541D6BE.9010804@op5.se>
References: <ehqvgs$sla$1@sea.gmane.org> <4541C123.8000203@op5.se> <4541CB5D.1000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 09:52:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <4541CB5D.1000007@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30319>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdONk-0003Rn-0I for gcvg-git@gmane.org; Fri, 27 Oct
 2006 11:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946295AbWJ0JwF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 05:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946299AbWJ0JwE
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 05:52:04 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:60108 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1946295AbWJ0JwC (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 05:52:02 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 831606BD6F; Fri,
 27 Oct 2006 11:52:01 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 668D06BCEC; Fri, 27 Oct 2006 11:51:58 +0200 (CEST)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

Aneesh Kumar K.V wrote:
> Andreas Ericsson wrote:
>> Aneesh Kumar K.V wrote:
>>> I am getting lot of errors with git.kernel.org in the last few days. 
>>> Is it something to do with the latest git client that i am using or 
>>> due to issues with git.kernel.org ?
>>>
>>
>> I'm seeing the same, but only against git.kernel.org. repo.or.cz works 
>> fine for my, so I've switched to pulling the git repo from there 
>> instead. I guess this is an enforced resource policy on kernel.org. I 
>> believe the inetd rules there have limits on how many concurrent 
>> connections it allows the git-daemon to handle. For example, I often 
>> get to pull the actual objects, but it then fails to fetch the tags 
>> because of "Unexpected EOF. Connection closed" thingie.
>>
> 
> 
> That means i need to find mirrors for kernel and git. Any list available 
> some where regarding these repositories.
> For the time being i switched to repo.or.cz

Not that I know of. At work we've set up a local mirror. I'm sure many 
other companies have done the same. Those that haven't should probably 
do so, as it would save their developers time and relieve kernel.org of 
some of its stress.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
