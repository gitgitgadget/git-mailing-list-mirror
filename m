From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH/RFT] cvsserver: only allow checkout of branches
Date: Thu, 4 Oct 2007 20:04:44 +0200
Message-ID: <20071004180443.GB31659@planck.djpig.de>
References: <200710031348.50800.wielemak@science.uva.nl> <200710041506.13154.wielemak@science.uva.nl> <Pine.LNX.4.64.0710041622070.4174@racer.site> <200710041906.21004.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Thu Oct 04 20:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdV4S-00071x-68
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 20:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbXJDSEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 14:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756825AbXJDSEz
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 14:04:55 -0400
Received: from planck.djpig.de ([85.10.192.180]:4333 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247AbXJDSEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 14:04:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 8D84988231;
	Thu,  4 Oct 2007 20:04:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhqmXMPNjId0; Thu,  4 Oct 2007 20:04:44 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 71F4D88232; Thu,  4 Oct 2007 20:04:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200710041906.21004.wielemak@science.uva.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59991>

On Thu, Oct 04, 2007 at 07:06:20PM +0200, Jan Wielemaker wrote:
> On Thursday 04 October 2007 17:29, Johannes Schindelin wrote:
> > ) +    {
> > +	$log->warn("Checkout failed: $module is not a branch");
> > +	print "error 1 Checkout failed: $module is not a branch\n";
> 
> There are various places where it says print "...", one that even
> started some suggestion on what might be wrong, but these things don't
> end up at a visible place when using ssh as transport. Its a good idea

huh?

$ CVS_SERVER=/home/djpig/devel/git/git-cvsserver cvs -d :ext:localhost:/home/djpig/devel/gitcvs.git/ co -d cvswork HEAD 
djpig@localhost's password: 
server doesn't support gzip-file-contents
fatal: Needed a single revision
Checkout failed: HEAD is not a branch

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
