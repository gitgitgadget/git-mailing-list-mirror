From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 10:53:16 +0200
Message-ID: <4535EB7C.7030209@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	 <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>	 <200610171120.09747.jnareb@gmail.com>	 <1161078035.9020.73.camel@localhost.localdomain>  <4534AB8B.8030505@op5.se> <1161147348.3423.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 10:53:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7BL-0001KW-ND
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 10:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWJRIxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 04:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWJRIxU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 04:53:20 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:19126 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932128AbWJRIxT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 04:53:19 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id DED9C6BD16; Wed, 18 Oct 2006 10:53:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 71FDB6BCF5; Wed, 18 Oct 2006 10:53:16 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Robert Collins <robertc@robertcollins.net>
In-Reply-To: <1161147348.3423.24.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29203>

Robert Collins wrote:
> On Tue, 2006-10-17 at 12:08 +0200, Andreas Ericsson wrote:
>> Robert Collins wrote:
>>> On Tue, 2006-10-17 at 11:20 +0200, Jakub Narebski wrote:
>>>>           ---- time --->
>>>>
>>>>     --*--*--*--*--*--*--*--*--*-- <branch>
>>>>           \            /
>>>>            \-*--X--*--/
>>>>
>>>> The branch it used to be on is gone...
>>> In bzr 0.12 this is :
>>> 2.1.2
>>>
>> Would it be a different number in a different version of bazaar?
> 
> The dotted decimal display has only been introduced in bzr 0.12
> 
>>> (assuming the first * is numbered '1'.)
>>>
>>> These numbers are fairly stable, in particular everything's number in
>>> the mainline will be the same number in all the branches created from it
>>> at that point in time, but a branch that initially creates a revision or
>>> obtains it before the mainline will have a different number until they
>>> syncronise with the mainline via pull.
>>>
>> So basically anyone can pull/push from/to each other but only so long as 
>> they decide upon a common master that handles synchronizing of the 
>> number part of the url+number revision short-hands?
> 
> Anyone can push and pull from each other - full stop. Whenever they
> 'pull' in bzr terms, they get fast-forward happening (if I understand
> the git fast-forward behaviour correctly). After a fast-forward, the
> dotted decimal revision numbers in the two branches are identical - and
> they remain immutable until another fast forward occurs.


This is where it breaks down for me. "until another fast forward occurs" 
is just not good enough, imo.

> 
>> One thing that's been nagging me is how you actually find out the 
>> url+number where the desired revision exists. That is, after you've 
>> synced with master, or merged the mothership's master-branch into one of 
>> your experimental branches where you've done some work that went before 
>> mothership's master's current tip, do you have to have access to the 
>> mothership's repo (as in, do you have to be online) to find out the 
>> number part of url+number shorthand, or can you determine it solely from 
>> what you have on your laptop?
> 
> You can determine it locally - if you know any of the motherships
> revisions locally, we can generate the dotted-revnos that the
> motherships master-branch would have from the local data - and the last
> merge of mothership you did will have given you that details.


To me, this means bazaar isn't distributed at all and I could achieve 
much the same distributedness(?) by rsyncing an SVN repo, working 
against that and then rsyncing it back with some fancy merging. In other 
words, bazaar requires there to be one Lord of the Code, or some of the 
key features break down.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
