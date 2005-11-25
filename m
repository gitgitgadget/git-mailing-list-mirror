From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 11:59:07 +0100
Message-ID: <4386EE7B.7070604@op5.se>
References: <4386DD45.6030308@op5.se> <20051125101209.GA8868@puritan.petwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 11:59:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfbIQ-0001ph-To
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 11:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVKYK7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 05:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVKYK7J
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 05:59:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:20125 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751442AbVKYK7I
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 05:59:08 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 9DF476BD03; Fri, 25 Nov 2005 11:59:07 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
In-Reply-To: <20051125101209.GA8868@puritan.petwork>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12733>

Nikolai Weibull wrote:
>>It's worse than the perl version because;
>>1. It doesn't thread the patch-series (which I personally prefer anyway 
>>since it's easier to follow a thread on a particular patch that way).
> 
> 
> Not so great.  Why is it so much more difficult to have one more level
> of nesting?  It's annoying, but it's a lot less annoying than having 19
> separate threads that are all, in fact, related to each other.
> 

I am of the opinion that nesting is bad because some patches get a few 
comments while some others get them in droves. It's easy to miss those 
with few if they're all nested. As for finding them, all the threads 
should show up next to each other since there's practically no delay 
between sending them.

As for implementation, I don't think most "mail" programs have the 
functionality necessary to do so (dunno though since I didn't investigate).

> 
>>2. The patches sent within the same second arrive in random order.
> 
> 
> Perhaps adding a 'sleep 1' would help?  (The delay may be unacceptable
> to some people, though.)
> 

I thought about that, but decided against it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
