From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 11:48:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601231137250.25300@iabervon.org>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net> <7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
 <7v64ob1omh.fsf@assigned-by-dhcp.cox.net> <200601231206.53466.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 23 17:46:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F14q2-0006GP-3t
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 17:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWAWQqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 11:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWAWQqj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 11:46:39 -0500
Received: from iabervon.org ([66.92.72.58]:2829 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932436AbWAWQqi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2006 11:46:38 -0500
Received: (qmail 23055 invoked by uid 1000); 23 Jan 2006 11:48:41 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2006 11:48:41 -0500
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200601231206.53466.lan@ac-sw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15086>

On Mon, 23 Jan 2006, Alexander Litvinov wrote:

> In our development we use a little bit other case (it is simplified):
> 1. We have self written C++ library for linked list implementation. Lets call 
> it liblist.
> 2. We have project A that use liblist as separate directory and project B that 
> use this library too.
> 
> Currently we have 3 cvs projects with cvs-modules for linking liblist to A and 
> B. During development of A and B we often modify liblist to fix bugs and 
> these changes are immidatly visible to all projects who use liblist.
> 
> After full implementation of bind functionality I see one restriction: I have 
> to use one repo for storing all three projects: A, B and liblist to make 
> changes of liblist visible to all projects. The solution is to make separate 
> repos and on each change of liblist in prokect A push these changes to 
> liblist repo and pull them into project B again - bit hacky solution.

We haven't yet discussed how pushing a repository with subprojects would 
work. We could probably have an extra line in the remotes/ file to make 
the desired thing happen automatically, so that you can just do "git push" 
and have the subproject go to its repository and the main project go to 
its repository.

	-Daniel
*This .sig left intentionally blank*
