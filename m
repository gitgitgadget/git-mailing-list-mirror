From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Fri, 31 Aug 2007 01:37:15 +0200
Message-ID: <20070830233714.GJ1219@pasky.or.cz>
References: <20070825221143.6514.22516.stgit@rover> <fb5vod$vvc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 01:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQtZi-0002xU-7b
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541AbXH3XhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757787AbXH3XhS
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:37:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40970 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbXH3XhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:37:16 -0400
Received: (qmail 20491 invoked by uid 2001); 31 Aug 2007 01:37:15 +0200
Content-Disposition: inline
In-Reply-To: <fb5vod$vvc$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57091>

On Thu, Aug 30, 2007 at 10:39:41AM CEST, Jakub Narebski wrote:
> [Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org]
> 
> Petr Baudis wrote:
> 
> > Should support all the important features, I guess. Too bad that
> >       git-ls-remote --heads .
> >       
> > is subtly different from
> > 
> >       git-ls-remote . refs/heads/
> > 
> > so we have to provide the interface for specifying both.
> 
> Why do not use git-for-each-ref or git-show-refs? If I remember correctly
> they _were_ faster than git-ls-remote or git-peek-remote...

But we want to typically list refs in a remote repository.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
