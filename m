From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Reorganize common code
Date: Fri, 15 Apr 2005 01:13:18 +0200
Message-ID: <20050414231318.GV22699@pasky.ji.cz>
References: <Pine.LNX.4.21.0504131752410.30848-100000@iabervon.org> <Pine.LNX.4.21.0504131755550.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:10:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDTK-00050h-QD
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVDNXN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVDNXN2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:13:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53965 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261641AbVDNXNU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 19:13:20 -0400
Received: (qmail 19149 invoked by uid 2001); 14 Apr 2005 23:13:18 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504131755550.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 12:00:25AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> This splits read-cache.c into util.c, cache.c, and objects.c, based on
> what the code is used for; similarly, cache.h becomes util.h, cache.h, and
> objects.h. For simplicity, cache.h includes the other two to give the
> previous overall behavior.
> 
> Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

FYI, given the scale of this change, I'm waiting for Linus to either ack
it, pick it himself or reject it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
