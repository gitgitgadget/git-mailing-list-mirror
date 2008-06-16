From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT RFC] Commit behaviour
Date: Sun, 15 Jun 2008 22:11:58 -0400
Message-ID: <20080616021158.GQ11793@spearce.org>
References: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 04:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K84DN-00083k-0I
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 04:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbYFPCMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 22:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYFPCMF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 22:12:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39665 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYFPCME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 22:12:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K84CD-0001tH-Td; Sun, 15 Jun 2008 22:11:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D095920FBAE; Sun, 15 Jun 2008 22:11:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85157>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> I got annoyed about having change my selection to a project to be able
> to commit. This tentative feature allows me to hit the commit button
> when any resource is selected and figure out which resources have been
> modified. This makes it much easier to commit. Only the toolbar commit
> is affected for now.
> 
> Another twist would be to list all changed resources, but only enable
> the selected ones, or only the ones in in the same projects as the selected
> resources. Comments?

I think this is a good idea.  You really do want to make commits
that cover the entire repository, rather than a subsection of it.
I think that covering the whole repository is much more common.

> Then we could ask ourselved, should we do something similar for Checkout
> and reset too? I think that is not as important as those operations are
> much less frequent.

Yes, we do want to.  If you are doing a reset you probably need
to whack everything that is dirty and restore the state, likewise
if you are doing a checkout you are likely switching branches and
would expect the entire repository to switch at once.

-- 
Shawn.
