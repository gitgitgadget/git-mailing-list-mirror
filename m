From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] GIT: Support [address] in URLs
Date: Thu, 22 Dec 2005 11:48:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512221129060.25300@iabervon.org>
References: <7v1x065blx.fsf@assigned-by-dhcp.cox.net> <7v3bkm3vw4.fsf@assigned-by-dhcp.cox.net>
 <20051222.080828.28117009.yoshfuji@linux-ipv6.org>
 <20051221.152648.122640664.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: yoshfuji@linux-ipv6.org, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 17:47:45 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpTbR-0004mP-SI
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 17:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVLVQrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 11:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVLVQrj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 11:47:39 -0500
Received: from iabervon.org ([66.92.72.58]:18184 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965172AbVLVQri (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 11:47:38 -0500
Received: (qmail 18370 invoked by uid 1000); 22 Dec 2005 11:48:46 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Dec 2005 11:48:46 -0500
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051221.152648.122640664.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13954>

On Wed, 21 Dec 2005, David S. Miller wrote:

> This is a pain, but no better solutions have been suggested.  Before
> anyone responds: 1) making the lists subscriber-only is not an option
> 2) Bayesian filters are hard to integrate into our setup but we are
> exploring ways to make that a reality at some point nevertheless.

Would it work to strip out all of the characters which are only in the 
disallowed character set, change the character set to ascii, and check the 
message like that? (Of course, empty or substantially reduced messages 
should be discarded instead) It looks like the non-spam in these character 
sets only has a few non-ascii characters, and those are transliterated 
into ascii nearby anyway, and I doubt that there's much spam in non-ascii 
with only a few characters in some other character set that wouldn't be 
obvious in some other way after those characters were removed.

	-Daniel
*This .sig left intentionally blank*
