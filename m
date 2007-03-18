From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Sun, 18 Mar 2007 17:38:07 -0400
Message-ID: <20070318213807.GB20658@spearce.org>
References: <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com> <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org> <alpine.LFD.0.83.0703172136440.18328@xanadu.home> <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org> <alpine.LFD.0.83.0703172200060.18328@xanadu.home> <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org> <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703180854470.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT35O-00072M-Lm
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbXCRViR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXCRViQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:38:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42303 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbXCRViP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:38:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT34i-0001oW-AE; Sun, 18 Mar 2007 17:38:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C83120FBAE; Sun, 18 Mar 2007 17:38:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703180854470.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42524>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Btw, it's also an example of why the incremental blame is so much nicer.
> 
> No way would I want to wait 53 seconds to get the whole blame. But doing
> 
> 	git gui blame HEAD block/ll_rw_blk.c
> 
> (the "git gui" command line is a bit unwieldly) you get something quite 
> usable!
> 
> Of course, the git gui blame colorization is clearly done by somebody who 
> is still actively popping LSD with both fists and didn't realize that the 
> 60's are long done, but that's another issue.

:-)

git-gui is open source.  I'd be happy to take a patch.  Or,
since that is horribly messy Tcl/Tk code, just a better color
suggestion. :-)

-- 
Shawn.
