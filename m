From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [0/5] Parsers for git objects, porting some programs
Date: Mon, 18 Apr 2005 22:04:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182201190.30848-100000@iabervon.org>
References: <7v7jizsh1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 04:01:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNi3C-0003TC-Mb
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVDSCEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDSCEd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:04:33 -0400
Received: from iabervon.org ([66.92.72.58]:46342 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261269AbVDSCEZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:04:25 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNi6H-0004wn-00; Mon, 18 Apr 2005 22:04:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jizsh1f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Apr 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> On Mon, 18 Apr 2005, Linus Torvalds wrote:
> >> On Sun, 17 Apr 2005, Daniel Barkalow wrote:
> >> >
> >> > This series introduces common parsers for objects, and ports the programs
> >> > that currently use revision.h to them.
> >> > 
> >> >  1: the header files
> >> >  2: the implementations
> >> >  3: port rev-tree
> >> >  4: port fsck-cache
> >> >  5: port merge-base
> >> 
> >> Ok, having now looked at the code, I don't have any objections at all. 
> 
> I was looking at the tree part and am thinking that it would
> make it much nicer if your tree object records path for each
> entry.

As it turns out, the code I just doesn't actually record the path; it does
everything else, and it should be easy to add the path to those entries. I
mainly wanted object type (i.e., do I have to recurse into the object), so
I skipped that one. But it should now be clear what you need to add.

	-Daniel
*This .sig left intentionally blank*

