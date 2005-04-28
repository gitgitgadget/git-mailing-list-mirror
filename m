From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Cogito nit: cg-update should default to "origin".
Date: Thu, 28 Apr 2005 02:53:38 +0200
Message-ID: <20050428005337.GA3422@pasky.ji.cz>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz> <42702F20.3050200@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:48:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxCV-0001iJ-HO
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVD1Axp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVD1Axp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:53:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16559 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262134AbVD1Axn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:53:43 -0400
Received: (qmail 5178 invoked by uid 2001); 28 Apr 2005 00:53:38 -0000
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
In-Reply-To: <42702F20.3050200@dwheeler.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 02:32:32AM CEST, I got a letter
where "David A. Wheeler" <dwheeler@dwheeler.com> told me that...
> Minor nit on Cogito: I think cg-update should default to "origin",
> not the head, if you leave it unspecified.  Instead, add an
> option flag to specify the HEAD.  The origin seems (to me)
> to be a MUCH more common situation (and thus the better default).

Actually, I wasn't too happy with the current update-to-HEAD special
case. Sure, it's similar to SVN, but SVN's concepts are totally
different here, and this special case wart (which does really do
something entirely different than normal cg-update) is one of the
Cogito-related shadows in my mind. What about moving this special case
to something like

	cg-restore

and changing the defaulting of update and pull back to 'origin'? I think
people do this cg-update without arguments so seldom that changing this
now shouldn't hurt much, right?

Another thing is to UI-wise maintain clear difference between cg-cancel
and cg-restore. Do you think the names are distinctive enough? Any
better naming ideas?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
