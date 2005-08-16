From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add SubmittingPatches
Date: Mon, 15 Aug 2005 23:28:11 -0400
Message-ID: <20050816032811.GI7001@mythryan2.michonline.com>
References: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0508151715520.3553@g5.osdl.org> <Pine.LNX.4.63.0508160252310.26927@wgmdd8.biozentrum.uni-wuerzburg.de> <7vk6imr7x0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508160335420.1574@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 05:29:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4s7h-00053r-5D
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 05:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVHPD2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 23:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVHPD2P
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 23:28:15 -0400
Received: from mail.autoweb.net ([198.172.237.26]:30096 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S965085AbVHPD2P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 23:28:15 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E4s7Y-0000T5-Bz; Mon, 15 Aug 2005 23:28:12 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E4s7X-0004gY-00; Mon, 15 Aug 2005 23:28:11 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E4s7X-00082s-3T; Mon, 15 Aug 2005 23:28:11 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508160335420.1574@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 16, 2005 at 03:41:04AM +0200, Johannes Schindelin wrote:
> On Mon, 15 Aug 2005, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Maybe we should enhance git-applymbox to detect whitespace corruption in 
> > > particular, and output the User-Agent header (or if that does not 
> > > exist, the Message-ID header; thanks, pine) on error.
> > 
> 
> Alternatively, SubmittingPatches could include a big fat CAVEAT, and a 
> note that the submitter might want to send a single SP to herself, save 
> the received mail and check that all is well, prior to sending the first 
> patch. I mean, well, erm, it is sort of, uh, annoying, to send out a 
> corrupt patch *speaksofyourstruly*.

If you have some trouble sending them out, you can use
	git format-patch --mbox
and
	git send-email

which seems to consistently do the right thing.


-- 

Ryan Anderson
  sometimes Pug Majere
