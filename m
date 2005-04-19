From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [2/4] Sorting commits by date
Date: Mon, 18 Apr 2005 23:06:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182256490.30848-100000@iabervon.org>
References: <20050419025340.GZ5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David A. Wheeler" <dwheeler@dwheeler.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 05:02:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNj0J-0000Ov-Df
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 05:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDSDGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 23:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVDSDGX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 23:06:23 -0400
Received: from iabervon.org ([66.92.72.58]:27143 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261303AbVDSDGV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 23:06:21 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNj4L-00078Y-00; Mon, 18 Apr 2005 23:06:33 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419025340.GZ5554@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, Petr Baudis wrote:

> Dear diary, on Tue, Apr 19, 2005 at 04:52:26AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > because I can't find a way to make recent GCC reject C99 features but not
> > old GNU extensions.
> 
> Do we use any?

Quite a few: "?:", arithmetic on void pointers, C++/99-style comments in
places (if we aren't being C99), zero-size arrays. They're the usual
things that building Linux requires, so I think they are common extensions
beyond gcc.

	-Daniel
*This .sig left intentionally blank*

