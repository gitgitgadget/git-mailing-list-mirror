From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.xs: older perl do not know const char *
Date: Sun, 2 Jul 2006 23:52:49 +0200
Message-ID: <20060702215249.GK29115@pasky.or.cz>
References: <Pine.LNX.4.63.0607021152200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 23:53:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9s5-0003Ub-NP
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWGBVwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGBVwv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:52:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41903 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750837AbWGBVwu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 17:52:50 -0400
Received: (qmail 11037 invoked by uid 2001); 2 Jul 2006 23:52:49 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607021152200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23128>

Dear diary, on Sun, Jul 02, 2006 at 11:53:03AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> Both of these casts _should_ be safe, since you do not want to muck around 
> with the version or the path anyway.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Acked-by: Petr Baudis <pasky@suse.cz>

It isn't all that great but it seems everything xs does with this is to
feed it to sv_setpv() which AFAIK copies it around.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
