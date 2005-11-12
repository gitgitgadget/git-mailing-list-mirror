From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] GIT commit statistics.
Date: Sat, 12 Nov 2005 13:53:31 +0100
Message-ID: <20051112125331.GB30496@pasky.or.cz>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org> <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net> <43758D21.3060107@michonline.com> <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net> <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 12 13:53:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eausy-0007ZY-FC
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 13:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKLMxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 07:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVKLMxd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 07:53:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56006 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932259AbVKLMxd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 07:53:33 -0500
Received: (qmail 11979 invoked by uid 2001); 12 Nov 2005 13:53:31 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11682>

Dear diary, on Sat, Nov 12, 2005 at 01:19:45PM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> The same process would be much easier if I could just cg-update from
> the repo and get it to try and actually rebase my local commits --
> rewriting history as if I had committed them after the update. Of
> course, it'd be cheating... but we cheat all the time anyway, we only
> sweat harder at it ;-)

I'm a bit reluctant about this functionality available in cg-update, but
then people will start to want commit stack and stuff, while they should
be just already long using StGIT for tracking their patches.

Actually, I wanted to also implement e-mail functionality to cg-mkpatch,
but I'm not sure now - perhaps people wanting that should really just
use StGIT. Cogito or GIT core is not very suitable for keeping your
patches against someone else's tree if he is not going to GIT-merge with
you, exactly because it's not really very convenient to update your
patches.

On the same note, I would like StGIT to drop functionality not really
belonging to patch stack manager (stg add, stg rm, stg status, ...) so
that its commandset gets smaller and more focused - but before I would
suggest dropping stg status, cg-status must be able to do conflicts
tracking, so I will dedicate another mail to this sometime in the
future, with a more detailed proposal.

So, is there any reason why you want this in GIT/Cogito and don't want
to use StGIT?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
