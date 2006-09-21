From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 01:52:53 -0400
Message-ID: <20060921055252.GA29479@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vlkoeds82.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 07:53:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQHUY-0007Fw-OJ
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 07:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWIUFw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 01:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWIUFw4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 01:52:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:48060 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751240AbWIUFwz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 01:52:55 -0400
Received: (qmail 6500 invoked from network); 21 Sep 2006 01:52:03 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 21 Sep 2006 01:52:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2006 01:52:53 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27454>

On Thu, Sep 21, 2006 at 02:17:22AM +0200, Johannes Schindelin wrote:

> So we indeed assumed that git-merge-base returns the old commit in the 
> case of a fast-forward (git-merge-base returns just the first item of the 
> result of get_merge_bases()).
> 
> Note that I have no proof that this assumption is true. It might be wrong 
> in this case:
> 
>     X - a - b - c - Y
>   /           /
> o - d - e - f

In your example, git-merge-base X Y returns X. In fact, I could only get
one merge base out of git-merge-base --all. I tried looking in the tests
to find a case that produced multiple merge bases, but I was unable to
find one. Is there an example floating around somewhere?

-Peff
