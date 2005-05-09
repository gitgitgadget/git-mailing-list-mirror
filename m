From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Howto get repository up2date after pull with touching as less as possible files in the working directory
Date: Mon, 9 May 2005 20:18:42 +0200
Message-ID: <20050509181842.GA7040@pasky.ji.cz>
References: <20050509174951.GK24216@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 09 20:53:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCj4-0006Iy-F6
	for gcvg-git@gmane.org; Mon, 09 May 2005 20:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVEISSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 14:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVEISSq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 14:18:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62854 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261459AbVEISSp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 14:18:45 -0400
Received: (qmail 8036 invoked by uid 2001); 9 May 2005 18:18:42 -0000
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050509174951.GK24216@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 07:49:51PM CEST, I got a letter
where Thomas Glanzmann <sithglan@stud.uni-erlangen.de> told me that...
> Hello alltogether,
> at the moment I ensrure that there are no dirty files before the pull
> and do a
> 
> 	git-read-tree HEAD
> 	git-checkout -a -f
> 	git-update-cache --refresh
> 
> this is suboptimal because all the files in my working directory get a
> new timestamp and if I call make everything is recompiled (ccache helps,
> but is not the solution to this problem).

Do git-read-tree -m HEAD instead. That will keep the original stat
information and checkout will rewrite only files it needs to.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
