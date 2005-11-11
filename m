From: Petr Baudis <pasky@suse.cz>
Subject: Re: What is cg-clone
Date: Fri, 11 Nov 2005 11:28:24 +0100
Message-ID: <20051111102824.GL30496@pasky.or.cz>
References: <200511110656.29553.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 11:30:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaW90-0003iE-KD
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 11:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVKKK21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 05:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVKKK21
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 05:28:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42669 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751273AbVKKK20 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 05:28:26 -0500
Received: (qmail 23019 invoked by uid 2001); 11 Nov 2005 11:28:24 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200511110656.29553.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11580>

  You seem to have bad luck with subjects today. ;-)

Dear diary, on Fri, Nov 11, 2005 at 07:56:29AM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> Just trying to set up my public repository and test it. 
> 
> cg-clone http://www.chandlerfamily.org.uk/git/famtree.git new
> 
> When I get near the end the following happens:
> 
> http://www.chandlerfamily.org.uk/git/famtree.git/refs/tags/:
> 05:46:53 ERROR 403: Forbidden.
> 
> I suspect its trying to get a list of tags, but is the ":" part of the error 
> message, or was that what it was trying to receive.

It seems to be part of the error message. This is wget's error anyway.

> Does it require that apache serves the directories properly, because at the 
> moment I have DirectoryIndex on these set to gitweb.cgi (although thats 
> giving me 403 errors at the moment, hence my suspicions)

It require_d_ in the past that refs/tags/ would have directory listing
permitted.

This is no longer the requirement right now and in 0.16rc1 (which I
released the last night, but didn't get to write announcement for it
yet).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
