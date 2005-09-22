From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT - breaking backward compatibility
Date: Thu, 22 Sep 2005 16:41:24 +0200
Message-ID: <20050922144124.GJ21019@pasky.or.cz>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 16:45:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EISGT-0006hY-Kk
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 16:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbVIVOl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVIVOl1
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 10:41:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37508 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030386AbVIVOl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 10:41:26 -0400
Received: (qmail 13777 invoked by uid 2001); 22 Sep 2005 16:41:24 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9123>

Dear diary, on Tue, Sep 20, 2005 at 04:07:28AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
>  * Tools renaming plan calls for removal of the backward
>    compatible command names (e.g. git-fsck-cache and
>    git-update-cache) sometime in the future.  This is scheduled
>    for 0.99.8 around beginning of October.  If somebody wants
>    extended amnesty period, this can be pushed back but unless I
>    hear otherwise...

Actually, could we please keep the old git-ssh-* stuff for a bit
(perhaps a lot) longer? The other renames are fine because people
usually keep their git-core and porcelain versions in sync, but the
git-ssh-* stuff is about network interoperability and you are forcing
other people to upgrade their installations, which may be troublesome
for them in the case their distribution didn't package the new stuff yet
or whatever.  It's just two commands after all, so could we please have
them for at least another month or so?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
