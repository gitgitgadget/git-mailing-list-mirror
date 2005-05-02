From: Petr Baudis <pasky@ucw.cz>
Subject: Re: More problems...
Date: Mon, 2 May 2005 23:13:49 +0200
Message-ID: <20050502211349.GD20818@pasky.ji.cz>
References: <20050429170127.A30010@flint.arm.linux.org.uk> <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 23:09:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSi9S-0002Ij-Se
	for gcvg-git@gmane.org; Mon, 02 May 2005 23:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVEBVOC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 17:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVEBVOB
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 17:14:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29362 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261778AbVEBVN6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 17:13:58 -0400
Received: (qmail 1255 invoked by uid 2001); 2 May 2005 21:13:49 -0000
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20050429195055.GE1233@mythryan2.michonline.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 29, 2005 at 09:50:55PM CEST, I got a letter
where Ryan Anderson <ryan@michonline.com> told me that...
> Why not just use "rsync" for both remote and local synchronization, and
> provide a "relink" command to scan two .git/objects/ repositories and
> hardlink matching files together?

No. This completely misses the point, which is to avoid useless I/O when
doing this local stuff; also, it saves disk space to a degree, but it is
wildly fluctuating.

I like Junio's local-pull solution much more (from the conceptual
standpoint; I didn't look at the code yet).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
