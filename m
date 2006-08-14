From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 20:51:30 +0300
Message-ID: <20060814175130.GB16821@mellanox.co.il>
References: <ebpket$7dt$1@sea.gmane.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 19:49:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCgZ9-0005m8-Fd
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 19:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWHNRt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWHNRt1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 13:49:27 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:34263 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S932455AbWHNRtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 13:49:25 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 5a7b0e44.2313149360.124583.00-002.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 14 Aug 2006 11:49:25 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 20:55:28 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 20:51:30 +0300
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ebpket$7dt$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 17:55:28.0312 (UTC) FILETIME=[D3BA0380:01C6BFCA]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25370>

Quoting r. Jakub Narebski <jnareb@gmail.com>:
> Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
> 
> Michael S. Tsirkin wrote:
> 
> > Quoting r. Junio C Hamano <junkio@cox.net>:
> [...]
> >> I have been hesitant to claim that it does not make any sense to
> >> use more than one tracking branch for the same remote branch,
> >> because the only reason I might say so is because I haven't
> >> thought of a good usage pattern to do so.
> >> 
> >> But apparently you do use more than one local branch to keep
> >> track of one remote branch.  How do you use it for?  Do you feel
> >> it is a good feature to be able to do that, or do you think it
> >> is just a mistake and more sensible error message is what we
> >> would really want?
> >> 
> > 
> > Well, what I was *trying* to do is simply add a more descriptive name for
> > the linus master branch to my existing tree.
> > So it seemed like an obvious idea to add
> > 
> > Pull: master:origin
> > Pull: master:linus_master
> 
> Couldn't you do this via symlinks or symrefs? 
> 
> BTW. Do we support symrefs other than HEAD, and does reflog works with
> symref heads, and symlinked heads?

How?

-- 
MST
