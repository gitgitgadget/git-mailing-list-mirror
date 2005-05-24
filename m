From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 21:16:18 +0200
Message-ID: <20050524191618.GA25606@cip.informatik.uni-erlangen.de>
References: <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <20050524182951.GB9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241146500.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:15:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaerY-00087M-3B
	for gcvg-git@gmane.org; Tue, 24 May 2005 21:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVEXTQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 15:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVEXTQ0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 15:16:26 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:36756 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261499AbVEXTQY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 15:16:24 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OJGJS8026352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 19:16:19 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OJGJ6i026351;
	Tue, 24 May 2005 21:16:19 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505241146500.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Note that one advantage of the unconverted output is that while it's
> unreadable and not very helpful, it _is_ the raw output from CVS. Again,
> that means that everybody will convert the same CVS archive into exactly
> the same git tree, and that means (among other things) that you can then
> immediately merge between the trees.

I see your point. But it depends on the usage scenario. For me for
example I would like to vendortrack a few CVS repositories. And I use it
only to maintain a few patches (branches and the merging facilities of
git come handy in here), not in a distributed environment were I need
that much reproducability. So having the option to use them is fine for
me and when I need reproducability than I simple don't. When I think
about this scenario ... it comes in my mind that it maybe would be
helpful to have a helper applications like git-merge-base which looks at
the treeids and not the commit ids to find the merge base, or is that
just bullshit?

	Thomas
