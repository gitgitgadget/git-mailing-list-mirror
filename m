From: bdowning@lavos.net (Brian Downing)
Subject: Re: gitk screenshots of complex history
Date: Fri, 27 Jul 2007 08:52:38 -0500
Message-ID: <20070727135238.GW21692@lavos.net>
References: <20070727041300.GD20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 15:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEQFS-0004cI-EI
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 15:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760043AbXG0Nwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 09:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933398AbXG0Nwv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 09:52:51 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:42047 "EHLO
	asav04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224AbXG0Nwu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 09:52:50 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav04.insightbb.com with ESMTP; 27 Jul 2007 09:52:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqMwANSVqUZKhvbzRmdsb2JhbACBTY4RAQEBNQE
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 4BBD8309F31; Fri, 27 Jul 2007 08:52:38 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070727041300.GD20052@spearce.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53927>

On Fri, Jul 27, 2007 at 12:13:01AM -0400, Shawn O. Pearce wrote:
> I've mentioned both on list and on #git that one of my production
> repositories has a few weird points in time.  Some folks have asked
> to see at least screenshots of the line part of the gitk output,
> as apparently they've never seen ugly history in Git.  Lucky them.
> 
> The images are rather large so I have posted them on my website
> with a bit longer explanation of each:
> 
>   http://www.spearce.org/2007/07/difficult-gitk-graphs.html
 
> OK, no more screenshots from *that* repository!  I don't ever want
> to run `gitk --all` there again.  Ever.

Were those graphs generated with --topo-order (the default) or
--date-order?  I've found complex history usually looks a lot more
manageable with --date-order.  Certainly the Git history is a LOT less
wide with --all --date-order than --all.

Does this help your situation as well?

-bcd
