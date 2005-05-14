From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: speeding up cg-log -u
Date: Sat, 14 May 2005 07:23:25 -0700
Message-ID: <20050514142325.GC14353@tumblerings.org>
References: <20050514061914.GB14353@tumblerings.org> <7vu0l62l27.fsf@assigned-by-dhcp.cox.net> <20050514061914.GB14353@tumblerings.org> <20050514103937.GA3905@pasky.ji.cz> <7vk6m212g7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 14 16:28:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWxdC-00083L-Lw
	for gcvg-git@gmane.org; Sat, 14 May 2005 16:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVENO2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 10:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVENO2g
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 10:28:36 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:36498 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262772AbVENO2U
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 10:28:20 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DWxY5-0003fV-Ay; Sat, 14 May 2005 07:23:25 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6m212g7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 14, 2005 at 04:17:44AM -0700, Junio C Hamano wrote:
> Not wanting to keep the whole object because of their size is
> understandable since the users of "struct object" derivatives
> rarely if ever seem to free them once they get hold of them.
> And not wanting to think ahead about what is worth keeping (like
> names for tree entries back then, or commit author names) is
> also understandable, but it still is frustrating.

So if this design is changed to suit -u, would a further redesign be needed
to support an option to filter on keywords in the body of the changelog
entry? Perhaps this will result in a net slowdown for the usual case of just
grabbing all log entries.

Be well,
Zack

>  Not that I
> would want to solve this myself ...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
