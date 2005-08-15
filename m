From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 10:22:41 +0200
Message-ID: <20050815082241.GF11882MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <46a038f905081417241f9598cc@mail.gmail.com> <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org> <46a038f905081419057cc6b5cd@mail.gmail.com> <Pine.LNX.4.58.0508141937251.3553@g5.osdl.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 10:16:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4a8g-00081n-Qv
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVHOIQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVHOIQH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:16:07 -0400
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:2713 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S932224AbVHOIQF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 04:16:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id F305B1D74B4
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 10:16:04 +0200 (CEST)
Received: from smtp02.kuleuven.be (lepidus.kulnet.kuleuven.ac.be [134.58.240.72])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 26FD61D73FD
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 10:16:02 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by smtp02.kuleuven.be (Postfix) with ESMTP id 103492CAA05
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 10:16:02 +0200 (CEST)
Received: (qmail 29643 invoked by uid 500); 15 Aug 2005 08:22:41 -0000
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508141937251.3553@g5.osdl.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2005 at 07:49:26PM -0700, Linus Torvalds wrote:
> On Mon, 15 Aug 2005, Martin Langhoff wrote:
> > Except for the keyword expansion. surely there's a way to tell cvsps
> > to not do it. Why would we ever want it?
> 
> Ahh. I don't think we should blame cvsps, I think cvsimport should use the 
> "-ko" flag to disable keyword expansion or whatever the magic flag is.
> 
> Sven, Matthias, opinions? I've never used CVS keyword expansion, and 
> always felt it was pointless, but hey..
> 

I don't have any strong opinion on that, but I do think
that by default a cvsimport should give you the same
file contents that a "cvs import" would.
Martin's patch seems to be going in the right direction.

skimo
