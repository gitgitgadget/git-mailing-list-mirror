From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: omitted test scripts?
Date: Mon, 19 Sep 2005 13:01:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509191239090.23242@iabervon.org>
References: <200509102027.28812.blaisorblade@yahoo.it>
 <1126427087.8457.33.camel@localhost.localdomain> <200509142019.04667.blaisorblade@yahoo.it>
 <tnxslw6d4qt.fsf@arm.com> <7vvf10hji1.fsf@assigned-by-dhcp.cox.net>
 <1126949517.6941.19.camel@localhost.localdomain> <432EDE3F.7070407@citi.umich.edu>
 <7v1x3lrpxi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cel@citi.umich.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:58:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOwt-00009s-2I
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVISQ4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVISQ4z
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:56:55 -0400
Received: from iabervon.org ([66.92.72.58]:63242 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932496AbVISQ4y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 12:56:54 -0400
Received: (qmail 26566 invoked by uid 1000); 19 Sep 2005 13:01:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Sep 2005 13:01:11 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x3lrpxi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8888>

On Mon, 19 Sep 2005, Junio C Hamano wrote:

> Chuck Lever <cel@citi.umich.edu> writes:
> 
> > i noticed while testing the new cache API that there are no tests under 
> > t/ for git-merge-index.
> 
> In the past, when I did any major butchering of existing code or
> made nontrivial additions, I wrote test scripts to cover what
> should happen (and what to be preserved) first to make sure the
> changes or additions would not introduce regression.  I think we
> have been reasonably successful (Daniel could fill us in with
> experiences with read-tree tests).

I think the only thing missing from the read-tree tests was for refusing 
to create directory/file conflicts which would otherwise be permitted when 
not using the --emu23 flag. Other than that, everything I neglected to 
handle caused something to fail. That reminds me that I still owe you a 
replacement test for this case.

> I have been expecting people to follow suit, without explicitly
> asking them to do, so when I took over the project.  Further I
> got sloppy when accepting any sizable patches.  Sorry about
> that.

I think I also owe you some tests for fetch. Any suggestions on writing 
unit tests? (I'd like to test that fetch.c actually calls functions in the 
right order and such, even in complicated cases)

	-Daniel
*This .sig left intentionally blank*
