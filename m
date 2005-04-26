From: Bram Cohen <bram@bitconjurer.org>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 13:35:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504261332540.4678-100000@wax.eds.org>
References: <Pine.LNX.4.58.0504261310120.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, <pasky@ucw.cz>,
	<davem@davemloft.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:31:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWhp-0002SD-RE
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVDZUgB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVDZUgB
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:36:01 -0400
Received: from wax.eds.org ([64.147.163.246]:11961 "EHLO wax.eds.org")
	by vger.kernel.org with ESMTP id S261713AbVDZUfz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:35:55 -0400
Received: by wax.eds.org (Postfix, from userid 1044)
	id 33101324028; Tue, 26 Apr 2005 13:35:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by wax.eds.org (Postfix) with ESMTP
	id 30F2FB401A; Tue, 26 Apr 2005 13:35:55 -0700 (PDT)
X-X-Sender: bram@wax.eds.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261310120.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

> On Tue, 26 Apr 2005, Andrew Morton wrote:
> >
> > With bk I was resolving that by just smashing the patches on top of each
> > other, ignoring the rejects and refreshing the topmost patch.  That
> > approach actually resolved this linus-vs-davem dupe as well.
>
> Oh, wow. I didn't realize that your scripts were quite _that_ stupid, and
> didn't actually take advantage of any automatic merges at all.
>
> If so, git should trivially do everything that BK ever did for you. Which
> is not saying a lot ;)

No version control system will do a particularly good job of merging
content which got passed around outside of the system. They can be made to
sort-of handle some simple cases well, but fundamentally too much
information is getting dropped.

The solution is to get everyone using the same version control system,
which is actually quite a workable solution if (a) the version control
system in question is quite nice, and (b) there isn't some deep political
reason why many people will never agree to use it.

-Bram

