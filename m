From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Wed, 2 Nov 2005 00:36:47 +0100
Message-ID: <20051101233647.GC1431@pasky.or.cz>
References: <43678C73.1080601@excelsior-online.org> <Pine.LNX.4.64.0511010801370.27915@g5.osdl.org> <7vbr149sbs.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511011646070.25300@iabervon.org> <7vu0ew6jf3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 00:37:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5gY-0006CV-5Z
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVKAXgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVKAXgu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:36:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33468 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751443AbVKAXgt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 18:36:49 -0500
Received: (qmail 31972 invoked by uid 2001); 2 Nov 2005 00:36:47 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0ew6jf3.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10972>

Dear diary, on Wed, Nov 02, 2005 at 12:24:32AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I think it's more confusing for the system to report Z differently from 
> > other things, because there's nothing special about what it found, except 
> > that Z happens to be last.
> 
> What would we get for a simple "mv A B and nothing else" case if
> we follow your proposal and Pasky's?  What about "cp A B and
> nothing else" case?

In case of my proposal, you get the mv and cp as usual, since there are
no multiple rename candidates for A.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
