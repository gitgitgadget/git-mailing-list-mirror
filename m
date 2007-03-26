From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 22:02:57 -0400
Message-ID: <20070326020257.GB13247@spearce.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk> <alpine.LFD.0.83.0703241913110.18328@xanadu.home> <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org> <Pine.LNX.4.64.0703251004580.6730@woody.linux-foundation.org> <20070325203141.GA12376@spearce.org> <alpine.LFD.0.83.0703252102520.3041@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 04:03:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVeYS-0006Ok-O6
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 04:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbXCZCDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 22:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933387AbXCZCDL
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 22:03:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38699 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933364AbXCZCDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 22:03:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVeXo-00063f-Mm; Sun, 25 Mar 2007 22:02:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D242B20FBAE; Sun, 25 Mar 2007 22:02:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.83.0703252102520.3041@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43105>

Nicolas Pitre <nico@cam.org> wrote:
> Maybe simply 3 bytes might be a good compromise too.  I doubt a single 
> pack is ever to contain 4G paths since it is limited to 4G _objects_ in 
> the first place.

16M paths is also a lot. ;-)
 
> BTW Shawn there is no need to store the number of tree records at the 
> beginning of the tree object since that can be deduced directly from the 
> object size stored in the object header.

Doh.  Yes, of course.

-- 
Shawn.
