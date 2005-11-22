From: Andreas Ericsson <ae@op5.se>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 10:07:38 +0100
Message-ID: <4382DFDA.6040306@op5.se>
References: <20051122041843.9436.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 10:08:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeU7s-0004Hm-Ft
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 10:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVKVJHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 04:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVKVJHl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 04:07:41 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:27271 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750704AbVKVJHk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 04:07:40 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3031F6BCFF; Tue, 22 Nov 2005 10:07:39 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20051122041843.9436.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12539>

linux@horizon.com wrote:
>>This is like Makefiles: if you have spaces in the wrong place, it may all 
>>_look_ fine, but the Makefile just doesn't work. Really irritating.
> 
> 
> Makefiles are more annoying because spaces instead of tabs can cause
> them to work *differently*.  It's hard to write syntax that will
> actually do that, but the parser ahs to go past the problem a bit to
> really figure it out, so it can't print a nice error message.
> 
> With the strict prefix convention, the parser can produce excellent
> error messages.
> 

Excellent error messages aren't good enough. It's ok for Python, since 
that's a programming language. We can expect infinitely more from 
programmers than we can from users.

> It irritates you the first few times until you learn to do it right in 
> first place, just like it irritates most beginning C programmers that the
> compiler keeps complaining about missing semicolons.
> 

If I'm trying out some new stuff that annoys me three times without me 
seeing an obvious error on my part (in the editor of my choice) I 
usually write it down as broken and move on.

> Computers will be annoying about syntax until they learn to do what
> I want them to do rather than what I tell them to do, at which point
> they'll be smart enough to start being annoying by doing what they want
> to to instead of what I want them to do.
> 

That's not the point. If everything looks good it should work good, 
regardless of which editor or tab-setting one's using.

> 
>>Of course, since I believe that tabs are always exactly 8 characters, I'd 
>>also be perfectly happy to just declare that anybody who disagrees with me 
>>is a moron and deserves to die (*).
> 
> 
> Seriously, you could always have it print warning messages but try to
> keep going by assuming 8 space tabs so that at least you can postpone
> fixing the problem until your current train of thought has pulled into
> the station.


There used to be $TABSIZE (or some such). Check it if you implement 
this. Or just skip it entirely. I would prefer the latter.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
