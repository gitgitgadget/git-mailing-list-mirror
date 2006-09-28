From: Nicolas Pitre <nico@cam.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 23:07:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609272252041.9349@xanadu.home>
References: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
 <7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthew L Foster <mfoster167@yahoo.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 05:07:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSmFP-0005ny-Hu
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWI1DHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWI1DHg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:07:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29378 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965246AbWI1DHg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:07:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6A007MX8ONQG60@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Sep 2006 23:07:35 -0400 (EDT)
In-reply-to: <7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27973>

On Wed, 27 Sep 2006, Junio C Hamano wrote:

> As Shawn said in a nearby thread, in a public and prominent
> repository like kernel.org repository it may sometimes be
> interesting and useful to know when each commit became available
> on each branch.  I am reasonably sure that it would not however
> make gitweb output easier to read to order its output by that
> timestamp.   Linus pulls from subsystem maintainers all the time
> and one pull may bring in dozens of commits, and they will get
> the same timestamp if you did so.  Actually it is worse than
> that.  He tends to batch, so he would have many such pulls and
> patch applications in his private repository, perhaps over a few
> hour, but the result will be pushed out to kernel.org with one
> push operation.  To show the "truthful" time, your gitweb would
> give the timestamp of that push operation for hundreds of
> commits pushed out during that operation.
> 
> I do not personally think that would be useful at all.  And I
> happen to know how expensive to teach gitweb to produce such an
> output, so I would not seriously suggest anybody to try it.

I beg to differ.  Such information might be really useful.  I agree 
though that this is an expensive operation and gitweb might not be the 
best place for it at all.

For example... some times I look at git-log output and finds about a 
certain bug fix that was apparently committed a month ago.  And 
incidentally I recall having been bitten by that bug not really long 
ago, say last week.  Although the bug fix was committed _somewhere_ last 
month, what I would really want to know is just when _i_ received that 
bug fix in my own repository to determine if it was before or after last 
week.  So if it was before last week then I could conclude that the bug 
fix didn't actually fix my bug.  Knowing that it has been committed last 
month is absolutely useless to me in this case.


Nicolas
