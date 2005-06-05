From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-init bug -- identified and fixed - thanks!
Date: Sun, 5 Jun 2005 16:52:02 -0700
Message-ID: <20050605235202.GD6890@tumblerings.org>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org> <20050605181042.GH17462@pasky.ji.cz> <20050605182912.GC6890@tumblerings.org> <20050605201904.GL17462@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 01:49:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df4rC-0001uF-58
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 01:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFEXwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 19:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFEXwP
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 19:52:15 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:10880 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261153AbVFEXwM
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 19:52:12 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1Df4uQ-0005jG-Vb; Sun, 05 Jun 2005 16:52:03 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050605201904.GL17462@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 05, 2005 at 10:19:04PM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Jun 05, 2005 at 08:29:12PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > I figured it out.
> > 
> > I made a temporary copy of the directory, and kept doing
> > 
> > $ rm -rf .git
> > $ rm somerandomfileordir
> > $ cg-init
> > $ cg-status
> > 
> > It turned out one of my files had a "'" in the name, i.e.:
> > 
> > $ ls
> > Zack's_file
> > $
> > 
> > I removed it, and all of a sudden cg-init worked perfectly.
> > 
> > Is that a Cogito bug? I would expect git to handle any filename the filesystem
> > itself can handle.
> 
> Could you check with the latest Cogito, please?
> (88467971134efddf66793ba44c4ee1ffc7573a0a)

I just tried with fd787bb8d89cdacedc16cfef9dc4feb0cf843def
which is a few patches later than the one you list.

The problem seems to be fixed. Many thanks!

Be well,
Zack

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
