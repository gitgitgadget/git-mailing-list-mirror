From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 16:03:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
References: <20050417195935.GI1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Jackson <pj@sgi.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 22:51:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGjN-00021E-O3
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVDQUyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVDQUEc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:04:32 -0400
Received: from iabervon.org ([66.92.72.58]:56070 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261468AbVDQUDd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 16:03:33 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNFze-0007t1-00; Sun, 17 Apr 2005 16:03:46 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417195935.GI1461@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 17, 2005 at 09:25:17PM CEST, I got a letter
> where Paul Jackson <pj@sgi.com> told me that...
> > Petr wrote:
> > > BTW, I'd just use access(F_OK) instead of stat() it I don't care about
> > 
> > I recommend _only_ using it when you require exactly the above real vs.
> > effective id behaviour.
> 
> Does this distinction have any effect when doing F_OK?

Actually, the documentation I've got says:

"F_OK requests checking whether merely testing for the existence of the
 file would be allowed (this depends on the permissions of the directories
 in the path to the file, as given in path-name.)"

So it shouldn't complain about a filename which you're allowed to try to
stat, even if there's nothing there. And it would depend on the privs of
the wrong user in looking at the path.

	-Daniel
*This .sig left intentionally blank*

