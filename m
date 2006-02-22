From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] nicer eye candies for pack-objects
Date: Thu, 23 Feb 2006 00:19:04 +0100
Message-ID: <43FCF168.1060802@op5.se>
References: <Pine.LNX.4.64.0602221549250.5606@localhost.localdomain> <7vy803kp1n.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602221733030.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 00:19:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC3GJ-0003R3-BY
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 00:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWBVXTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 18:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWBVXTI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 18:19:08 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:19433 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030341AbWBVXTG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 18:19:06 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2B8296BCBE; Thu, 23 Feb 2006 00:19:05 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602221733030.5606@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16623>

Nicolas Pitre wrote:
> On Wed, 22 Feb 2006, Junio C Hamano wrote:
> 
> 
>>I like this, but like the "every second or every percent
>>whichever comes first" unpack-objects does even better.  How
>>about something like this on top of your patch?
> 
> 
> Well... my concern is (if I'm right) that this status is generated 
> remotely and sent over the network when performing a fetch.  The "every 
> percent" might in this case generate quite some significant overhead if 
> the pack is small.
> 

But if the pack is small it won't matter. It's when it's big we want to 
know about it (and then the each-percent method is better, really).

> Also (personal opinion) such progress numbers are harder to read when 
> they change too fast.
> 

I don't know about the rest of the world, but when I see numbers 
counting up with a percent-sign behind them I do some mental math to see 
how many brain-ticks go between each increment and then multiply with 
100 to see if I need to get a beer while waiting. I don't really care 
what number it shows if it flashes too fast to read.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
