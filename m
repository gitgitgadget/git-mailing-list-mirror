From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git-update-cache:
Date: Wed, 6 Jul 2005 00:42:20 +0200
Message-ID: <20050705224220.GA22219@mars.ravnborg.org>
References: <20050705210256.GA28700@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 06 00:42:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpw7r-0001mw-Cs
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 00:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVGEWmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 18:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVGEWmj
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 18:42:39 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:41221 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261946AbVGEWmh
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 18:42:37 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 5E1F25EE046
	for <git@vger.kernel.org>; Wed,  6 Jul 2005 00:42:35 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id EA4266AC021; Wed,  6 Jul 2005 00:42:20 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050705210256.GA28700@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> I receive the following error:
> git-update-cache: symbol lookup error: git-update-cache: undefined
> symbol: deflateBound
> 
	
> open("/usr/lib/libz.so.1", O_RDONLY)    = 3

This is the reason.

For a strange reason when git-update-chache was compiled is was linked
dynamically towards an older libz.so version.
Latest installed is libz.1.2.2 which includes deflateBound.
libz.so.1 points at 1.1.4 which does not.


	Sam
