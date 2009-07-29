From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import question
Date: Wed, 29 Jul 2009 15:48:55 -0700
Message-ID: <20090729224855.GD1033@spearce.org>
References: <1e30a6d10907291536y3ec68caq8788aef2b7c34a6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Troy Telford <ttelford.groups@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHxG-0003nq-VA
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbZG2Ws4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbZG2Wsz
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:48:55 -0400
Received: from george.spearce.org ([209.20.77.23]:35679 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbZG2Wsz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:48:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 08B8C381FD; Wed, 29 Jul 2009 22:48:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1e30a6d10907291536y3ec68caq8788aef2b7c34a6f@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124403>

Troy Telford <ttelford.groups@gmail.com> wrote:
> But when I run fast-import, I receive an error to the extent of:
> fatal:  Path path/to/some/file not in branch
> 
> So to me, it looks like the file that I'm renaming should exist in the
> branch - it's not being renamed anywhere, not being deleted, and the
> branch isn't reset.  Yet fast-import doesn't seem to think the file
> exists.

Perhaps try inserting a checkpoint just before the rename commit,
so you can actually look at the tree structure in the output branch
when the crash occurs.  My initial guess is, you don't have what
you think you have.

-- 
Shawn.
