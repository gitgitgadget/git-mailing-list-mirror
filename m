From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..."
 page when regenerating cache (WIP)
Date: Sun, 24 Jan 2010 23:24:17 +0100
Organization: 
Message-ID: <20100124222417.GC9553@machine.or.cz>
References: <cover.1264198194.git.jnareb@gmail.com>
 <f4660e9c7ffdb4a62da0c56703de002c9df3b598.1264198194.git.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 23:24:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZAsq-0005yV-PN
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 23:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab0AXWYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 17:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124Ab0AXWYX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 17:24:23 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57630 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab0AXWYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 17:24:21 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id BE8EA125A0ED; Sun, 24 Jan 2010 23:24:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f4660e9c7ffdb4a62da0c56703de002c9df3b598.1264198194.git.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137924>

  I have stupid question, common to both the original patch and this
RFC.

> [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
> regenerating cache (WIP)

  Just why is a "Generating..." page appropriate?

  I have to admit I hate it; can you please at least make it
configurable? Why is it needed at all? It generates unnecessary
redirects, clears my previous page in the browser by a useless
placeholder, confuses non-interactive HTTP clients and I just can't
see the real purpose.

  What's the gain?

  Thanks,

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
