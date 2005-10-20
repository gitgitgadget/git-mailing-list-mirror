From: Petr Baudis <pasky@suse.cz>
Subject: Re: Revamping the git protocol
Date: Thu, 20 Oct 2005 11:12:45 +0200
Message-ID: <20051020091245.GY30889@pasky.or.cz>
References: <43571DA1.6030907@zytor.com> <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 11:14:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESWTl-0001NY-Q5
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 11:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVJTJMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 05:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJTJMr
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 05:12:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4324 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750793AbVJTJMr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 05:12:47 -0400
Received: (qmail 15943 invoked by uid 2001); 20 Oct 2005 11:12:45 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10357>

Dear diary, on Thu, Oct 20, 2005 at 08:11:17AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I am wondering if we can just get away with a simpler scheme
> Linus outlined instead.  One drawback of that approach is it
> does not easily allow things like challenge-response uniformly
> across different commands (admittedly we only have "upload-pack"
> command right now, but we could add list of supported commands
> easily in execute()), but you could do something along this, I
> presume?

What's wrong with my scheme? That is, _reply_ with challenge to the
upload-pack command. This should be equally powerful to the Linus'
scheme and the crucial advantage is that you do not need to tell at
the client side whether you are talking to a new server or an old one.

I was convinced that the authentication part of the challenge-resposne
isn't such a good idea after all, though. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
