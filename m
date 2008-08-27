From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT] Deleted the pu branch
Date: Wed, 27 Aug 2008 15:36:34 -0700
Message-ID: <20080827223634.GQ26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:38:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTeJ-0001dg-PH
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbYH0Wgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 18:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbYH0Wgf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:36:35 -0400
Received: from george.spearce.org ([209.20.77.23]:53137 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbYH0Wge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:36:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5841A38375; Wed, 27 Aug 2008 22:36:34 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93973>

The pu branch keeps causing corruption in people's forks of egit
on repo.or.cz.  Until pasky fixes the server's repacking logic
we cannot allow people to create forks of a project which has
a branch that rebases.

If we want to host a pu branch on repo.or.cz I suggest we make a fork
that doesn't permit subforks, and put the branch there.  People who
want that branch can just add an extra remote to their configs.

-- 
Shawn.
