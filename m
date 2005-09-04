From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Sun, 4 Sep 2005 13:23:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509041318390.23242@iabervon.org>
References: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0508171341380.23242@iabervon.org>
 <Pine.LNX.4.63.0508172156090.17234@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0508171630140.23242@iabervon.org>
 <Pine.LNX.4.63.0508180009180.18104@wgmdd8.biozentrum.uni-wuerzburg.de>
 <430C8C31.1070902@progeny.com> <7v4q9eak9k.fsf@assigned-by-dhcp.cox.net>
 <43174090.5070503@progeny.com> <7vek88tib4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509021358000.23242@iabervon.org> <7voe7bfhfz.fsf@assigned-by-dhcp.cox.net>
 <7v8xyebs9v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509030233350.23242@iabervon.org>
 <7vy86e5zbf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org,
	Horst von Brand <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sun Sep 04 19:20:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBy9X-0000Jt-LA
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 19:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVIDRTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVIDRTc
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 13:19:32 -0400
Received: from iabervon.org ([66.92.72.58]:21011 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932074AbVIDRTc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 13:19:32 -0400
Received: (qmail 12301 invoked by uid 1000); 4 Sep 2005 13:23:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2005 13:23:23 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy86e5zbf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8061>

On Sat, 3 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I think "fetch" is more applicable to what they do.
> 
> OK.  then they are git-http-fetch and friends.  How about
> git-ssh-push?  The counterpart of fetch-pack/clone-pack is
> called upload-pack, so would git-ssh-upload make things more
> consistent?  I dunno.

I like that idea.

> > I don't think it matters very much whether something is a script or not; 
> > on the other hand, it would be good to have "git" list a reasonable set of 
> > commands to use through the interface, which would exclude, for example, 
> > git-merge-one-file-script, and include the above commands.
> 
> Are you suggesting to drop -script from git-merge-one-file?
> Then git-cherry should perhaps keep its current name.

I'd suggest it get a different ending, like .sh or -helper. That way, it's 
distinct both from binaries and from scripts that people run directly.

	-Daniel
*This .sig left intentionally blank*
