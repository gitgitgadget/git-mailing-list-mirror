From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] Allow file list for cg-add through stdin
Date: Sun, 29 May 2005 20:04:42 +0200
Message-ID: <20050529180442.GK1036@pasky.ji.cz>
References: <4299FE8A.1060207@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:03:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcS7D-0004Pa-DK
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVE2SEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVE2SEp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:04:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4334 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261373AbVE2SEo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:04:44 -0400
Received: (qmail 4634 invoked by uid 2001); 29 May 2005 18:04:42 -0000
To: Jochen Roemling <jochen@roemling.net>
Content-Disposition: inline
In-Reply-To: <4299FE8A.1060207@roemling.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 07:40:26PM CEST, I got a letter
where Jochen Roemling <jochen@roemling.net> told me that...
> |Hello,

Hello,

> how is the preferred way to add a whole new directory to a 
> git-repository using cogito?
> Currently cg-add expects all new files on the command line.
> The following patch allows to feed files through stdin, which allows to do
> 
>    find mynewdir -type f | cg-add -

if you really want to do that, pass it through xargs...

> What about a functionality to specify a directory on the command line 
> and all files are
> recursively added?

...but I think this is definitively the right way to go.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
