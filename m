From: Paul Franz <thefranz@comcast.net>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as threads.
Date: Thu, 28 Feb 2008 22:08:16 -0500
Message-ID: <47C77720.2080405@comcast.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site> <47C6F40A.4010703@comcast.net> <alpine.LSU.1.00.0802290122110.22527@racer.site> <47C76407.3090804@comcast.net> <alpine.LSU.1.00.0802290150440.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 04:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUvcY-0004DG-PP
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 04:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYB2DIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 22:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbYB2DIU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 22:08:20 -0500
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:42217 "EHLO
	QMTA10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753605AbYB2DIT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 22:08:19 -0500
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by QMTA10.emeryville.ca.mail.comcast.net with comcast
	id v8CQ1Y0561HpZEsAA0HQ00; Fri, 29 Feb 2008 03:07:24 +0000
Received: from paul-franz-laptop.local ([76.117.152.226])
	by OMTA14.emeryville.ca.mail.comcast.net with comcast
	id vF8G1Y00B4tLBlG8a00000; Fri, 29 Feb 2008 03:08:18 +0000
X-Authority-Analysis: v=1.0 c=1 a=jYeb2YJqOk4A:10 a=S08Hx-U6PynKb_0TAWoA:9
 a=9eTyUrIWZKmLiiVUJ0OpRoUxMvgA:4 a=c5zHXd76wwQA:10
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.LSU.1.00.0802290150440.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75504>



Johannes Schindelin wrote:
> Hi,
>
> [top-posting?]
>   

Is there something wrong with it?
> On Thu, 28 Feb 2008, Paul Franz wrote:
>
>   
>> True there are the legal issues. And it is not known if it would help on 
>> other platforms. My may concern is Windows because if git could be made 
>> available without some of msysGit's requirements. It would definitely 
>> make it more palletable (sp?) to that community which is a large chunk 
>> of developers, including my own work environment. I would love to switch 
>> from ClearCase to git but there are issues. One of them is integration 
>> with the Windows environment.
>>     
>
> I think that you do not help the effort to bring Git to Windows, by 
> suggesting even more work, for dubitable benefits.
>
> And that is what I think of APR here.
>
> NOTE: my only experience with APR on Windows is to get git-svn to compile, 
> and there it was not only a PITA.  The result is _SLOW_.
>   

Thanks for the info.
>   
>> Another concern is performance penalty of using non-native calls under 
>> Windows and that is one of the problems that I was hoping the using APR 
>> would solve. I figure if it is good enough to support the network stuff 
>> under Windows well maybe it would be good for git too.
>>     
>
> The problems with Git and Windows are not network related.  They are with 
> Windows' pitiful performance when it comes to spawn processes.
>   
Which makes me believe that it sounds like git depends on spawning 
processes being cheap.
> IMO your efforts to help Git on Windows would be better spent on the 
> msysGit list, where you would learn about the real issues we face.
>   

Excuse my ignorance,  could you tell me where the mysGit list is, so 
that I can subscribe?

> Ciao,
> Dscho
>
>
>   
-- 

-------------------------------------------

There are seven sins in the world.
     Wealth without work.
     Pleasure without conscience.
     Knowledge without character.
     Commerce without morality.
     Science without humanity.
     Worship without sacrifice.
     Politics without principle.

   -- Mohandas Gandhi

-------------------------------------------

