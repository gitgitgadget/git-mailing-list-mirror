From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How do I...
Date: Fri, 6 May 2005 13:31:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505061321590.30848-100000@iabervon.org>
References: <427B9FB3.1040002@tuxrocks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 19:25:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU6ZI-0005it-NV
	for gcvg-git@gmane.org; Fri, 06 May 2005 19:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEFRbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 13:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVEFRbd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 13:31:33 -0400
Received: from iabervon.org ([66.92.72.58]:23813 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261222AbVEFRbb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 13:31:31 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DU6fP-0006rW-00; Fri, 6 May 2005 13:31:11 -0400
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <427B9FB3.1040002@tuxrocks.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 6 May 2005, Frank Sorenson wrote:

> Note that I could be just thinking about this all wrong, so my
> terminology could be in left field.  Here, I'm mostly just interested in
> the case where "Hey, something broke with drivers/char/i8k.c.  When was
> this changed?  Who changed what?"

The tricky thing is that you want to *not* see commits where somebody
adopted somebody else's change to drivers/char/i8k.c; you want to ignore
those commits in favor of the commits where the original author of the
changes made the changes. Otherwise, you mostly see merges with people
submitting lines where they didn't change that file.

	-Daniel
*This .sig left intentionally blank*

