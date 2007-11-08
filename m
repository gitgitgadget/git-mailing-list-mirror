From: Andreas Ericsson <ae@op5.se>
Subject: Re: Inconsistencies with git log
Date: Thu, 08 Nov 2007 01:11:01 +0100
Message-ID: <47325415.1070205@op5.se>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>	 <Pine.LNX.4.64.0711072242230.4362@racer.site>	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>	 <Pine.LNX.4.64.0711072255420.4362@racer.site>	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>	 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com> <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2gO-0001Qj-KD
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbXKHIX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbXKHIX6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:23:58 -0500
Received: from mail.op5.se ([193.201.96.20]:49301 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXKHIX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:23:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8F70D1F0870A;
	Thu,  8 Nov 2007 09:23:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -1.43
X-Spam-Level: 
X-Spam-Status: No, score=-1.43 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, DATE_IN_PAST_06_12=1.069, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njTneOL+DiVK; Thu,  8 Nov 2007 09:23:32 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7485B1F08709;
	Thu,  8 Nov 2007 09:23:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63961>

David Symonds wrote:
> On Nov 8, 2007 10:19 AM, Brian Gernhardt <benji@silverinsanity.com> wrote:
>> However, Dave's suggestion of altering git-status output to be
>> relative to (but not limited by) CWD has merit.  Too bad I don't have
>> time to work on it right now.
> 
> I am happy to hack on this if there's not widespread revolt against the concept.
> 

I'd definitely like that feature, but I wonder how many people will run
"git commit -a" in a subdir after seeing only what they want to see in the
output, and then accidentally committing junk somewhere else in the repo.

So perhaps git-commit -a should also be path-delimited, but where would we
end up then? It might be better to just let git-status accept a path
delimiter and let the path delimiter default to current work-dir.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
