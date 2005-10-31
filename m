From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Date-based limits (Was Re: GIT 0.99.9)
Date: Mon, 31 Oct 2005 18:47:03 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0510311820060.25300@iabervon.org>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:48:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWjNU-0001gl-MW
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 00:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVJaXrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 18:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVJaXrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 18:47:25 -0500
Received: from iabervon.org ([66.92.72.58]:6672 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964891AbVJaXrY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 18:47:24 -0500
Received: (qmail 23482 invoked by uid 1000); 31 Oct 2005 18:47:03 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2005 18:47:03 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10902>

On Sun, 30 Oct 2005, Linus Torvalds wrote:

> (The danger with date-based things is that something may be 4 months old, 
> but it only got _merged_ yesterday, so it may be new to _you_. And the 
> --since="2 weeks ago" will not show it, which can be surprising to people 
> who expect things that are new to _them_ to be shown).

At some point, we might want to have a series of refs tracking changes to 
the user's heads over time. Then the right set of arguments could actually 
handle "what would I have seen on Thursday, when I hadn't pulled since 
Tuesday, and upstream got some changes on Wednesday that I got on Friday, 
and it's Saturday now." (That is, Wednesday's commits hadn't hit the local 
repository yet; the commit that we got to is dated Friday for local 
purposes, and the latest as of Thursday is dated Tuesday, which is the 
last time the ref file was modified.)

And we probably don't want to fetch or clone this stuff; I doubt most 
people want to know the history from somebody else's point of view. At 
least, I can't think of a use for it that wouldn't be better served by 
asking whoever for the hash out of their history.

	-Daniel
*This .sig left intentionally blank*
