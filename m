From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to speed up "git log"?
Date: Sun, 18 Feb 2007 01:33:51 -0500
Message-ID: <20070218063351.GB31350@spearce.org>
References: <200702111252.28393.bruno@clisp.org> <20070211152840.GA2781@steel.home> <200702172019.20536.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Feb 18 07:34:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIfcV-00034T-V7
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 07:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbXBRGd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 01:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbXBRGd5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 01:33:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38701 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030360AbXBRGd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 01:33:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIfcP-0001Ct-F0; Sun, 18 Feb 2007 01:33:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CA6C120FBAE; Sun, 18 Feb 2007 01:33:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702172019.20536.bruno@clisp.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40058>

Bruno Haible <bruno@clisp.org> wrote:
> Alex Riesen wrote:
> > MacOS X is famous for its bad perfomance when doing serious work.
> > The mmap(2) of it, in particular.
> 
> You can see that using mmap() provides a speedup of about 2% on MacOS X,
> which is similar to the 4% than Shawn measured on Linux.

Uh, I was testing on Mac OS X (G4 PowerBook).

-- 
Shawn.
