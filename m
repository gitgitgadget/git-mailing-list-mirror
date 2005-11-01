From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Wed, 2 Nov 2005 00:06:35 +0100
Message-ID: <20051101230635.GA1431@pasky.or.cz>
References: <43678C73.1080601@excelsior-online.org> <Pine.LNX.4.64.0511010801370.27915@g5.osdl.org> <7vbr149sbs.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511011646070.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 00:07:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5DI-0005dU-1q
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbVKAXGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKAXGi
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:06:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:65184 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751424AbVKAXGh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 18:06:37 -0500
Received: (qmail 28056 invoked by uid 2001); 2 Nov 2005 00:06:35 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511011646070.25300@iabervon.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10966>

Dear diary, on Tue, Nov 01, 2005 at 11:03:26PM CET, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Tue, 1 Nov 2005, Junio C Hamano wrote:
> > Would it be easier to read if we say A was renamed to B, and A
> > was renamed to C, and A was renamed to D, ...?  I think the
> > current output is easier to understand than that.  B-Y gets
> > labelled as copy of A and Z gets labelled as rename.
> 
> I think it's more confusing for the system to report Z differently from 
> other things, because there's nothing special about what it found, except 
> that Z happens to be last.

I agree, but I'd prefer it to be labelled as a copy+remove instead of a
rename in case it is ambiguous. Just a simple rule - if the file was
removed and you get multiple rename candidates, mark all of them as
'copy'.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
