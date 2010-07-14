From: Brock Peabody <brock.peabody@gmail.com>
Subject: Re: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 18:06:28 +0000 (UTC)
Message-ID: <loom.20100714T195109-665@post.gmane.org>
References: <loom.20100714T180615-173@post.gmane.org> <AANLkTimdVvKYPQn84IQvk7yxMo-gtrjWWqzN-ypXV78X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 20:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ6MS-0002F3-CR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 20:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab0GNSGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 14:06:48 -0400
Received: from lo.gmane.org ([80.91.229.12]:37679 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756492Ab0GNSGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 14:06:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OZ6Lu-0001re-1V
	for git@vger.kernel.org; Wed, 14 Jul 2010 20:06:38 +0200
Received: from proxy-nj2.bloomberg.com ([69.191.241.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 20:06:38 +0200
Received: from brock.peabody by proxy-nj2.bloomberg.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 20:06:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.191.241.48 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151025>

Hi Avery,

Avery Pennarun <apenwarr <at> gmail.com> writes:

> For an open source project, where most contributions are by volunteers
> and need to have their patches reviewed multiple times before
> submission - and frequently, more patchsets are rejected than applied
> - this works reasonably well.  For a company where (in my experience
> at least) most people's patches *are* applied, and the ratio of
> reviewers to coders is much lower, that's much less workable.  And
> unfortunately the elegant looking multiple-signed-off-by or acked-by
> lines don't work so well for that.

I think you've hit the nail on the head here.  In our environment, commits are
frequent and signoffs prompt.  Revisions are very rarely rejected, and will
never pass through more than one reviewer except in extreme cases.  Contributors
will have little tolerance for per-commit time or complexity overhead incurred
from the process.

> Oh, now that I think of it, you might find git-notes useful.  I've
> never used it but I understand it lets you add lines to the log
> messages retroactively.  Of course, that can be both a blessing and a
> curse.  If you can retroactively change signoffs, the signoffs aren't
> that valuable.

Actually, that might be exactly what we need.  I'm sure we could set it up in
such a way so that this signoff is only added mechanically, once, when a
reviewer decides to add a revision to the 'master' repository.

Much thanks,
Brock
