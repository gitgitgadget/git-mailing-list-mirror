From: Ben Greear <greearb@candelatech.com>
Subject: Re: How to pull a single changeset from a child branch into a parent
 branch?
Date: Fri, 10 Feb 2006 13:16:21 -0800
Organization: Candela Technologies
Message-ID: <43ED02A5.6030500@candelatech.com>
References: <43EC10AA.1040800@candelatech.com> <7vzmkzyfhh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 22:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fdI-00033q-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWBJVQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBJVQ2
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:16:28 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:27578 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932197AbWBJVQ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 16:16:27 -0500
Received: from [71.112.206.236] (pool-71-112-206-236.sttlwa.dsl-w.verizon.net [71.112.206.236])
	(authenticated bits=0)
	by ns2.lanforge.com (8.13.4/8.13.4) with ESMTP id k1ALGMhw016525;
	Fri, 10 Feb 2006 13:16:23 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmkzyfhh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15885>

Junio C Hamano wrote:
> Ben Greear <greearb@candelatech.com> writes:
> 
> 
>>I have a linux-2.6 repo with two branches off of 2.6.13.
>>
>>One branch (ben_v13) has just my own changes.
>>A second branch (work_v13) has the 2.6.13.5 patch, and I've also pulled
>>ben_v13 into it.
> 
> 
>                      "2.6.13.5"
>          o---o---o---o
>         /             \ "work_v13"
>     ---o "2.6.13"  .---*
>         \         /
>          o---o---o
>                  "ben_v13"
> 
> 	'o' are commits, '*' is a merge.
> 
> 
>>Now, I made a small change to work_v13,
> 
> 
>                      "2.6.13.5"
>          o---o---o---o
>         /             \   "work_v13"
>     ---o "2.6.13"  .---*---x
>         \         /        (new change)
>          o---o---o
>                  "ben_v13"
> 
> 
>>... and I'd like to pull only
>>that changeset into ben_v13.  Is there a way to do that w/out
>>having to export and apply a patch?
> 
> 
> I would have done things differently.

Yeah, the main problem is that I test in the combined tree
and forgot to change to the ben_v13 tree before making
my changes...

I'll try out the cherry-pick option..and if that doesn't
work, I'll just manually patch the changes into the ben_v13
tree.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
