From: linux@horizon.com
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: 18 Apr 2005 21:04:36 -0000
Message-ID: <20050418210436.23935.qmail@science.horizon.com>
Cc: darcs-devel@darcs.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 01:42:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNft2-0008UQ-AF
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDRXq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDRXq0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:46:26 -0400
Received: from science.horizon.com ([192.35.100.1]:59963 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261178AbVDRXqN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 19:46:13 -0400
Received: (qmail 23936 invoked by uid 1000); 18 Apr 2005 21:04:36 -0000
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Hell no.
> 
> The commit _does_ specify the patch uniquely and exactly, so I really 
> don't see the point. You can always get the patch by just doing a
>
> 	git diff $parent_tree $thistree
>
> so putting the patch in the comment is not an option.

Er... no.

One of darcs' big points is that it has at least two fundamentally
different *kinds* of patches.  One is the classic diff(1) style.

The other is "replace very instace of identifier `foo` with identifier`bar`".

Note that merging such a patch with another that adds a new instance
of "foo" has a quite different effect from a similar diff-style patch.
Even though both have identical effects on the tree to which they were
initially merged.

And darcs is specifically intended to support additional kinds of patches.
Again, all in order that the patch can work better when applied to
trees *other* that the one it was originally developed against.


Anyway, the point is that, in the darcs world, it is NOT possible to
reconstruct a patch from the before and after trees.
