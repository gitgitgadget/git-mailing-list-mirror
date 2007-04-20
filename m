From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 10:01:08 -0400
Message-ID: <E27761F8-7325-433C-89BB-B3475FA802A3@silverinsanity.com>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com> <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk> <6d6a94c50704200638y7cd3c81aj3ff7f78863f4ab8d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 16:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hetfq-0006Od-OV
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 16:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992815AbXDTOBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 10:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992823AbXDTOBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 10:01:16 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42327 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992815AbXDTOBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 10:01:15 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 41C011FFC003;
	Fri, 20 Apr 2007 14:01:13 +0000 (UTC)
In-Reply-To: <6d6a94c50704200638y7cd3c81aj3ff7f78863f4ab8d@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45107>


On Apr 20, 2007, at 9:38 AM, Aubrey Li wrote:

> On 4/20/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> On Fri, 20 Apr 2007, Aubrey Li wrote:
>>
>> > I'm behind of a firewall on which the git port is not permitted,  
>> so I
>> > can only use http protocol. Unfortunately, I can't clone linus' git
>> > tree at all.
>>
>> Linus packs his refs, which means that currently you can't clone  
>> using
>> http, with any version of git.
>
> I really don't understand why packed refs or not depend on the  
> protocol.
> It doesn't make any sense.

I think it's simply because git-http-fetch doesn't look for the  
packed-refs file.  Are we actually going to support HTTP fetching?   
If so, we should update it to pull the packed-refs file too.  If not,  
it should be clearly marked as depreciated.  That said, I think HTTP  
is the easiest way for most people to publish and removing it would  
be a mistake.  I'd poke at it, but there's not enough spare time in  
the day at the moment.

~~ Brian
