From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Multi-headed branches (hydra? :)) for basic patch calculus
Date: Sun, 2 Apr 2006 12:11:21 -0400
Message-ID: <20060402161121.GB18864@fieldses.org>
References: <1143950852.21233.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 18:11:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ5Ak-0002lE-SW
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 18:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWDBQLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 12:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWDBQLY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 12:11:24 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47767 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932363AbWDBQLX
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 12:11:23 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1FQ5Af-0005Ek-Qs; Sun, 02 Apr 2006 12:11:21 -0400
To: Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <1143950852.21233.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18269>

On Sun, Apr 02, 2006 at 04:07:32PM +1200, Sam Vilain wrote:
> To represent this in git you could just roll back the head merge commit,
> push commit 5 on that branch, then make a new head:
> 
>   1 -> 3 -> 5 \
>                >- head
>   2 -> 4 -----/
> 
> However, if there was support for "hydra", or heads that are multiple
> commit IDs (and necessarily, no blobs in corresponding paths in their
> trees that are not identical), then you would not need to destroy and
> recreate this dummy merge head commit to model your patch history in
> this manner.

What's the advantage to doing this?

> If the plumbing or a porcelain could be smart enough to automatically
> create hydra when patches are not dependent, then many of the benefits
> of patch calculus might come for free, without having to create these
> complicated sounding entities manually.

What are the benefits of patch calculus?  (What is it?  The only
explanation I've seen is at
http://abridgegame.org/darcs/manual/node8.html, but I don't find it very
helpful.)

--b.
