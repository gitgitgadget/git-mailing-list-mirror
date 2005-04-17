From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 22:18:56 +0200
Message-ID: <20050417201856.GJ1461@pasky.ji.cz>
References: <20050417195935.GI1461@pasky.ji.cz> <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jackson <pj@sgi.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 22:46:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGek-0001aS-MW
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVDQUtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDQUmx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:42:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49814 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261503AbVDQUS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 16:18:59 -0400
Received: (qmail 14533 invoked by uid 2001); 17 Apr 2005 20:18:56 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 10:03:46PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Sun, 17 Apr 2005, Petr Baudis wrote:
> 
> > Dear diary, on Sun, Apr 17, 2005 at 09:25:17PM CEST, I got a letter
> > where Paul Jackson <pj@sgi.com> told me that...
> > > Petr wrote:
> > > > BTW, I'd just use access(F_OK) instead of stat() it I don't care about
> > > 
> > > I recommend _only_ using it when you require exactly the above real vs.
> > > effective id behaviour.
> > 
> > Does this distinction have any effect when doing F_OK?
> 
> Actually, the documentation I've got says:
> 
> "F_OK requests checking whether merely testing for the existence of the
>  file would be allowed (this depends on the permissions of the directories
>  in the path to the file, as given in path-name.)"
> 
> So it shouldn't complain about a filename which you're allowed to try to
> stat, even if there's nothing there. And it would depend on the privs of
> the wrong user in looking at the path.

The documentation I've got says:

"R_OK,  W_OK  and  X_OK request checking whether the file exists and has
 read, write and execute permissions, respectively.  F_OK just requests
 checking for the existence of the file."

And IEEE1003.1 agrees:
http://www.opengroup.org/onlinepubs/009695399/functions/access.html

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
