From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] daemon.c: squelch error message from EINTR
Date: Thu, 4 Aug 2005 22:29:57 +0200
Message-ID: <20050804202957.GD24479@pasky.ji.cz>
References: <7voe8fk0dq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:33:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0mNw-0001BQ-RL
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVHDUbm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVHDUbm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:31:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19723 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262617AbVHDU37 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 16:29:59 -0400
Received: (qmail 19648 invoked by uid 2001); 4 Aug 2005 20:29:57 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe8fk0dq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Aug 03, 2005 at 08:20:01AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I am not sure if this is the right fix, and I have not received
> an answer from the original author of the patch.  I would
> appreciate help from the folks on the list who are familiar with
> the networking.

I think it's fine. EINTR means it got a signal while waiting, it might
be worthwhile checking by strace what signal it actually was - one thing
coming on my mind is SIGPIPE or so, but I barely saw the code. Anyway,
just sticking your hand in sand if you see this is probably fine.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
