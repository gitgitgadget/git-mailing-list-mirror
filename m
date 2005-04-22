From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [3/5] Add http-pull
Date: Fri, 22 Apr 2005 19:00:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504221844420.30848-100000@iabervon.org>
References: <20050422224008.GD21204@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tony.luck@intel.com, Brad Roberts <braddr@puremagic.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:56:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP74L-0003aW-Jm
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVDVXAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVDVXAo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:00:44 -0400
Received: from iabervon.org ([66.92.72.58]:37639 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261266AbVDVXAi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 19:00:38 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DP78T-0004Zg-00; Fri, 22 Apr 2005 19:00:33 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422224008.GD21204@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Petr Baudis wrote:

> Dear diary, on Fri, Apr 22, 2005 at 09:46:35PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> 
> Huh. Why? You just go back to history until you find a commit you
> already have. If you did it the way as Tony described, if you have that
> commit, you can be sure that you have everything it depends on too.

But if you download 1000 files of the 1010 you need, and then your network
goes down, you will need to download those 1000 again when it comes back,
because you can't save them unless you have the full history. 

There's also no way to say, give me just the head and the tree associated
with it, let me check it out, next download the commit history so I can do
my merge most correctly, let me do that, finally download the intermediate
blobs and trees so that I can track down where something broke.

Ideally, you'd be able to put the latest head and tree into your database,
and it would know that you just hadn't gotten the ancestor yet, and would
be able to determine from your personal metadata (rather than based on
what you had or lacked) that you believe you have all ancestors of the
previous time you pulled, you don't want the trees that Linus merged in
midway through, but everything else you just don't have yet.

	-Daniel
*This .sig left intentionally blank*

