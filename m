From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Incremental blame
Date: Fri, 18 May 2007 17:26:34 +0200
Message-ID: <20070518152634.GY4489@pasky.or.cz>
References: <20070518151502.27621.36135.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <frekui@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 17:26:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp4Ls-00088s-EU
	for gcvg-git@gmane.org; Fri, 18 May 2007 17:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbXERP0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 11:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbXERP0g
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 11:26:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55694 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135AbXERP0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 11:26:36 -0400
Received: (qmail 5075 invoked by uid 2001); 18 May 2007 17:26:34 +0200
Content-Disposition: inline
In-Reply-To: <20070518151502.27621.36135.stgit@rover>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47615>

On Fri, May 18, 2007 at 05:15:02PM CEST, Petr Baudis wrote:
> Compared to the original patch, this one works with pathinfo-ish URLs as
> well, and should play well with non-javascript browsers as well (the HTML
> points to the blame action, while javascript code rewrites the links to use
> the blame_incremental action; it is somewhat hackish but I couldn't think
> of a better solution).

To make it more clear, the additional changes in this patch are really
totally trivial (except the link rewriting javascript code, which is
rather simple too and I spent only two happy hours of my life debugging
it) - maybe I should've kept Fredrik signed off and maybe even the patch
author and add just my signoff. I'm not really sure how the procedures
should work here.

-- 
		Petr "Pasky the I HATE THE
			!@#*($!*(^%@#*$233.. JAVASCRIPT!!!!!!!!" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
