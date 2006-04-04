From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Tue, 4 Apr 2006 10:56:40 -0700
Message-ID: <20060404175640.GE14967@reactrix.com>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net> <20060403180929.GA14967@reactrix.com> <20060404100035.GM27689@pasky.or.cz> <20060404121056.GB14967@reactrix.com> <20060404152737.GN27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 19:56:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQpls-0006Er-Ik
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 19:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDDR4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 13:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWDDR4u
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 13:56:50 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:41286 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750778AbWDDR4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 13:56:49 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k34HueT2002340;
	Tue, 4 Apr 2006 10:56:40 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k34Hueuq002338;
	Tue, 4 Apr 2006 10:56:40 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060404152737.GN27689@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18398>

On Tue, Apr 04, 2006 at 05:27:37PM +0200, Petr Baudis wrote:

> Because people do not know they have to set up their post-update hook.
> When they are already going at lengths to find out how to set up DAV for
> git fetch, they would discover the post-update hook way as well.

There are other reasons that a client can end up with a stale copy of
the server info files - in this case the problem was an intermediate
proxy out of the control of the repo admin.

While we should be able to fix that particular problem, it seems safer
to go straight to the source if possible.

> So, it really seems rather redundant to me.

If I've already enabled DAV for pushing to a repo, I'd find it nice to
be able to use it for fetches as well.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
