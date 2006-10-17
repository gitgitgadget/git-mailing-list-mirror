From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 12:08:11 +0200
Message-ID: <4534AB8B.8030505@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	 <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>	 <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 12:08:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlrt-0004e9-8h
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWJQKIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWJQKIO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:08:14 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:61673 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161041AbWJQKIO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 06:08:14 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id B53A26BDE1; Tue, 17 Oct 2006 12:08:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8BC8D6BD2A; Tue, 17 Oct 2006 12:08:11 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Robert Collins <robertc@robertcollins.net>
In-Reply-To: <1161078035.9020.73.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29048>

Robert Collins wrote:
> On Tue, 2006-10-17 at 11:20 +0200, Jakub Narebski wrote:
>>           ---- time --->
>>
>>     --*--*--*--*--*--*--*--*--*-- <branch>
>>           \            /
>>            \-*--X--*--/
>>
>> The branch it used to be on is gone...
> 
> In bzr 0.12 this is :
> 2.1.2
> 

Would it be a different number in a different version of bazaar?

> (assuming the first * is numbered '1'.)
> 
> These numbers are fairly stable, in particular everything's number in
> the mainline will be the same number in all the branches created from it
> at that point in time, but a branch that initially creates a revision or
> obtains it before the mainline will have a different number until they
> syncronise with the mainline via pull.
> 

So basically anyone can pull/push from/to each other but only so long as 
they decide upon a common master that handles synchronizing of the 
number part of the url+number revision short-hands?

One thing that's been nagging me is how you actually find out the 
url+number where the desired revision exists. That is, after you've 
synced with master, or merged the mothership's master-branch into one of 
your experimental branches where you've done some work that went before 
mothership's master's current tip, do you have to have access to the 
mothership's repo (as in, do you have to be online) to find out the 
number part of url+number shorthand, or can you determine it solely from 
what you have on your laptop?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
