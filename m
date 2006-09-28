From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Remove excessively redundant entries from git_difftree_body
Date: Wed, 27 Sep 2006 19:07:27 -0700
Message-ID: <7vmz8k7nhc.fsf@assigned-by-dhcp.cox.net>
References: <20060928002325.70519.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 04:07:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSlJE-0003IG-8w
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 04:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031333AbWI1CH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 22:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031332AbWI1CH3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 22:07:29 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:34462 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1031333AbWI1CH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 22:07:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928020728.KVGV12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 22:07:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Te7V1V01Q1kojtg0000000
	Wed, 27 Sep 2006 22:07:30 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060928002325.70519.qmail@web31815.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Wed, 27 Sep 2006 17:23:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27966>

Luben Tuikov <ltuikov@yahoo.com> writes:

> 1) All entries on the left are blobs and clicking on them
> leads to blobs.  No more diff or blob depending on what
> happened (modified or mode changed) to the file -- this goes
> to the right, in the "link" column.
>
> 2) Remove redundant "blob" from the link column on the right.
> This can now be had by clicking on the entry itself.
>
> This reduces and simplifies the code.
>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

We lost blobdiff from commitdiff page with this patch, which I
think it probably is a good change.  We can say "when we display
a pathname you can click it to get the blob or tree".

By the way, just like your "blob" and "tree" link removal, I
think we can lose "commit" link in shortlog.  The list looks
rather cluttered with three links; we could replace it with
"snapshot" link if we wanted to.

I am neutral about doing that for long log pages.  The commit
titles are links there as well, but they do not look like "one
of the columns that can be clicked in a single line per row
table" as in shortlog page.  The page could also get "snapshot"
links.
