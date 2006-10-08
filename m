From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] pack-refs --all
Date: Sun, 8 Oct 2006 12:14:03 +0200
Message-ID: <20061008101403.GJ20017@pasky.or.cz>
References: <7v4pufkz55.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 12:14:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWVg8-00076U-HS
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 12:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWJHKOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 06:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWJHKOI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 06:14:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35257 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751033AbWJHKOF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 06:14:05 -0400
Received: (qmail 22411 invoked by uid 2001); 8 Oct 2006 12:14:03 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pufkz55.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28530>

Dear diary, on Sun, Oct 08, 2006 at 10:08:54AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> This changes 'git-pack-refs' to pack only tags by default.
> Branches are meant to be updated, either by committing onto it
> yourself or tracking remote branches, and packed entries can
> become stale easily, but tags are usually "create once and live
> forever" and benefit more from packing.
> 
> ---
> 
>  * Likes?  Dislikes?

Looks much saner, thanks. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
