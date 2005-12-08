From: Junio C Hamano <junkio@cox.net>
Subject: Re: as promised, docs: git for the confused
Date: Thu, 08 Dec 2005 13:53:16 -0800
Message-ID: <7vk6efb6ib.fsf@assigned-by-dhcp.cox.net>
References: <20051208063409.31967.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 22:55:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkThv-0001GT-5a
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 22:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVLHVxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 16:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLHVxS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 16:53:18 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47048 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751146AbVLHVxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 16:53:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208215130.LIOA20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 16:51:30 -0500
To: linux@horizon.com
In-Reply-To: <20051208063409.31967.qmail@science.horizon.com>
	(linux@horizon.com's message of "8 Dec 2005 01:34:09 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13378>

linux@horizon.com writes:

> * Terminology - heads, branches, refs, and revisions
>
> (This is a supplement to what's already in "man git".)
>
> The most common object needed by git primitives is a tree.  Since a
> commit points to a tree and a tag points to a commit, both of these are
> acceptable "tree-ish" objects and can be used interchangeably.  Likewise,
> a tag is "commit-ish" and can be used where a commit is required.

I am unsure if we want to further confuse readers by saying
this, but technically, "Likewise, a tag which is commit-ish can
be used in place of commit".  Not all tags are necessarily
commit-ish.  v2.6.11 tag is tree-ish but not commit-ish for
example.  Typically, however, a tag is commit-ish.
