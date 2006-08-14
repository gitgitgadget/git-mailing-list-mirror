From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 09:33:09 +0300
Message-ID: <20060814063309.GD21963@mellanox.co.il>
References: <7vzme7g8wt.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 08:31:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCVyg-0004xb-M1
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 08:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWHNGbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 02:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWHNGbH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 02:31:07 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:15494 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751884AbWHNGbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 02:31:05 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 9a810e44.2321525680.2121.00-004.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 14 Aug 2006 00:31:05 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 09:37:07 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 09:33:09 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzme7g8wt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 06:37:07.0953 (UTC) FILETIME=[106C1610:01C6BF6C]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25324>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > BTW, does it still look like it's worth it the effort to lift the restriction,
> > or does fixing the error message to something like
> > "no such remote or duplicate ref %s"
> > make more sense to you?
> 
> I have been hesitant to claim that it does not make any sense to
> use more than one tracking branch for the same remote branch,
> because the only reason I might say so is because I haven't
> thought of a good usage pattern to do so.
> 
> But apparently you do use more than one local branch to keep
> track of one remote branch.  How do you use it for?  Do you feel
> it is a good feature to be able to do that, or do you think it
> is just a mistake and more sensible error message is what we
> would really want?
> 

Well, what I was *trying* to do is simply add a more descriptive name for
the linus master branch to my existing tree.
So it seemed like an obvious idea to add

Pull: master:origin
Pull: master:linus_master

On a more theoretical level, in a shared repository development style, one might
imagine several people who want the branch to be called differently.
Another reason might be scripts using specific branch names where you
might want to be free to decide where a specific branch name points to.

Yea, I still feel it would be a good feature to have - I just wanted to
check there's no opposition to this.

-- 
MST
