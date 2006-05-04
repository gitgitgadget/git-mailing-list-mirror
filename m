From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Unresolved issues #2
Date: Thu, 4 May 2006 16:41:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605041627310.6713@iabervon.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 22:41:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbkdj-0006Mq-GE
	for gcvg-git@gmane.org; Thu, 04 May 2006 22:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWEDUlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 16:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWEDUlS
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 16:41:18 -0400
Received: from iabervon.org ([66.92.72.58]:18440 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030322AbWEDUlR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 16:41:17 -0400
Received: (qmail 14343 invoked by uid 1000); 4 May 2006 16:41:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 May 2006 16:41:58 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19576>

On Thu, 4 May 2006, Junio C Hamano wrote:

> * Message-ID: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
> 
>   An optional "git fetch --store newname URL refspecs..." to
>   create an equivalent of remotes file so newname can then be
>   used as a short-hand.  I still have somewhat negative reaction
>   to it, but I am willing to apply it if there are enough people
>   who want this.

I was just about to suggest something for this general use. It's currently 
kind of a pain to deal with the situation where you've got stuff on your 
workstation that you want to version control in a shared repository on a 
server.

I think it shouldn't be on fetch, though; I think a "git remote" command 
for describing, creating, and modifying remotes would be better, since you 
also sometimes want to add a "Push:" line.

Maybe:

 git remote <name>: Print info about <name>
 git remote add <name> <URL> [<direction> ...]: create a remote
 git remote <name> <direction> ...: modify a remote

 where <direction> is either:
  pull <remote> <local> or
  push <local> <remote>

	-Daniel
*This .sig left intentionally blank*
