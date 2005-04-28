From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] add a diff-files command (revised)
Date: Thu, 28 Apr 2005 04:15:47 +0200
Message-ID: <20050428021547.GB8612@pasky.ji.cz>
References: <Pine.LNX.4.62.0504272141560.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:10:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyU7-0000tX-Jk
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVD1CPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVD1CPy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:15:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48304 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261673AbVD1CPt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 22:15:49 -0400
Received: (qmail 19018 invoked by uid 2001); 28 Apr 2005 02:15:47 -0000
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504272141560.14033@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 04:06:29AM CEST, I got a letter
where Nicolas Pitre <nico@cam.org> told me that...
> In the same spirit as diff-tree and diff-cache, here is a diff-files 
> command that processes differences between the index cache and the 
> working directory content.  It produces lists of files that are either 
> changed, deleted and/or unknown with regards to the current cache, 
> content. The -p option can also be used to generate a patch describing 
> the differences in patch form.

Except some usage enhancement, how does this differ from show-diff?

Also, for some reason you have update-cache.c in your patch too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
