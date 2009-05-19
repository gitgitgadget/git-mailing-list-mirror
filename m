From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 15:31:18 -0600
Message-ID: <4A132526.6050109@nortel.com>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <alpine.LFD.2.01.0905191132490.3301@localhost.localdomain> <4A13030D.8000000@nortel.com> <alpine.LFD.2.01.0905191307320.3301@localhost.localdomain> <4A131D16.1030001@nortel.com> <alpine.LFD.2.01.0905191403090.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 19 23:32:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6WvD-0006sP-Fp
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 23:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbZESVbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 17:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbZESVbc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 17:31:32 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:63070 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbZESVbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 17:31:31 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id n4JLUIo14056;
	Tue, 19 May 2009 21:30:18 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 17:31:20 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <alpine.LFD.2.01.0905191403090.3301@localhost.localdomain>
X-OriginalArrivalTime: 19 May 2009 21:31:20.0728 (UTC) FILETIME=[26C59980:01C9D8C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119570>

Linus Torvalds wrote:
> 
> On Tue, 19 May 2009, Chris Friesen wrote:
>> The tagging would be done only by the "official" build process (which
>> pulls from an "official" repository), not by each designer.  Typically
>> the official builds would be done weekly, more frequently if requested.
> 
> Well, you can tag when you do that official build. Do you really do 
> "official" builds from all branches? That sounds a bit insane.

We have one "official" branch for each target board...so maybe a dozen
or so branches.

Developers do private builds, but they're not tagged.

> Remember: you don't have to tag whatever is the "top" - tagging can happen 
> later. Tagging at build-time is perfectly fine.

Tagging at build-time is actually the plan.

> In fact, I'd suggest going even further. Don't tag the source branch when 
> you build - tag it after it has passed whatever testing you do (I hope you 
> _do_ have some extensive test-suite before release), and as you actually 
> make it public (or whatever you do). Only at _that_ point, tag the tree 
> with "release-$branch-$date" or something like that.

There's a fairly extensive test suite.  This might be an option.

> Remember: you don't have to tag the top-of branch. You can tag any commit, 
> after-the-fact. So even if you've done other development since, just make 
> sure to tag the commit you actually built and tested.

Good point.  I think I've got enough information to get something
working.  Thanks for all the help.

Chris
