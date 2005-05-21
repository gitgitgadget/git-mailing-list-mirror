From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Fri, 20 May 2005 21:10:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505202109460.30848-100000@iabervon.org>
References: <4600.10.10.10.24.1116637737.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 03:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZIVZ-000407-20
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVEUBLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEUBLW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:11:22 -0400
Received: from iabervon.org ([66.92.72.58]:41220 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261527AbVEUBLS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 21:11:18 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DZIVi-0008Cc-00; Fri, 20 May 2005 21:10:38 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <4600.10.10.10.24.1116637737.squirrel@linux1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 20 May 2005, Sean wrote:

> You can't do "wc -l filename" because some versionso of "wc" then include
> the filename in their output and confuse things.   That was the reason to
> use "cat" in the first place.

You're reading my patch backwards.

	-Daniel
*This .sig left intentionally blank*

