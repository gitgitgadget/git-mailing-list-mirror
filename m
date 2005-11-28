From: Petr Baudis <pasky@suse.cz>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 11:57:36 +0100
Message-ID: <20051128105736.GO22159@pasky.or.cz>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us> <7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Cloos <cloos@jhcloos.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 11:58:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgghN-0002xU-7S
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 11:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVK1K50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 05:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVK1K50
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 05:57:26 -0500
Received: from w241.dkm.cz ([62.24.88.241]:12447 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751254AbVK1K50 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 05:57:26 -0500
Received: (qmail 23480 invoked by uid 2001); 28 Nov 2005 11:57:36 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12872>

Dear diary, on Mon, Nov 28, 2005 at 08:48:26AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> James Cloos <cloos@jhcloos.com> writes:
> 
> > Is it possible to arrange that a push does a checkout on the remote
> > the same way a pull does on the local?
> 
> Creative use of hooks/post-update would solve that.
> 
> However, you should be very careful if you sometimes edit on
> server and sometimes push from other machine to the server on
> the same branch on the server.

Why? At worst you will get files with conflict markers on the server,
which isn't that huge problem and just what you have to expect when you
do this kind of thing. I could imagine having an option in the config
file describing whether the repository is "raw" or has the working copy
associated, and in the later case have the updating code in the default
post-update hook.

PS: If someone is bored, it would be very useful to have a manual page
for the git configuration file, containing the list of all options.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
