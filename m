From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port usable
Date: Mon, 29 Jan 2007 17:35:13 -0500
Message-ID: <20070129223513.GA31372@spearce.org>
References: <200701292320.43888.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jan 29 23:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBf6K-0003XQ-0r
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 23:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbXA2WfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 17:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbXA2WfU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 17:35:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57733 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbXA2WfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 17:35:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBf4z-0006hh-PP; Mon, 29 Jan 2007 17:34:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3B21020FBAE; Mon, 29 Jan 2007 17:35:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200701292320.43888.johannes.sixt@telecom.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38101>

Johannes Sixt <johannes.sixt@telecom.at> wrote:
> I'd like to point interested parties to the MinGW port at
> 
>  git://repo.or.cz/git/mingw.git
> 
> which is now in a usable state, methinks. I'm using it with git-gui and gitk 
> on a (almost) production repository.

Well, that's pretty sweet that git-gui is working in a MinGW case.

Last night I pushed out a number of changes to avoid cygpath when
we don't have it in PATH (commit 20ddfcaa).  Were you testing with
that version, or something earlier?

-- 
Shawn.
