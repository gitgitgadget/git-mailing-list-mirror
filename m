From: "Kirby C. Bohling" <kbohling@birddog.com>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 14:59:18 -0500
Message-ID: <20050825195918.GD7461@birddog.com>
References: <20050824181004.GA18790@hpsvcnb.fc.hp.com> <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org> <20050824195615.GA693@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net> <20050825024134.GA31886@hpsvcnb.fc.hp.com> <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net> <20050825163201.GA3944@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 22:08:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8NzP-0003c3-0p
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 22:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVHYUGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 16:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVHYUGP
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 16:06:15 -0400
Received: from hermes.birddog.com ([216.81.238.129]:20425 "EHLO
	hermes.birddog.com") by vger.kernel.org with ESMTP id S932532AbVHYUGO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 16:06:14 -0400
Received: from hawk.birddog.com (hawk.birddog.com [10.15.4.100])
	by hermes.birddog.com (8.12.10/8.12.10) with ESMTP id j7PJxTtn008721;
	Thu, 25 Aug 2005 14:59:29 -0500
Received: from hawk.birddog.com (localhost.localdomain [127.0.0.1])
	by hawk.birddog.com (8.12.11/8.12.11) with ESMTP id j7PJxN1E011769;
	Thu, 25 Aug 2005 14:59:23 -0500
Received: (from kbohling@localhost)
	by hawk.birddog.com (8.12.11/8.12.11/Submit) id j7PJxII0011767;
	Thu, 25 Aug 2005 14:59:18 -0500
To: Carl Baldwin <cnb@fc.hp.com>
Content-Disposition: inline
In-Reply-To: <20050825163201.GA3944@hpsvcnb.fc.hp.com>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.15 (www dot roaringpenguin dot com slash mimedefang)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7758>

On Thu, Aug 25, 2005 at 10:32:01AM -0600, Carl Baldwin wrote:
<snip...>
> Another example is if I'm working on a commit and suddenly get a
> brilliant idea for some easy modification that I want to make and commit
> by itself before making this commit.  I can do this easily with
> 
>         % git undo
>         % carefully make easy change
>         % git commit
>         % git redo
> 
> Having a light-weight alternative like this could make the difference
> between realizing the easy, brilliant idea and forgetting about it on
> the back burner because it was just too cumbersome to make the context
> switch.
> 
> The bottom line is that I don't argue against using the existing
> work-flows.  I hope to add the flexibility to use various work-flows to
> fit the job at hand.
> 
<snip...>

[Not much of a git user, but am evaluating it for possible future
usage]... 

Why not just save the changes to a file via a patch.  Just like you
would if you were sending a patch to someone else.  I have the work
flow you are talking about when I use CVS.  I just create a patch,
apply the patch in reverse (or run the command to get you a clean
working tree in the SCM).  Make my unrelated changes commit it.
Then apply the patch, possibly resolve merge conflicts,  and proceed
with finishing my original work.

Assuming your patch creation and application tools capture all the
meta-data the SCM has (which I believe git does), it's pretty simple
to simulate what you want manaully.  With only a handful of
commands.

I see the appeal of not having manually deal with the files, but
assuming you don't feel it's branch worthy, and you don't want to
have it be something someone else can access externally, it doesn't
seem like a feature I can't get almost as simply with existing git
commands.  

I guess my final question is what does undo/redo have over saving
stuff away in a patch assuming that the patch captures all of the
SCM meta-data (the add/move/remove file type commands).  If git
doesn't capture all the meta-data in a patch, it would seem better
to make it do that and get this as a side-affect.

    Thanks,
        Kirby
