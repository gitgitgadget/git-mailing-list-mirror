From: Petr Baudis <pasky@suse.cz>
Subject: Re: Tracking files across tree reorganizations
Date: Thu, 15 Dec 2005 02:44:53 +0100
Message-ID: <20051215014453.GN22159@pasky.or.cz>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz> <Pine.LNX.4.64.0512141538440.3292@g5.osdl.org> <43A0AE6B.3040309@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 02:46:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmiB1-0007mm-9C
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVLOBo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVLOBoz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:44:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49366 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030287AbVLOBoz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 20:44:55 -0500
Received: (qmail 17634 invoked by uid 2001); 15 Dec 2005 02:44:53 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43A0AE6B.3040309@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13671>

Dear diary, on Thu, Dec 15, 2005 at 12:44:43AM CET, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> HOWEVER, I maintain that this is unnecessary (and, as Linus has pointed 
> out several time, losing) -- we already detect renames without relying 
> on commit-time metadata.  If it's too expensive to generate the metadata 
> on every merge, it can be cached.

Just for the record, I'm not convinced at all (there's probably no
point in elaborating the reasons again). I give up, though - I don't
know how to store the explicit rename information "invisibly" so that
Linus would be willing to merge commits containing it, and that would
make the whole thing pretty much pointless at least for the kernel.

I plan to revive some old patches changing large portions of cg-log
in the next few days, consequently making it trivial to add the
on-the-fly automatic renames detection to per-file cg-log.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
