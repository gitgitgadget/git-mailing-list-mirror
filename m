From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/3] Introduce "rev-list --stop-at=<commit>".
Date: Fri, 13 May 2005 07:29:02 +0200
Message-ID: <20050513052901.GB16464@pasky.ji.cz>
References: <7v3bssc770.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 07:21:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWSbw-0000F9-V7
	for gcvg-git@gmane.org; Fri, 13 May 2005 07:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVEMF3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 01:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVEMF3G
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 01:29:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1253 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262244AbVEMF3D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 01:29:03 -0400
Received: (qmail 17127 invoked by uid 2001); 13 May 2005 05:29:02 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bssc770.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 13, 2005 at 02:15:15AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Additional option, --stop-at=<commit>, is introduced.  The
> git-rev-list output stops just before showing the named commit.
> 
> This is based on Thoms Gleixner's patch but slightly reworked.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Won't apply for now - as I already said in the relevant thread, this
makes no sense with the current git-rev-list output order, and even
encourages using it in wrong way. It is ok when the merges are reported
in a different way, but that's impossible without some repoid (I yet
have to catch up with that thread :-).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
