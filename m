From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 9 Apr 2007 13:19:25 -0400
Message-ID: <20070409171925.GS5436@spearce.org>
References: <11760951973172-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 22:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaxWh-00023S-8z
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 19:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbXDIRTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbXDIRTc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 13:19:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37999 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbXDIRTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 13:19:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HaxWT-0004hw-3U; Mon, 09 Apr 2007 13:19:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D2F320FBAE; Mon,  9 Apr 2007 13:19:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11760951973172-git-send-email-nico@cam.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44066>

Nicolas Pitre <nico@cam.org> wrote:
> This patch series adds support for large packs to GIT.  It creates a new
> index format to accommodate both larger offsets and to store a checksum
> for each raw object in a pack.  More details is provided in each patch
> commit message.
> 
> This is not a replacement for the pack size limiting feature.  I think that
> GIT should support both: large packs and split packs.

I like this series.  I haven't had time to test it myself yet,
and probably won't be able to do so before Junio merges it into a
pu or next release.  But it looks OK on a first read.

It is unfortunate that we are changing the index file format without
also bringing in packv4 support at the same time.  I have just been
too swamped in useless bulls**t in day-job work to spend time on
Git lately.

-- 
Shawn.
