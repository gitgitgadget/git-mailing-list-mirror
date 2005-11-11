From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 22:56:20 +0100
Message-ID: <20051111215620.GX16061@pasky.or.cz>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com> <20051111075257.GA4765@c165.ib.student.liu.se> <20051111114511.GQ30496@pasky.or.cz> <7v64qzozyx.fsf@assigned-by-dhcp.cox.net> <20051111173239.GU16061@pasky.or.cz> <7v1x1nni78.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 22:58:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eagsk-0007z1-Nh
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 22:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVKKV4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKKV4Y
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 16:56:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:913 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751247AbVKKV4X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 16:56:23 -0500
Received: (qmail 11149 invoked by uid 2001); 11 Nov 2005 22:56:20 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x1nni78.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11638>

Dear diary, on Fri, Nov 11, 2005 at 07:38:19PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> > Yes, but what I didn't find out is whether the additional trees result
> > in additional stages, what are the trivial merging rules, how does it
> > play together with git-merge-index, etc. Doesn't seem to be documented
> > either.
> 
> Documentation/technical/ perhaps?

This contains the merge resolution tables, which is very useful - thanks
for that.

However, it still doesn't seem to answer my question - do the additional
trees result in additional stages? Let's take e.g.:

	16    anc1/anc2 anc1    anc2      no merge

What ends up in the index at this moment as "stage 1"? anc1? anc2?
Two stage 1 entries? And what does git-merge-index do about this?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
