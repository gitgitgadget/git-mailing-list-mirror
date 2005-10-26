From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add git-name-rev
Date: Wed, 26 Oct 2005 10:36:25 +0200
Message-ID: <20051026083625.GD30889@pasky.or.cz>
References: <Pine.LNX.4.63.0510260103570.27364@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 10:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUgls-0008G1-3m
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 10:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVJZIg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 04:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVJZIg3
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 04:36:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3043 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932592AbVJZIg2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 04:36:28 -0400
Received: (qmail 18690 invoked by uid 2001); 26 Oct 2005 10:36:25 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510260103570.27364@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10652>

Dear diary, on Wed, Oct 26, 2005 at 01:05:59AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> git-name-rev tries to find nice symbolic names for commits. It does so by 
> walking the commits from the refs. When the symbolic name is ambiguous, 
> the following heuristic is applied: Try to avoid too many ~'s, and if two 
> ambiguous names have the same count of ~'s, take the one whose last number 
> is smaller.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

I think you should either add this to git-findtags.perl or (better) add
git-findtags.perl's functionality (i.e. a switch to search only in the
tags) to this and obsolete/kill git-findtags.perl. It is pretty new
(from Oct 13) so killing it shouldn't break anything.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
