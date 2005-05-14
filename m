From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-log gives error on old tags
Date: Sat, 14 May 2005 08:41:21 -0700
Message-ID: <20050514154121.GD14184@tumblerings.org>
References: <20050514151157.GB14184@tumblerings.org> <20050514151922.GC14184@tumblerings.org> <20050514153158.GO3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 17:46:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWyqV-0006gA-8M
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVENPq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVENPq1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:46:27 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:5779 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261431AbVENPqP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 11:46:15 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DWylV-0001l5-NL; Sat, 14 May 2005 08:41:21 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050514153158.GO3905@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 14, 2005 at 05:31:58PM +0200, Petr Baudis wrote:
> Dear diary, on Sat, May 14, 2005 at 05:19:22PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > I should add, I'm fully current with the cogito origin, with Junio's --author
> > patch on top.
> 
> Hmm, works here. I forgot to update the tags immediately after the big
> rehashing, so you could get them from that time and rsync wouldn't
> overwrite them. Try deleting them from .git/refs/tags/ and re-pull.

Well, I did a fresh clone of cogito, and the problem went away. Weird.

But now I notice that some files from the broken tree are not in the new tree:

Only in cogito.broke: cat-file
Only in cogito.broke: check-files
Only in cogito.broke: checkout-cache
Only in cogito.broke: commit-tree
Only in cogito.broke: convert-cache
Only in cogito.broke: diff-cache
Only in cogito.broke: diff-tree
Only in cogito.broke: diff-tree-helper
Only in cogito.broke: fsck-cache
Only in cogito.broke: http-pull
Only in cogito.broke: init-db
Only in cogito.broke: ls-tree
Only in cogito.broke: merge-base
Only in cogito.broke: merge-cache
Only in cogito.broke: read-tree
Only in cogito.broke: rev-list
Only in cogito.broke: rev-tree
Only in cogito.broke: rpull
Only in cogito.broke: rpush
Only in cogito.broke: show-diff
Only in cogito.broke: show-files
Only in cogito.broke: unpack-file
Only in cogito.broke: update-cache
Only in cogito.broke: write-tree

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
