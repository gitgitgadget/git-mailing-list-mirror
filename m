From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git repository for net drivers available
Date: Sun, 15 May 2005 16:20:50 -0400
Message-ID: <4287AF22.8090300@pobox.com>
References: <42841A3F.7020909@pobox.com> <4284C54E.3060907@linux.intel.com> <4284C7DA.1020707@pobox.com> <20050515200514.GA31414@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: James Ketrenos <jketreno@linux.intel.com>,
	Netdev <netdev@oss.sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 15 22:21:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXPbi-0001Ub-AJ
	for gcvg-git@gmane.org; Sun, 15 May 2005 22:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVEOUVC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 16:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEOUVC
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 16:21:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51863 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261225AbVEOUU4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 16:20:56 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DXPbY-0004SP-Nm; Sun, 15 May 2005 20:20:53 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050515200514.GA31414@pasky.ji.cz>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Fri, May 13, 2005 at 05:29:30PM CEST, I got a letter
> where Jeff Garzik <jgarzik@pobox.com> told me that...
> 
>>Looks like cogito is using $repo/heads/$branch, whereas my git repo is 
>>using $repo/branches/$branch.
> 
> 
> Would it be a big problem to use refs/heads/$branch? That's the
> currently commonly agreed convention about location for storing branch
> heads, not just some weird Cogito-specific invention. And it'd be very
> nice to have those locations consistent across git repositories.

Sure, that's doable.

I've pushed out this change to kernel.org.

	Jeff



