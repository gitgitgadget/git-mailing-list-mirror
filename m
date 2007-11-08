From: Andreas Ericsson <ae@op5.se>
Subject: Re: Inconsistencies with git log
Date: Thu, 08 Nov 2007 14:40:46 +0100
Message-ID: <473311DE.3070201@op5.se>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>	 <Pine.LNX.4.64.0711072242230.4362@racer.site>	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>	 <Pine.LNX.4.64.0711072255420.4362@racer.site>	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>	 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>	 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>	 <47325415.1070205@op5.se> <ee77f5c20711080516n4f207ba3pccc8efffa2a6ad4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7d9-0007b6-Iz
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXKHNku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbXKHNku
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:40:50 -0500
Received: from mail.op5.se ([193.201.96.20]:60331 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934AbXKHNkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:40:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id ABC3D1F08714;
	Thu,  8 Nov 2007 14:38:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZCQfJABuHEKy; Thu,  8 Nov 2007 14:38:51 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id EE5A71F08708;
	Thu,  8 Nov 2007 14:38:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <ee77f5c20711080516n4f207ba3pccc8efffa2a6ad4c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64020>

David Symonds wrote:
> On Nov 8, 2007 11:11 AM, Andreas Ericsson <ae@op5.se> wrote:
>> David Symonds wrote:
>>> On Nov 8, 2007 10:19 AM, Brian Gernhardt <benji@silverinsanity.com> wrote:
>>>> However, Dave's suggestion of altering git-status output to be
>>>> relative to (but not limited by) CWD has merit.  Too bad I don't have
>>>> time to work on it right now.
>>> I am happy to hack on this if there's not widespread revolt against the concept.
>>>
>> I'd definitely like that feature, but I wonder how many people will run
>> "git commit -a" in a subdir after seeing only what they want to see in the
>> output, and then accidentally committing junk somewhere else in the repo.
> 
> I never suggested path *limited*, only path *relative*. git-status
> would still show all the same files, but their paths would be relative
> to your current directory, so there'd be no confusion like you
> mentioned. This is how Johannes' patch works.
> 

Ah, that'd be a different matter entirely then. Thanks for clarifying. I
have no further objections then.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
