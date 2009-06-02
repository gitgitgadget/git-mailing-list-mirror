From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: git and multiple cores
Date: Tue, 02 Jun 2009 17:29:07 -0600
Message-ID: <4A25B5C3.40409@nortel.com>
References: <4A25AA4C.9070600@nortel.com>	 <eaa105840906021555w22e62341l61f250455cf8c23b@mail.gmail.com>	 <20090602230205.GL30527@spearce.org> <eaa105840906021612y5b9e4c25o1062d7f7aecfbd16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 01:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBdQ5-0006J2-OM
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZFBX3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 19:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbZFBX3O
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:29:14 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:34502 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZFBX3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 19:29:14 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id n52NS0E07521;
	Tue, 2 Jun 2009 23:28:00 GMT
Received: from [47.130.80.200] ([47.130.80.200] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 19:29:12 -0400
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
In-Reply-To: <eaa105840906021612y5b9e4c25o1062d7f7aecfbd16@mail.gmail.com>
X-OriginalArrivalTime: 02 Jun 2009 23:29:12.0462 (UTC) FILETIME=[EFA312E0:01C9E3D9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120562>

Peter Harris wrote:
> On Tue, Jun 2, 2009 at 7:02 PM, Shawn O. Pearce wrote:
> 
>>Peter Harris <git@peter.is-a-geek.org> wrote:
>>
>>>On Tue, Jun 2, 2009 at 6:40 PM, Chris Friesen wrote:
>>>
>>>>I'm using git 1.6.1.3 and it seems to be limited to a single core.
>>>>Given that I've seen cases where the cpu has been basically pinned for
>>>>minutes on end (initial clone of a repository, for instance) has there
>>>>been any discussion of taking advantage of multiple cores?
>>>
>>>Sounds like you're mostly concerned about packing.
>>>
>>>The good news is, your version of git already has a threaded packer.
>>>You just need to enable it. See "pack.threads" in "git help config".
>>>
>>>1.6.2 and newer use multiple threads by default.
>>
>>True, but he was talking about initial clone, which on the client
>>side is git-index-pack.  Which is not threaded.
> 
> 
> Ah. I thought he was talking about the server side. My mistake.

Sorry, I wasn't clear.  I was talking about the client side, although
the server side information is useful to have.

I have a 4-way machine as a client, and it just seemed odd that git
could only use one core.

Chris
