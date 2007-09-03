From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/5] gitweb: Support for arbitrary diffs
Date: Mon, 3 Sep 2007 03:33:30 +0200
Message-ID: <20070903013330.GR1219@pasky.or.cz>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at> <fbfjtl$7gh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 03:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS0pG-0002eM-FT
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 03:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbXICBdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 21:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbXICBdc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 21:33:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56469 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbXICBdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 21:33:32 -0400
Received: (qmail 25916 invoked by uid 2001); 3 Sep 2007 03:33:30 +0200
Content-Disposition: inline
In-Reply-To: <fbfjtl$7gh$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57423>

On Mon, Sep 03, 2007 at 02:19:05AM CEST, Jakub Narebski wrote:
> [Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
>      Petr Baudis <pasky@suse.cz>, git@vger.kernel.org]
> 
> Martin Koegler wrote:
> 
> > Patch 4 now only generates the links, if they are enabled.
> > The header contains a new link to show/hide the links.
> > The state is remembered via a cookie across pages.
> 
> I'd rather have patch adding cookie management (are they only JavaScript,
> or also server side?) as a separate patch.

This is purely in-Javascript thing, so I don't think a separate patch
makes much sense.

To hijack this post a bit, another patch in the queue (the incremental
blame thingie) introduces blame.js. Do you think that we should keep the
.js files separate, or instead have one big gitweb.js with everything?
I'm inclined to the second possibility in order to reduce the number of
requests, but it comes at a price of slightly worse maintainability.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
