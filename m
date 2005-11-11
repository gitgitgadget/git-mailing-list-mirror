From: Petr Baudis <pasky@suse.cz>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 18:32:39 +0100
Message-ID: <20051111173239.GU16061@pasky.or.cz>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com> <20051111075257.GA4765@c165.ib.student.liu.se> <20051111114511.GQ30496@pasky.or.cz> <7v64qzozyx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 18:33:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eacla-0001uP-Rs
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 18:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVKKRcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 12:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVKKRcn
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 12:32:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3032 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750919AbVKKRcn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 12:32:43 -0500
Received: (qmail 18667 invoked by uid 2001); 11 Nov 2005 18:32:39 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64qzozyx.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11619>

Dear diary, on Fri, Nov 11, 2005 at 06:29:10PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - The above turned out to have a risky corner case, especially
>    when one side reverted a patch and the other one did not.  To
>    address this, read-tree was rewritten and 3-way form of
>    read-tree can take more than three trees these days, letting
>    you feed it all the merge base candidates.  This code is used
>    in 'resolve' strategy.

Yes, but what I didn't find out is whether the additional trees result
in additional stages, what are the trivial merging rules, how does it
play together with git-merge-index, etc. Doesn't seem to be documented
either.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
