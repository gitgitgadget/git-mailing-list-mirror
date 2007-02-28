From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 10:54:12 -0500
Message-ID: <20070228155412.GC5479@spearce.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org> <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com> <17893.42063.186763.291346@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMR8l-0001ji-1W
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbXB1PyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXB1PyQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:54:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52631 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbXB1PyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:54:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMR84-0000ja-Ce; Wed, 28 Feb 2007 10:54:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 36A6E20FBAE; Wed, 28 Feb 2007 10:54:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17893.42063.186763.291346@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40951>

Bill Lear <rael@zopyra.com> wrote:
> fatal: cannot pread pack file: Success [n=0; rdy=0; len=207]
> fatal: index-pack died with error code 128
> fetch-pack from '/home/rael/devel/fusion/.git' failed.

Bwhat?!?  Can you print out the offset and the size of the packfile?
It looks like your pack has been truncated?  Or is this just your
filesystem saying "nahh, I'm not going to give you that data right
now, try again later and maybe I will"?

I fail to see how a pread with a length of 207 is getting an EOF
return unless the packfile is short.

-- 
Shawn.
