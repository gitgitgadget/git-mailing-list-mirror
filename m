From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git and cogito uses different exclude files
Date: Fri, 16 Sep 2005 12:44:30 +0200
Message-ID: <20050916104430.GA25169@pasky.or.cz>
References: <432A7902.20603@drzeus.cx> <tnxbr2t9zsk.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 12:44:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGDhy-0005g9-IG
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 12:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbVIPKof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 06:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbVIPKof
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 06:44:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63951 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965293AbVIPKoe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 06:44:34 -0400
Received: (qmail 25694 invoked by uid 2001); 16 Sep 2005 12:44:30 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxbr2t9zsk.fsf@arm.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8674>

Dear diary, on Fri, Sep 16, 2005 at 10:34:19AM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> > 'git status' and 'cg-status'/'stg status' uses different locations for
> > the exclude files. git expects .git/info/exclude and cogito and stgit
> > expects .git/exclude. This is easily solved by a symlink but it could be
> > nice if common files have a single correct location. :)
> 
> The latest StGIT snapshot uses .git/info/exclude. Probably next week I
> will make a new StGIT release.

So does Cogito now. ;-) It still looks at .git/exclude as well and gives
warning if it exists.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
