From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (GIT-GUI)] git-gui: Reenable staging unmerged files by
	clicking the icon.
Date: Wed, 24 Sep 2008 12:53:01 -0700
Message-ID: <20080924195301.GA29793@spearce.org>
References: <200809201219.18630.angavrilov@gmail.com> <20080924182508.GC3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:54:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiaRG-0003SJ-5K
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 21:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYIXTxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 15:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbYIXTxD
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 15:53:03 -0400
Received: from george.spearce.org ([209.20.77.23]:40988 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbYIXTxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 15:53:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 25C823835F; Wed, 24 Sep 2008 19:53:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080924182508.GC3669@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96685>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Alexander Gavrilov <angavrilov@gmail.com> wrote:
> > This restores functionality of the file icon for unmerged files.
> > Safety is enforced by loading the diff and checking for lines
> > that look like conflict markers. If such lines are found, or
> > the conflict involves deletion and/or symlinks, a confirmation
> > dialog is presented. Otherwise, the icon immediately stages the
> > working copy version of the file.
> > 
> > Includes a revert of 2fe5b2ee42897a3acc78e5ddaace3775eb2713ca
> > (Restore ability to Stage Working Copy for conflicts)
> 
> Can I get a resend of this patch?

Never mind.  Its applied now.  I broke down after lunch and found
the one hunk that was an issue, and trivially hand merged it.
 
-- 
Shawn.
