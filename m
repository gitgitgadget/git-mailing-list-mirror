From: Ryan Anderson <ryan@michonline.com>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 14:45:25 -0400
Message-ID: <20050728184525.GA3144@mythryan2.michonline.com>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 20:51:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyDS1-0007i1-Hf
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVG1StM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 14:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVG1SrL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 14:47:11 -0400
Received: from mail.autoweb.net ([198.172.237.26]:63898 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261464AbVG1Sp4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 14:45:56 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DyDNm-0005Ca-LH; Thu, 28 Jul 2005 14:45:26 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DyDX7-0005AA-00; Thu, 28 Jul 2005 14:55:05 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DyDNl-0004Yk-TE; Thu, 28 Jul 2005 14:45:25 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2005 at 07:32:55PM +0200, Johannes Schindelin wrote:
> Is it possible that those plans only mean to centralize .git/objects/ and
> leave the rest in single repositories? Seems much more sensible to me.

I think that's accurate.  It can be done without the repositories even
really noticing if "git relink" is used aggressively to migrate
hard links into the repository regularly.  (Though, "packs" cause some
confusion in that scheme, I think.)


-- 

Ryan Anderson
  sometimes Pug Majere
