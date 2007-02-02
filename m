From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 02 Feb 2007 17:15:39 +0200
Message-ID: <45C3559B.80104@dawes.za.net>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <200702021308.48599.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 16:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD09w-0005La-Tq
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 16:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945931AbXBBPRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 10:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945932AbXBBPRA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 10:17:00 -0500
Received: from sumo.dreamhost.com ([66.33.216.29]:49105 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945931AbXBBPQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 10:16:59 -0500
Received: from spunkymail-a1.g.dreamhost.com (sd-green-bigip-81.dreamhost.com [208.97.132.81])
	by sumo.dreamhost.com (Postfix) with ESMTP id AACAC17F600
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 07:16:56 -0800 (PST)
Received: from [192.168.201.104] (dsl-146-24-84.telkomadsl.co.za [165.146.24.84])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id E7901FF9AC;
	Fri,  2 Feb 2007 07:15:46 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <200702021308.48599.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38505>

Andy Parkins wrote:
> On Thursday 2007 February 01 17:33, Nicolas Pitre wrote:
> 
>> The work in progress to enable separate reflog for HEAD will make it
>> independent from reflog of any branch HEAD might be pointing to. In
>> the mean time disallow HEAD@{...} until that work is completed. Otherwise
>> people might get used to the current behavior which makes HEAD@{...} an
>> alias for <current_branch>@{...} which won't be the case later.
> 
> I hadn't really appreciated the implications of all this HEAD reflog stuff 
> until now.
> 
> Please, please, HEAD@{} should /always/ be an alias for <current_branch>@{}.
> 
> There is one special case:  when head is detached, <current_branch> would then 
> be the "unnamed branch" for reflog purposes; personally I'd like that stored 
> in .git/logs/DETACHED_HEAD or similar - in particular not in .git/logs/HEAD.
> 
> Andy
> 

However, if HEAD@{} means what was HEAD pointing at at the indicated 
time, and @{} means "current branch", then we need no exceptions, and 
the common case is shorter.

Rogan
