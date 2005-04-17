From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [patch] fork optional branch point normazilation
Date: Sun, 17 Apr 2005 13:21:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171313300.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504171005220.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brad Roberts <braddr@puremagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 19:18:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNDPq-00067K-Rc
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 19:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDQRWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 13:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVDQRWR
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 13:22:17 -0400
Received: from iabervon.org ([66.92.72.58]:4357 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261369AbVDQRWN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 13:22:13 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNDSZ-0001sz-00; Sun, 17 Apr 2005 13:21:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171005220.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Linus Torvalds wrote:

> On Sun, 17 Apr 2005, Brad Roberts wrote:
> >
> > (ok, author looks better, but committer doesn't obey the AUTHOR_ vars yet)
> 
> They should't, but maybe I should add COMMITTER_xxx overrides. I just do 
> _not_ want people to think that they should claim to be somebody else: 
> it's not a security issue (you could compile your own "commit-tree.c" 
> after all), it's more of a "social rule" thing. I prefer seeing bad email 
> addresses that at least match the system setup to seeing good email 
> addresses that people made up just to make them look clean.

It seems to me like there should be a set of variables for the user in
general, and the various git scripts should arrange them appropriately
(e.g., git apply could look for a first Signed-Off-By, and make the
AUTHOR_ variables match that (for the next commit), while making the
COMMITTER match the user, etc). It seems to me like the current situation
is likely to lead to people claiming to be other people when applying
their patches, just due to having set up their correct info for handling
their own patches.

Actually, if the scripts are reorganizing them, they might as well send
them on the command line.

	-Daniel
*This .sig left intentionally blank*

