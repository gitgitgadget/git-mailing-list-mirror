From: Junio C Hamano <junkio@cox.net>
Subject: A note from the new GIT maintainer
Date: Tue, 26 Jul 2005 23:04:18 -0700
Message-ID: <7vmzo8ss2l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507262004320.3227@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 27 08:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxf1r-0001TN-I5
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 08:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVG0GEX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 02:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVG0GEX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 02:04:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6034 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261977AbVG0GEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 02:04:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050727060417.IIED17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Jul 2005 02:04:17 -0400
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507262004320.3227@g5.osdl.org> (Linus Torvalds's message of "Tue, 26 Jul 2005 20:24:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As some of you seem to have noticed even before the announcement
by Linus, the official GIT repository at kernel.org is now owned
by me.  As Linus said in his message, this does not mean he is
leaving us, so please do not panic.

I would like to thank everybody on the GIT list for what we have
achieved so far.  Getting your ideas blown away and still being
able to feel happy about it is a privilege granted only to those
who are fortunate enough to work with very talented people.  It
has been quite a fun experience for me.

I would also like to thank Twin Sun Inc (my employer) and NEC
for promising to support me working on GIT on a part time basis
from now on.  I expect to be spending 8 to 12 day-job hours per
week; evenings and weekends are my own time as before.  My
tentative plan is to make Wednesdays and Saturdays my primary
GIT days.

Earlier, I was producing as many patches as ideas cross my mind,
throwing all of them at the list to see which ones stick,
relying on somebody with a good taste upstream to drop all the
bad ones.  Although it has been fun working that way with Linus,
regrettably, I ended up wasting a lot of his time.

I will slow down and be more careful as the "shepherd of the
main repository" from now on.  At least for now, you will see
patches from me posted on the list like everybody else's, before
they hit the main repository.

In other words, I will make you my "adult supervision," so
please help me out by raising objections, giving alternatives,
or just plainly saying "your patch is ugly".

Some of you may have also noticed that the main GIT repository
has an extra branch, "pu" ("proposed updates").  My patches,
along with patches from others I collect from the list that I
intend to eventually apply, will first go there, before hitting
the master branch.  You can probably tell, by looking at this
branch, what my priorities are, which patches are being
considered, and responses to which ones I am still waiting for.
Please note that I expect to rewind and rebase this branch quite
often.

I was planning to talk about the remaining tasks for 1.0 in this
message when Linus asked me if I wanted to take over the core
GIT project a couple of weeks ago.  But I think we have done
most, if not all, of what we would want to have in 1.0 since
then.  Of course there are still ongoing discussions for various
improvements, but I feel that that can continue without blocking
the 1.0 pre-release engineering process.  Please keep bugfixes
and documentation updates flowing.

After the 1.0 release, I plan to start a branch for 1.0
maintenance, separate from the "master" branch.  I think the
intent of having GIT RPM support, which was done before me, was
to force Pasky's hand to split core part from the Cogito
package, but as the prerequisite for the split to happen, the
interface to the core GIT part must be reasonably stable.  We
operated without even having any formal version numbers for
quite some time, which I am sure made Pasky's life more
miserable then it should have been.  This must be rectified.

I have not decided if we want to use even-odd scheme like the
kernel used to have, or just keep the "master" a bleeding edge
branch which is occasionally tagged.

That's about it from me for now.  Let's continue to have fun!
