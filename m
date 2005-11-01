From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Tue, 1 Nov 2005 18:39:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511011834050.25300@iabervon.org>
References: <43678C73.1080601@excelsior-online.org>
 <Pine.LNX.4.64.0511010801370.27915@g5.osdl.org> <7vbr149sbs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511011646070.25300@iabervon.org> <7vu0ew6jf3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 00:40:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5jV-00075j-TQ
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVKAXj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVKAXj7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:39:59 -0500
Received: from iabervon.org ([66.92.72.58]:30727 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751444AbVKAXj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 18:39:58 -0500
Received: (qmail 23505 invoked by uid 1000); 1 Nov 2005 18:39:39 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Nov 2005 18:39:39 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0ew6jf3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10973>

On Tue, 1 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I think it's more confusing for the system to report Z differently from 
> > other things, because there's nothing special about what it found, except 
> > that Z happens to be last.
> 
> What would we get for a simple "mv A B and nothing else" case if
> we follow your proposal and Pasky's?  What about "cp A B and
> nothing else" case?

My suggestion for "mv A B" would be:

Rename A
  => B (n%)

Same as the current thing, except with a line break and indentation before 
the arrow.

For "cp A B":

Copy A
  => B (n%)

I think the only difference should be the line with "A" on it, and the 
difference should only depend on whether A still exists.

	-Daniel
*This .sig left intentionally blank*
