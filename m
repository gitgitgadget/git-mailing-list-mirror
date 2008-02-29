From: Paul Franz <thefranz@comcast.net>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as threads.
Date: Thu, 28 Feb 2008 20:46:47 -0500
Message-ID: <47C76407.3090804@comcast.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site> <47C6F40A.4010703@comcast.net> <alpine.LSU.1.00.0802290122110.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUuLX-0001S2-2D
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYB2Bqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYB2Bqu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:46:50 -0500
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:40022
	"EHLO QMTA02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751598AbYB2Bqt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 20:46:49 -0500
Received: from OMTA13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by QMTA02.westchester.pa.mail.comcast.net with comcast
	id vBzp1Y00217dt5G5207P00; Fri, 29 Feb 2008 01:46:17 +0000
Received: from paul-franz-laptop.local ([76.117.152.226])
	by OMTA13.westchester.pa.mail.comcast.net with comcast
	id vDmo1Y0014tLBlG3Z00000; Fri, 29 Feb 2008 01:46:48 +0000
X-Authority-Analysis: v=1.0 c=1 a=jYeb2YJqOk4A:10 a=sDGkoYPlu-P0RWVk5loA:9
 a=YfUFpNUf8HOGI_975qXHhVYDX-8A:4 a=8UL1S1SzPDgA:10
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.LSU.1.00.0802290122110.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75492>

True there are the legal issues. And it is not known if it would help on 
other platforms. My may concern is Windows because if git could be made 
available without some of msysGit's requirements. It would definitely 
make it more palletable (sp?) to that community which is a large chunk 
of developers, including my own work environment. I would love to switch 
from ClearCase to git but there are issues. One of them is integration 
with the Windows environment.

Another concern is performance penalty of using non-native calls under 
Windows and that is one of the problems that I was hoping the using APR 
would solve. I figure if it is good enough to support the network stuff 
under Windows well maybe it would be good for git too.

Paul Franz

Johannes Schindelin wrote:
> Hi,
>
> On Thu, 28 Feb 2008, Paul Franz wrote:
>
>   
>> Do you think it would be possible to change git to use Apache's apr 
>> library?
>>     
>
> Possible?  Yes.
>
> Sensible?  That's another issue.  For one, we already rely on a pretty 
> good POSIX shell support.  That is not something helped by APR.
>
> So if we already need a POSIX shell, we might just as well rely on a 
> (kind of) POSIX environment.
>
> Besides, I cannot say that I found compiling APR in msysGit _easy_.
>
> So if there are as many disadvantages as I suspect, and as few advantages, 
> as I suspect, too, I think it would be a waste of time to bother to port 
> Git to APR.
>
> Besides, I think there are -- again, as always when things seem to be only 
> fun -- legal issues.  I do not know the details, but there are people who 
> say that APL is incompatible with GPL (v2).
>
> Not that I care too much about those bastards who devised licenses just to 
> make my life miserable.  But them lawyer types have ways to _make_ my 
> life miserable.  So I avoid those kind of problems.  I guess you could 
> call this "collateral legal damage".
>
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

