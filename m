From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Fri, 18 May 2007 14:35:38 +0200
Message-ID: <20070518123538.GW4489@pasky.or.cz>
References: <20070517023112.21056.62390.stgit@rover> <f2k4d5$879$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 14:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp1gS-0000OS-MY
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847AbXERMfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758031AbXERMfl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:35:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36289 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757663AbXERMfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:35:40 -0400
Received: (qmail 13676 invoked by uid 2001); 18 May 2007 14:35:38 +0200
Content-Disposition: inline
In-Reply-To: <f2k4d5$879$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47602>

On Fri, May 18, 2007 at 01:58:28PM CEST, Jakub Narebski wrote:
> [Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>, 
>  git@vger.kernel.org]

Your MUA seems to have finally decided to go completely crazy or
something. :-) Different mails go to us and the list.

> Petr Baudis wrote:
> 
> > The 'grep' type of search greps the currently selected tree for given
> > regexp and shows the results in a fancy table with links into blob view.
> > The number of shown matches is limited to 1000 and the whole feature
> > can be turned off (grepping linux-2.6.git already makes repo.or.cz a bit
> > unhappy).
> 
> Ack, FWIW.

I want to implement the regexp checkbox.

> By the way, I wonder if we should make search context (view) sensitive.
> For example for 'history' view search would be limited to given pathspec,
> grep search in a 'tree' view would search given tree only.

I think it would be nice (if it's clearly visible that the results are
filtered), but I'm probably not the one who is going to implement this.
;-)

> Additionally it would be nice to have links from search results page to
> have search match highlighted, like search results on GitWiki.

I'm sorry, I don't understand.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
