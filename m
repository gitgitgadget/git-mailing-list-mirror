From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Fri, 11 Nov 2005 00:22:10 +0100
Message-ID: <20051110232210.GC30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <7v7jbig6m7.fsf@assigned-by-dhcp.cox.net> <20051108225320.GB4805@c165.ib.student.liu.se> <7vmzkenzcx.fsf@assigned-by-dhcp.cox.net> <20051109081906.GA4960@c165.ib.student.liu.se> <20051110203411.GX30496@pasky.or.cz> <7vzmocw1xd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 00:24:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaLkG-0006Yq-JS
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 00:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKJXWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 18:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKJXWN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 18:22:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46559 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932265AbVKJXWM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 18:22:12 -0500
Received: (qmail 1249 invoked by uid 2001); 11 Nov 2005 00:22:10 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmocw1xd.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11534>

Dear diary, on Thu, Nov 10, 2005 at 11:52:46PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> One thing I _don't_ like about both is there is no way for 'git
> reset --hard' to get rid of them, when the user decides to retry
> from scratch after seeing a failed merge that left too many of
> them.

Yes. You can cg-clean, but that'll wipe out other stuff as well. I plan
to fix that by adding some conflicts tracking to Cogito - I'm not yet
decided on the particular implementation (only that I certainly don't
want to require the user to manually tell Cogito about resolved
conflicts).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
