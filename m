From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 10/10] BROKEN TEST: ObjectLoader stays valid
	across repacks
Date: Wed, 22 Apr 2009 16:02:20 -0700
Message-ID: <20090422230220.GQ23604@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org> <1240276872-17893-10-git-send-email-spearce@spearce.org> <1240276872-17893-11-git-send-email-spearce@spearce.org> <200904220116.51076.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 01:04:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwlUO-0006DK-Q3
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 01:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbZDVXCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 19:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZDVXCV
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 19:02:21 -0400
Received: from george.spearce.org ([209.20.77.23]:53789 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZDVXCU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 19:02:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4A7B138211; Wed, 22 Apr 2009 23:02:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904220116.51076.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117279>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdag 21 april 2009 03:21:12 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > This doesn't doesn't work.
> > 
> > What we are trying to verify is that an ObjectLoader remains valid
> > if the underlying storage for the object has moved, such as when a
> > repository is repacked, the old pack was deleted, and the object is
> > now in the new pack.
> 
> So, I had an idea and started hacking [...]

Yea, I also have an idea.  I'm working up a patch series that should
fix this bug.  I'll post it later this evening once its complete
and passes tests.

-- 
Shawn.
