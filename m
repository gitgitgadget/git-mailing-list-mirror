From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] \n usage in stderr output
Date: Thu, 15 Dec 2005 09:52:42 +0100
Message-ID: <20051215085242.GO22159@pasky.or.cz>
References: <81b0412b0512142347o6e9aaef8s227ad749f3e2a475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:53:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emor2-0006zj-Po
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 09:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVLOIwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 03:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVLOIwq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 03:52:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59302 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965171AbVLOIwp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 03:52:45 -0500
Received: (qmail 10096 invoked by uid 2001); 15 Dec 2005 09:52:42 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0512142347o6e9aaef8s227ad749f3e2a475@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13687>

Dear diary, on Thu, Dec 15, 2005 at 08:47:30AM CET, I got a letter
where Alex Riesen <raa.lkml@gmail.com> said that...
> fprintf and die sometimes have missing/excessive "\n" in their arguments,
> correct the strings where I think it would be appropriate.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Why don't we just error() or die() at those places anyway?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
