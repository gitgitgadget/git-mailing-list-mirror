From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Tue, 20 Mar 2007 00:39:02 -0400
Message-ID: <20070320043902.GB29288@spearce.org>
References: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org> <alpine.LFD.0.83.0703172136440.18328@xanadu.home> <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org> <alpine.LFD.0.83.0703172200060.18328@xanadu.home> <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org> <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org> <7v3b40d2os.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703192116020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTW7x-000812-G3
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933983AbXCTEjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933988AbXCTEjO
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:39:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36815 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933983AbXCTEjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 00:39:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTW7k-00062L-UL; Tue, 20 Mar 2007 00:39:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CB9C520FBAE; Tue, 20 Mar 2007 00:39:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703192116020.6730@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42704>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Btw, Dscho's slightly more invasive patch seems to *just* edge out Nico's 
> one-liner for me, with best-of-ten being 6.17s.

Uh, instead of Nico here don't you mean DrNick on #git?  He is in
real life Nicholas Miell.  Google says he's somewhat active in the
kernel world, so maybe you know him?  ;-)

-- 
Shawn.
