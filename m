From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 18:43:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161838030.30848-100000@iabervon.org>
References: <20050416221745.GA10280@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:39:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvx4-0000Ex-4k
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVDPWn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVDPWn0
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:43:26 -0400
Received: from iabervon.org ([66.92.72.58]:50182 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261171AbVDPWnX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:43:23 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMw0s-0004aH-00; Sat, 16 Apr 2005 18:43:42 -0400
To: Martin Mares <mj@ucw.cz>
In-Reply-To: <20050416221745.GA10280@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Martin Mares wrote:

> Hello!
> 
> > This adds a program to download a commit, the trees, and the blobs in them
> > from a remote repository using HTTP. It skips anything you already have.
> 
> Is it really necessary to write your own HTTP downloader? If so, is it
> necessary to forget basic stuff like the "Host:" header? ;-)

I wanted to get something hacked quickly; can you suggest a good one to
use?

> If you feel that it should be optimized for speed, then at least use
> persistent connections.

That's the next step.

	-Daniel
*This .sig left intentionally blank*

