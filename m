From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: '/dev/null' on Windows is named 'nul'
Date: Wed, 7 Mar 2007 11:57:45 -0500
Message-ID: <20070307165745.GA27922@spearce.org>
References: <45EEE7BA.E0603922@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 17:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOzSm-0000kS-H7
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 17:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbXCGQ5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 11:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbXCGQ5u
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 11:57:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43312 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422731AbXCGQ5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 11:57:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOzSP-0001NH-3c; Wed, 07 Mar 2007 11:57:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7AD8820FBAE; Wed,  7 Mar 2007 11:57:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45EEE7BA.E0603922@eudaptics.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41676>

Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> From: Johannes Sixt <johannes.sixt@telecom.at>
> 
> Making (or amending) an initial commit on Windows fails because
> redirecting something to '/dev/null' must fail - this device does not exist.
> Redirect to 'nul' instead.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  I've noticed this while using the MinGW port, but I do not know whether
>  this is needed or even works on Cygwin.

I had previously fixed this in gitgui-0.6.3, which is now also
merged into `maint` in git.git.  It was fixed by just removing that
redirection block, in git 1.5.0 and later commit-tree doesn't print
anything on stderr when making an initial commit.
 
-- 
Shawn.
