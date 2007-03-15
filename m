From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: error with symlinks on OSX
Date: Thu, 15 Mar 2007 15:44:10 -0400
Message-ID: <20070315194410.GC29547@spearce.org>
References: <m2r6rqbfcy.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 20:44:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRvs2-0007ST-R7
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 20:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbXCOToP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 15:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933208AbXCOToP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 15:44:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49088 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933089AbXCOToO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 15:44:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HRvro-0000Af-1p; Thu, 15 Mar 2007 15:44:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D29FA20FBAE; Thu, 15 Mar 2007 15:44:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m2r6rqbfcy.fsf@ziti.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42296>

Seth Falcon <sethfalcon@gmail.com> wrote:
> error: git-checkout-index: unable to create symlink Category/Makefile (Invalid argument)
> 
> Now while my file system isn't smart enough to tell the difference
> between t and T, it does support symlinks AFAIK.

Yes, it does support symlinks.  Is it possible that the name Category
already existed, but as a file?  Hmm.
 
-- 
Shawn.
