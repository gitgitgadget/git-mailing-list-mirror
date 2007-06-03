From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 22:31:47 +0200
Message-ID: <20070603203147.GH6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis> <vpq1wgtnith.fsf@bauges.imag.fr> <20070603160736.GC30347@artemis> <Pine.LNX.4.64.0706031031520.6705@asgard.lang.hm> <20070603184957.GE30347@artemis> <Pine.LNX.4.64.0706031203220.6705@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Jun 03 22:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huwk0-0006iY-8v
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXFCUbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXFCUbs
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:31:48 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:38083 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbXFCUbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:31:48 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CE62C5A2B4;
	Sun,  3 Jun 2007 22:31:46 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A658E1F01B; Sun,  3 Jun 2007 22:31:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706031203220.6705@asgard.lang.hm>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49032>

On Sun, Jun 03, 2007 at 12:07:44PM -0700, david@lang.hm wrote:
> >>1. bug number doesn't work well in a distributed environment
> >
> > Sure, SCM revisions either. But git solved that once, I don't see why
> >the solution found at that time would be less of a solution now :)
> 
> git's tracking of revisions works becouse it's tracking the content, it 
> doesn't care _how_ the content got that way, if it's the same it's the 
> same and will have the same hash.
> 
> with bugs the reports aren't the same so you can use the sha1 to track a 
> particular entry/tag/comment but not to identify the bug itself

Do you see any problem with taking as bug id the hash of the first
entry submitted ?  Just like in a classical BTS, the bug id gets
allocated at submussion time.  Further informations then get
associated with the initial report - here that would problably
translate into the initial report being an annotation to a source
commit, and further information being annotations to the initial
annotation.


> fine grained categorization is something that takes place long after the 
> bug is reported, users don't know how to correctly categorize bugs any 
> more then they know what code caused the bug.

Is that a problem ?


> > My experience with bugtracking is that the most efficient way to deal
> >it is to let the programmer in charge of the responsible module deal
> >with those bugs. What programmer aren't willing to do is the triaging,
> >and pulling the bugs off a distant database/UI/.. off something that
> >isn't in their usual workflow.
> 
> this only works if someone goes to the work to send the bugs to the right 
> programmer. in many cases this is non-trivial.

This is he work of a QA team, and although it is not as common in the
Free Software world as it should be, there are people willing to do
the job.  This discussion is about giving these people a better tool
to help them focus on the tasks where a human being is really needed.

Best regards,
-- 
Yann.
