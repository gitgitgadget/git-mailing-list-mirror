From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 10:53:11 -0500
Message-ID: <20070123155311.GB23549@spearce.org>
References: <200701192148.20206.johannes.sixt@telecom.at> <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com> <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org> <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org> <81b0412b0701230745g4b18747ep73d37674a969c1aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian MICHON <christian.michon@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 16:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9NxZ-0005Yp-SY
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbXAWPxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbXAWPxT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:53:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40610 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671AbXAWPxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:53:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H9NxM-0005ld-5f; Tue, 23 Jan 2007 10:53:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BB3EB20FBAE; Tue, 23 Jan 2007 10:53:11 -0500 (EST)
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <81b0412b0701230745g4b18747ep73d37674a969c1aa@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37538>

On 1/23/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>Actually, I have been seriously wondering if there is some setup under
>Wine that I could run, just so that I'd see the Windows development
>environment for git.

Modify Linux VFS layer to:

 - make open take about 10x longer
 - make lstat take about 20x longer

and finally remove any useful programs, except Git.  Use the worst
xterm available.  You are left with a close approximation.

-- 
Shawn.
