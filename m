From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Create pack-write.c for common pack writing code
Date: Wed, 2 May 2007 12:31:22 -0400
Message-ID: <20070502163122.GL5942@spearce.org>
References: <46378656.9080109@gmail.com> <20070502161648.GK5942@spearce.org> <alpine.LFD.0.98.0705021226010.6574@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 02 18:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjHjo-0001UL-HL
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbXEBQb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbXEBQb3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:31:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53646 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbXEBQb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:31:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HjHja-0004cU-9M; Wed, 02 May 2007 12:31:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9642C20FBAE; Wed,  2 May 2007 12:31:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705021226010.6574@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46035>

Nicolas Pitre <nico@cam.org> wrote:
> BTW I think the common function should _not_ close the file descriptor 
> it is being handed.   It is more flexible to let the caller close the 
> file, or possibly do whatever other operations like fchmod().

I didn't mention it, but I agree, and fixed it in Dana's patch.

-- 
Shawn.
