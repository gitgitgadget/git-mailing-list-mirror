From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Regarding: git-lost+found
Date: Wed, 9 Nov 2005 19:29:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511091926350.25300@iabervon.org>
References: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvez1bjjv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511091759520.25300@iabervon.org>
 <7vwtjh8kxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 01:31:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea0KN-0007IP-Hp
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 01:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVKJAaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 19:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVKJAaA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 19:30:00 -0500
Received: from iabervon.org ([66.92.72.58]:55056 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751117AbVKJA37 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 19:29:59 -0500
Received: (qmail 31031 invoked by uid 1000); 9 Nov 2005 19:29:54 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Nov 2005 19:29:54 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtjh8kxu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11455>

On Wed, 9 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Why have git-lost+found write to files at all? It seems to me easiest to 
> > have the list go to standard out, and you could do "gitk `git-lost+found 
> > -t commit`" to see lost commits, and reconnect them as desired. (Making up 
> > command line syntax for listing only the commits.)
> 
> That is certainly cleaner.  The only downside is fsck-objects
> that lost+found uses tends to be expensive operation, and what
> you would want to do with the information may be more than just
> use it on the command line of gitk.  But in any case the user
> could store git-lost+found output in a file to do whatever she
> wants, so it may not matter.

Actually, my next suggestion would be to have gitk able to write 
hashes as refs, so that, having put it on the gitk command line, you could 
then do the things you want from there.

	-Daniel
*This .sig left intentionally blank*
