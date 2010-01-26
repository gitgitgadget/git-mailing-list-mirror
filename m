From: "J.H." <warthog9@kernel.org>
Subject: Re: What's cooking in git.git (Jan 2010, #08; Sun, 24)
Date: Mon, 25 Jan 2010 16:21:14 -0800
Message-ID: <4B5E357A.50607@kernel.org>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org> <m3eildbydx.fsf@localhost.localdomain> <20100125231241.GA4159@machine.or.cz> <201001260107.25796.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 01:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZZCA-0000i8-MI
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab0AZAWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912Ab0AZAWF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:22:05 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:44307 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab0AZAWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 19:22:04 -0500
Received: from [172.19.0.11] (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0Q0LClZ017495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jan 2010 16:21:13 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <201001260107.25796.jnareb@gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 25 Jan 2010 16:21:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138010>


>
> I am waiting for response from (I guess busy) J.H.; I can do the re-roll
> if he is too busy to work on it.
>
>   

I'm juggling about 4 things in the air right now, with gitweb being one 
of them, and two of them involving external entities to kernel.org.  
It's good news all told, just requires a fair amount of my time 
(currently) and babysitting.  I've been digging through the patches 
you've got right now.  I should really just pull them in from your git 
tree again.

After reading through some of the discussions today I've had some more 
ideas on the caching stuff, they are written up on my whiteboard and I 
might be able to get to shortly, but I've got a rather large wall 
looming ahead of me that's going to chew up a *LOT* (read at least a 
month, if not two) of my time, so I'm a bit under the gun to try and get 
this as far as I can before I hit that wall or this is going to fall by 
the wayside again till I've got time again.

>> For the main caching patch, it seems like good idea to take Jakub's
>> split-up series instead, let's see what is J.H.'s opinion on the series?
>>     
>
> Let me at least make them into proper patches, with commit messages and 
> configureability at least of the original caching patch by J.H.
>
> Also the question whether to create 'print -> print $out' patch, or to
> manipulate *STDOUT instead must be solved, I think, before applying
> those patches... well, at least beyond 'pu'.
>
> I am waiting for promised J.H. comments, when he will have time for it...
>   
