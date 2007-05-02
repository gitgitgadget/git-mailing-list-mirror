From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Create pack-write.c for common pack writing code
Date: Wed, 2 May 2007 12:16:48 -0400
Message-ID: <20070502161648.GK5942@spearce.org>
References: <46378656.9080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 18:17:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjHVi-0003p6-BM
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993445AbXEBQQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993446AbXEBQQz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:16:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53099 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993445AbXEBQQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:16:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HjHVT-0003sg-T3; Wed, 02 May 2007 12:16:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 135F020FBAE; Wed,  2 May 2007 12:16:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46378656.9080109@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46031>

Dana How <danahow@gmail.com> wrote:
> 
> Include a generalized fixup_header_footer() in this new file.
> Needed by git-repack --max-pack-size feature in a later patchset.

Thanks.  I'm applying this to my fastimport.git tree, but I changed
the name to fixup_pack_header_footer().  I'm also refactoring the
same code out of index-pack, to call your version.

I'll ask Junio to pull your patch, and my index-pack cleanup soon.
As soon as I'm sure everything still passes the tests.  ;-)

-- 
Shawn.
