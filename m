From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 12:45:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505111235030.30848-100000@iabervon.org>
References: <2cfc403205051016205d722f23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 18:39:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVuEC-0006ii-8B
	for gcvg-git@gmane.org; Wed, 11 May 2005 18:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVEKQp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 12:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEKQp7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 12:45:59 -0400
Received: from iabervon.org ([66.92.72.58]:56582 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261211AbVEKQpu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 12:45:50 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVuKn-0005ZF-00; Wed, 11 May 2005 12:45:21 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205051016205d722f23@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 May 2005, Jon Seymour wrote:

> The repository API would contain functionality equivalent to cat-file,
> ls-tree, most of fsck-cache, rev-list, rev-tree, diff-tree, most of
> the transport code - things that don't involve use of the index.
> 
> The workspace API would contain read-tree, write-tree, commit-tree,
> etc - things that do involve use of the the index.

Unfortunately for this idea, you can't actually check files into or out of
the repository using the git tools without the index (in memory at least,
if not on disk). This is a bit like having a libc with all the system
calls except read and write. Sure, there are a number of programs that
would be fine that way, but it makes the API unintuitive, and most serious
programs need the extension anyway.

	-Daniel
*This .sig left intentionally blank*

