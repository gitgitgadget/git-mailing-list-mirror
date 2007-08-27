From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] gitweb: Lift any characters restriction on
	searched strings
Date: Mon, 27 Aug 2007 05:35:05 +0200
Message-ID: <20070827033505.GP1219@pasky.or.cz>
References: <20070825221847.11739.46741.stgit@rover> <fat7s1$t4a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 05:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPVOA-0003CR-RK
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 05:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbXH0DfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 23:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbXH0DfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 23:35:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55939 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbXH0DfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 23:35:08 -0400
Received: (qmail 13327 invoked by uid 2001); 27 Aug 2007 05:35:05 +0200
Content-Disposition: inline
In-Reply-To: <fat7s1$t4a$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56760>

On Mon, Aug 27, 2007 at 03:02:59AM CEST, Jakub Narebski wrote:
> Petr Baudis wrote:
> 
> > Everything is already fully quoted along the way so I believe this to be
> > unnecessary at this point. It would pose trouble for regexp searches.
> 
> Ack. It looks correct.
>  
> > Cc: Jakub Narebski <jnareb@gmail.com>
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> Actually I have not received it by the mail, so "Cc:" in the body didn't
> work. Did you use git-send-mail?

No, I use StGIT. The last time I've sent this patch it had the Cc' so I
thought "cool, stg mail can do this automagically", but apparently I
probably added that to its commandline manually...

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
