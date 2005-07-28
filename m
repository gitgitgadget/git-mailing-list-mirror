From: Petr Baudis <pasky@suse.cz>
Subject: Re: Handover, Make
Date: Thu, 28 Jul 2005 09:54:24 +0200
Message-ID: <20050728075424.GC18907@pasky.ji.cz>
References: <42E813D3.7020804@khandalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 10:32:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy3nr-00074S-PY
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 10:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVG1ICt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 04:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVG1Hz3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 03:55:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36615 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261358AbVG1Hy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 03:54:26 -0400
Received: (qmail 22732 invoked by uid 2001); 28 Jul 2005 07:54:24 -0000
To: Brian O'Mahoney <omb@khandalf.com>
Content-Disposition: inline
In-Reply-To: <42E813D3.7020804@khandalf.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 01:08:03AM CEST, I got a letter
where Brian O'Mahoney <omb@khandalf.com> told me that...
> First, congratulations Junio, on taking over this stuff, and all the best.
> 
> Second, the killer argument, in the 'Recursive Make ... harmful' is the
> basic one that Recursive Makes breaks up the dependancy graph, and
> almost guarentees that it is wrong unless you do a lot of work to fix
> that artifact. Now git is small enough that make clean; make won't take
> too long

I think there are basically none dependencies like this, or if they are
any, they virtually never break under regular usage. At least I never do
make clean and I never saw a rebuild of git to break.

I think especially for smaller projects recursive make is just fine and
makes maintenance easier, and I think most of the arguments about the
dependency graph rarely matter in real projects (especially ones of the
size of git). So I'd say, keep it as it is till we can. :-)

> but git is also a basis for other layers, so there is good
> reason to try to get it right.

For what layers?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
