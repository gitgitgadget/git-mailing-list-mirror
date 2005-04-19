From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [0/5] Parsers for git objects, porting some programs
Date: Mon, 18 Apr 2005 21:23:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182118170.30848-100000@iabervon.org>
References: <7v7jizsh1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 03:20:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhP6-0007xR-Oy
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDSBXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVDSBXz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:23:55 -0400
Received: from iabervon.org ([66.92.72.58]:63237 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261253AbVDSBXx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:23:53 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNhT3-0003J4-00; Mon, 18 Apr 2005 21:23:57 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jizsh1f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Apr 2005, Junio C Hamano wrote:

> I was looking at the tree part and am thinking that it would
> make it much nicer if your tree object records path for each
> entry. 

You're entirely right, and I've actually now written the code that does
it. I'm planning to send out a patch for that shortly.

> Currently it just borrows from object.refs to represent
> its children

Note that object.refs needs to get filled out for those
applications, even if the information is also included in the
parse; object.refs is for finding what you can reach without worrying
about how you do it.

	-Daniel
*This .sig left intentionally blank*

