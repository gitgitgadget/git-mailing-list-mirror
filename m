From: David Lang <david@lang.hm>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 15:00:41 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca> <20130116220615.48c159546bccfa5b9cd9028e@domain007.com> <20130116182156.GB4426@sigill.intra.peff.net> <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Lang, David" <David.Lang@uhn.ca>
To: Stephen Smith <ishchis2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:02:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvc0N-00034G-BB
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280Ab3APXC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:02:26 -0500
Received: from mail.lang.hm ([64.81.33.126]:33511 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757136Ab3APXCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 18:02:25 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0GN26Fv027574;
	Wed, 16 Jan 2013 15:02:06 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213820>

On Wed, 16 Jan 2013, Stephen Smith wrote:

>>>>> Ideally we'd prefer to simply create our remote repository on a
>>>>> drive of one of our local network servers. Is this possible?
>>>>
>>>> Yes, this is possible, but it's not advised to keep such a
>>>> "reference" repository on an exported networked drive for a number
>>>> of reasons (both performance and bug-free operation).
>>>
>>> I agree that performance is not ideal (although if you are on a fast
>>> LAN, it probably would not matter much), but I do not recall any
>>> specific bugs in that area. Can you elaborate?
>>
>> This one [1] for instance.  I also recall seing people having other
>> "mystical" problems with setups like this so I somehow developed an idea
>> than having a repository on a networked drive is asking for troubles.
>> Of course, if there are happy users of such setups, I would be glad to
>> hear as my precautions might well be unfounded for the recent versions
>> of Git.
>>
>> 1. http://code.google.com/p/msysgit/issues/detail?id=130
>
> A group I was with used a master repository on a windows share for quite some time without a database corruption being seen.   --

I think the risk is that if you have multiple people doing actions on the shared 
filesystem you can run into trouble.

As long as only one copy of git is ever running against the repository, I don't 
see any reason for there to be a problem.

But if you try to have one filesystem, with multiple people running git on their 
machines against that shared filesystem, I would expect you to have all sorts of 
problems.

David Lang
