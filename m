From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Mon, 18 Apr 2005 03:48:58 +0200
Message-ID: <20050418014858.GI1461@pasky.ji.cz>
References: <20050417195935.GI1461@pasky.ji.cz> <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org> <20050417201856.GJ1461@pasky.ji.cz> <20050417183508.15beb1fd.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:45:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLK3-0006bw-HY
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVDRBtC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVDRBtC
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:49:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16284 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261586AbVDRBs7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:48:59 -0400
Received: (qmail 8627 invoked by uid 2001); 18 Apr 2005 01:48:58 -0000
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050417183508.15beb1fd.pj@sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 03:35:08AM CEST, I got a letter
where Paul Jackson <pj@sgi.com> told me that...
> Petr wrote:
> > The documentation I've got says:
> > 
> > "R_OK,  W_OK  and  X_OK request checking whether the file exists and has
> >  read, write and execute permissions, respectively.  F_OK just requests
> >  checking for the existence of the file."
> 
> You don't exactly say it, but I'm guessing that you think that this
> documentation is stating that F_OK checks for the existance of the file
> _regardless_ of path access permissions.
> 
> No so.  Write your own little test program, and/or read the kernel source.
> 
> Even if the file exists, if its directory entry is not accessible to the
> _real_ uid/gid, access F_OK will fail.  If the problem is a lack of
> seach permissions on some directory in the path, the errno will be
> EACCES.

Ok, I stand corrected; and when giving the access(2) manual page a
second look, it could imply that too. It has some room for more
crystal-clearness, though. ;-)

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
