From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Re: Add "clone" support to lntree
Date: Sat, 16 Apr 2005 19:07:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161902380.30848-100000@iabervon.org>
References: <20050416230000.GN19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwKE-0002K9-Ve
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDPXHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVDPXHV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:07:21 -0400
Received: from iabervon.org ([66.92.72.58]:14599 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261186AbVDPXHQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:07:16 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMwNz-000590-00; Sat, 16 Apr 2005 19:07:35 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416230000.GN19099@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sat, Apr 16, 2005 at 05:06:54AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
>
> > I think "fork" is as good as anything for describing the operation. I had
> > thought about "clone" because it seemed to fill the role that "bk
> > clone" had (although I never used BK, so I'm not sure). It doesn't seem
> > useful to me to try cloning multiple remote repositories, since you'd get
> > a copy of anything common from each; you just want to suck everything into
> > the same .git/objects and split off working directories.
> 
> Actually, what about if git pull outside of repository did what git
> clone does now? I'd kinda like clone instead of fork too.

This seems like the best solution to me, too. Although that would make
pull take a URL when making a new repository and not otherwise, which
might be confusing. "init-remote" perhaps, or maybe just have "init" do it
if given a URL?

	-Daniel
*This .sig left intentionally blank*

