From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/2] Improve end-of-file detection in DirCache
Date: Mon, 13 Apr 2009 08:42:00 -0700
Message-ID: <20090413154200.GV23604@spearce.org>
References: <1239205852-28138-1-git-send-email-robin.rosenberg@dewire.com> <1239290899-24589-1-git-send-email-spearce@spearce.org> <200904131353.00738.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 17:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtOJs-0007x7-77
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 17:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbZDMPmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 11:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZDMPmC
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 11:42:02 -0400
Received: from george.spearce.org ([209.20.77.23]:54532 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZDMPmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 11:42:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 66E9E38211; Mon, 13 Apr 2009 15:42:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904131353.00738.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116444>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> As a consequence, I'll reapply the GitMoveDeleteHook reverts we made just
> prior to 0.4 and start deprecating GitIndex. Any preference for re-apply or
> reverting the reverts?
> 
> The reverts are in  e7307f14c531d52cf231c39d844841c4adaf5e5a and 
> 2066e55e4740d9e9cfaf455596f832ff694f853a
> 
> I think the original patches are valid.

Hmmph.

I would cherry-pick with --no-commit and then make two notes in
the final commit message, e.g.:

  ...

  Temporary-revert: $REVERTCOMMIT
  Originally: $FIRSTCOMMIT
  Signed-off-by: ...

so we can "thread" them with hyperlinks in viewers.

-- 
Shawn.
