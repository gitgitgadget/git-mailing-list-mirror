From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Thu, 19 May 2005 08:52:07 +0200
Message-ID: <20050519065207.GB18281@pasky.ji.cz>
References: <Pine.LNX.4.21.0505171802570.30848-100000@iabervon.org> <Pine.LNX.4.21.0505182259060.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 19 08:52:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYesT-0007el-Uo
	for gcvg-git@gmane.org; Thu, 19 May 2005 08:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVESGwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 02:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVESGwM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 02:52:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8853 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262421AbVESGwI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 02:52:08 -0400
Received: (qmail 4167 invoked by uid 2001); 19 May 2005 06:52:07 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505182259060.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 19, 2005 at 05:19:01AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
>  2) fetching reference files by name, and making them available to the
>     local program without writing them to disk at all.
>  3) fetching other files by name and writing them to either the
>     corresponding filename or a provided replacement.
> 
> I had thought that (2) could be done as a special case of (3), but I think
> that it has to be separate, because (2) just returns the value, while
> (3) can't just return the contents, but has to write it somewhere, since
> it isn't constrained to be exactly 20 bytes.

Huh. How would (2) be useful and why can't you just still write it e.g.
to some user-supplied temporary file? I think that'd be still actually
much less trouble for the scripts to handle.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
