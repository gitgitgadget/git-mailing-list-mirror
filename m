From: Tim Ottinger <tottinge@progeny.com>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Tue, 13 Sep 2005 15:06:05 -0500
Message-ID: <4327312D.3000208@progeny.com>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>	<4325A0D9.2000806@gmail.com> <4325AED6.8050401@citi.umich.edu>	<43272350.3060801@progeny.com> <7vslw821jl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, git@vger.kernel.org, cel@citi.umich.edu
X-From: git-owner@vger.kernel.org Tue Sep 13 22:09:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFH4A-0006qZ-Pr
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 22:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVIMUHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 16:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVIMUHj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 16:07:39 -0400
Received: from zealot.progeny.com ([216.37.46.162]:29631 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S932423AbVIMUHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 16:07:39 -0400
Received: from [192.168.0.101] (pcp961871pcs.brnsbg01.in.comcast.net [68.58.143.126])
	by morimoto.progeny.com (Postfix) with ESMTP
	id CA1106389E; Tue, 13 Sep 2005 15:07:37 -0500 (EST)
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslw821jl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8482>

Junio C Hamano wrote:

>Tim Ottinger <tottinge@progeny.com> writes:
>
>  
>
>>2) However unimportant, I'm an old OO guy and object_cmd looks like 
>>object.command to me.
>>    
>>
>
>If you are OO then would not object_method remind you of object->method ??
>
>  
>
>>>+  init_cc
>>>+  next_cc, prev_cc
>>>      
>>>
>>cc_init?
>>cc_next, cc_previous
>>    
>>
>
>Nah, either set is fine as long as it is internally consistent.
>I tend to prefer "do-this-to-that" so init_cc and next_cc are
>fine by me (just one person's opinion, not a dictator's ruling).
>
>  
>
I guess it depends on whether you're looking at command completion or
not. Most the time I have a thing, and want to do something to it.  Then
starting with cc_ helps, but starting with init_ only tells me what I can
init -- more filtering on my part.

Of course, i can just open the darned file and read it. ;-)  So it's a 
matter
of what you and your tools like best.  Starting with the subject does sort
better, though. 


-- 
                             ><>
... either 'way ahead of the game, or 'way out in left field.
