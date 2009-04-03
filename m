From: Josef Wolf <jw@raven.inka.de>
Subject: Re: How to merge in different order?
Date: Fri, 3 Apr 2009 19:59:24 +0200
Message-ID: <20090403175924.GD28619@raven.wolf.lan>
References: <20090403161208.GC28619@raven.wolf.lan> <20090403163150.GD8155@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 20:03:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpniK-0002lw-Os
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 20:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934720AbZDCSAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 14:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760224AbZDCSAN
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 14:00:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:56517 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934073AbZDCSAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 14:00:12 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LpngX-0003sj-AP; Fri, 03 Apr 2009 20:00:09 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id B41F42CBDB; Fri,  3 Apr 2009 19:59:24 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090403163150.GD8155@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115549>

On Fri, Apr 03, 2009 at 12:31:50PM -0400, Jeff King wrote:

[ ... ]
> But what you probably want to do is rewrite the history of your branch
> to re-order the commits.

Yeah, That's exactly what I need. But I guess there's a lot of work ahead:
about 2500 commits are waiting for the sort.

> You can do this with "git rebase -i".

Sounds good

> Like any
> history rewriting, this can cause difficulties for people who you have
> already shared the branch with (because it will replace the commits that
> they already have with 5 _new_ commits that just happen to do more or
> less the same thing).

This is a copy of a svn repository, created with git-svn. So the branch
is shared with other people.

> If you have already shared the branch, you may just want to cherry-pick
> the changes you want (using "git cherry-pick") onto your other branch.

Argh, I was looking for git-cherry, but that does something different ;-)

Thanks for the answer, Jeff!
