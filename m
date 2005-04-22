From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [3/5] Add http-pull
Date: Fri, 22 Apr 2005 19:12:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504221911340.30848-100000@iabervon.org>
References: <20050422230855.GJ21204@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tony.luck@intel.com, Brad Roberts <braddr@puremagic.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:08:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7Fv-0004ds-1Q
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDVXMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVDVXMx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:12:53 -0400
Received: from iabervon.org ([66.92.72.58]:64775 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261295AbVDVXMw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 19:12:52 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DP7KE-00057z-00; Fri, 22 Apr 2005 19:12:42 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422230855.GJ21204@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sat, Apr 23, 2005 at 01:00:33AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > On Sat, 23 Apr 2005, Petr Baudis wrote:
> > 
> > > Dear diary, on Fri, Apr 22, 2005 at 09:46:35PM CEST, I got a letter
> > > where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > > 
> > > Huh. Why? You just go back to history until you find a commit you
> > > already have. If you did it the way as Tony described, if you have that
> > > commit, you can be sure that you have everything it depends on too.
> > 
> > But if you download 1000 files of the 1010 you need, and then your network
> > goes down, you will need to download those 1000 again when it comes back,
> > because you can't save them unless you have the full history. 
> 
> Why can't I? I think I can do that perfectly fine. The worst thing that
> can happen is that fsck-cache will complain a bit.

Not if you're using the fact that you don't have them to tell you that you
still need the other 10, which is what tony's scheme would do.

	-Daniel
*This .sig left intentionally blank*

