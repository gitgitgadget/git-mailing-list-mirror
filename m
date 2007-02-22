From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Include git-gui credits file in dist.
Date: Wed, 21 Feb 2007 23:56:17 -0500
Message-ID: <20070222045617.GA28043@spearce.org>
References: <20070222044951.GA28013@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 05:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK60N-0006ao-U5
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 05:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXBVE4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 23:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbXBVE4V
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 23:56:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37228 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXBVE4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 23:56:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HK5zy-0005gd-Mr; Wed, 21 Feb 2007 23:56:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4FD9C20FBAE; Wed, 21 Feb 2007 23:56:17 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070222044951.GA28013@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40335>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> The Makefile for the git-gui subproject will fail to execute if run
> outside of a git.git directory, such as when building from a .tar.gz
> or .tar.bz2.  This is because it is looking for the credits file,
> which was created but omitted from the tarball by the toplevel
> Makefile.

Obviously I forgot this little line, sorry:

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
 
-- 
Shawn.
