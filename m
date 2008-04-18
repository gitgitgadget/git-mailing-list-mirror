From: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
Subject: Re: git branch diagram
Date: Fri, 18 Apr 2008 12:39:52 +0400 (Russian Standard Time)
Message-ID: <alpine.WNT.1.10.0804181219420.1528@theodor>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Fri Apr 18 17:53:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmmaE-000348-UC
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 11:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbYDRJHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 05:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYDRJHy
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 05:07:54 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:48398 "EHLO
	brmea-mail-3.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYDRJHw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 05:07:52 -0400
X-Greylist: delayed 1609 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Apr 2008 05:07:52 EDT
Received: from fe-amer-09.sun.com ([192.18.109.79])
	by brmea-mail-3.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m3I8f2EF028724
	for <git@vger.kernel.org>; Fri, 18 Apr 2008 08:41:03 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZI00501IR49200@mail-amer.sun.com>
 (original mail from Fedor.Sergeev@Sun.COM) for git@vger.kernel.org; Fri,
 18 Apr 2008 02:41:02 -0600 (MDT)
Received: from localhost ([92.255.85.22])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JZI002UWIS35XA0@mail-amer.sun.com>; Fri,
 18 Apr 2008 02:41:02 -0600 (MDT)
In-reply-to: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
X-X-Sender: fs77888@mail-amer.sun.com
User-Agent: Alpine 1.10 (WNT 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79866>

On Thu, 17 Apr 2008, Patrick.Higgins@cexp.com wrote:
> I am trying to get my employer to start using git and have found the distributed model
> and git's branching to be one of the hardest parts to explain and understand.
> I put together the attached diagram (done with graphviz so some things
> are not in the most logical place) to help explain things to my coworkers.

One bit of advice - make at least two or three versions of this diagram,
with varying levels of complexity (say, complex one for integrators and 
simple one for developers).
Full diagram might appear to be very intimidating to newcomers :)

Depending on their background your coworkers might not like the whole idea
of branching (because of prior bad experience with branches and merges).
In my case the very word "branch" was not always accepted nicely.

My own experience in a similar situation (which has not yet been fully resolved,
so take my words with a grain of salt) shows that for the initial acceptance
it is better to devise a scheme that does not involve branching.

People will learn branching and will appreciate git's flexible branching 
in future, but for starters it might appear to be better to restrict amount of branches
to master + origin/master.

>
> Unfortunately, I don't understand things well enough myself to know if the diagram is correct or not.
> I read in the stgit docs that developing directly in the master branch
> is discouraged by convention, but I don't really understand why.
> The git tutorial shows work happening directly in master, so I wasn't
> sure if that's a convention that only makes sense for stgit or for plain git, too.

That is really up to your policies and your trust to the developers.
It is harder to screw up a master in Git than it is, say, in TeamWare.

But I would not let everybody in my project to freely go and do stuff in 
master. And I definitely would not make it a development requirement, as 
TeamWare background makes my coworkers shudder and sweat of a very thought
of touching master.

Your milage might definitely vary.

regards,
   Fedor.
