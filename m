From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Sun, 15 Apr 2007 23:09:39 +0300
Message-ID: <20070415200939.GC15208@mellanox.co.il>
References: <20070404070135.GF31984@mellanox.co.il>
	<7vd52k7dxi.fsf@assigned-by-dhcp.cox.net>
	<20070415103355.GA12126@mellanox.co.il>
	<7v4pnh4dip.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:09:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdB2c-0007oB-Fp
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbXDOUJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbXDOUJj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:09:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:41645 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbXDOUJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:09:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so952257uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 13:09:37 -0700 (PDT)
Received: by 10.67.119.9 with SMTP id w9mr3767353ugm.1176667777105;
        Sun, 15 Apr 2007 13:09:37 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id p32sm5755495ugc.2007.04.15.13.09.35;
        Sun, 15 Apr 2007 13:09:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4pnh4dip.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44512>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] display shortlog after git-commit
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >> I think a much better thing you could do is to have a mode that
> >> the commit log message editor is started with something like
> >> this...
> >
> > This would work well for author information, but less well for shortlog.
> >
> >> 	----------------------------------------------------------------
> >> 	From: A U Thor <au.thor@example.com>
> >>      Subject: << one line summary of the commit comes here >>
> >>         
> >> 	<< more detailed explanations come here >>
> >> 	# Please enter the commit message for your changes.
> >>      # (comment lines starting with '#' will not be included)
> 
> Care to share your reasoning behind "less well for shortlog" part?
> 
> I think a template like the above makes absolutely clear that
> your log would look like a single summary line, and a separate
> body of text that explains your change fully, and I do not
> understand your concern.

I confess that I forget to add shortlog line myself sometimes,
and I feel that adding stuff inside comments won't help me
remember since I'm used to ignoring it.

Current git commit output looks like this:
	Created commit 2b7ca2abf7526f13ce334475e0c66f79fbb5c206
	1 files changed, 1 insertions(+), 0 deletions(-)

And I wander why does it tell me the new commit hash -
wouldn't displaying the subject make more sense?
Something like

	Created commit "Make foobar faster by caching more barbar in foo"
	1 files changed, 1 insertions(+), 0 deletions(-)

-- 
MST
