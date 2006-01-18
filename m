From: Petr Baudis <pasky@suse.cz>
Subject: Re: "tla missing -s" equivalent with git/cogito
Date: Wed, 18 Jan 2006 20:26:38 +0100
Message-ID: <20060118192638.GU28365@pasky.or.cz>
References: <43CE5666.90502@itaapy.com> <46a038f90601180956r69ba5dffl2106f697a6be4750@mail.gmail.com> <20060118185542.GT28365@pasky.or.cz> <46a038f90601181107h57e6fb73peb199689349aec41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luis@itaapy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 20:25:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIvx-0002Mk-6O
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 20:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWARTZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 14:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWARTZZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 14:25:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:45751 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964900AbWARTZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 14:25:25 -0500
Received: (qmail 27787 invoked by uid 2001); 18 Jan 2006 20:26:38 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90601181107h57e6fb73peb199689349aec41@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14860>

Dear diary, on Wed, Jan 18, 2006 at 08:07:27PM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 1/19/06, Petr Baudis <pasky@suse.cz> wrote:
> > Now you want to merge the branch as a whole. Cherrypicking-aware VCS
> > would just merge the patch2, but you are taking the whole diff:
> ...
> > And you get a conflict instead of b\nc.
> 
> While I haven't tested your particular example, it looks to me like
> git-cherry would identify it correctly. So far my experience has been
> that git-cherry's strategy detects my cherry-picked patches pretty
> well.
> 
> Why would it not work in your example? Patch 1 has clearly been
> applied in both branches, and git-cherry would normally detect that
> alright.

  It probably would. So? We are talking about git-merge and cg-merge
here. Now, it might be interesting to have a cherry-aware merge
strategy, but I suspect that the conflicts handling there would be quite
non-trivial.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
