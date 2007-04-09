From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 9 Apr 2007 14:34:12 -0400
Message-ID: <20070409183412.GY5436@spearce.org>
References: <11760951973172-git-send-email-nico@cam.org> <20070409171925.GS5436@spearce.org> <Pine.LNX.4.64.0704091059240.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704091417490.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:19:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HayhB-0005fn-Vt
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbXDISe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbXDISe0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:34:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40819 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbXDISe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:34:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Haygo-0002ku-HO; Mon, 09 Apr 2007 14:34:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 39A9C20FBAE; Mon,  9 Apr 2007 14:34:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704091417490.28181@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44070>

Nicolas Pitre <nico@cam.org> wrote:
> Once Junio merges the series in a branch of its own, we could have a 
> separate patch not in that branch that simply forces those features on 
> in branch 'next'.  People would only need to remenber not publishing 
> repos with that version using dumb protocols.

Better to force features by config file option or command line
option, then by code hacked into a branch.  This way we can enable
the feature all of the time in a test case, and push it.  E.g. the
sliding window controls; nobody really uses them in practice (I
don't think anyway) but they are handy in the test cases to force
particular conditions, without creating huge temporary packfiles.

-- 
Shawn.
