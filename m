From: Junio C Hamano <junkio@cox.net>
Subject: Quick status updates
Date: Mon, 05 Feb 2007 23:40:06 -0800
Message-ID: <7v3b5jka3t.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
	<7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 08:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEKwE-0000fW-3d
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXBFHkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbXBFHkJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:40:09 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:59909 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750912AbXBFHkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:40:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206074007.FZPT1306.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 02:40:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L7g61W00d1kojtg0000000; Tue, 06 Feb 2007 02:40:07 -0500
In-Reply-To: <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 04 Feb 2007 01:36:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38818>

Junio C Hamano <junkio@cox.net> writes:

> Several things to note (in the following, substitute $gmane with
> http://article.gmane.org/gmane.comp.version-control.git):
>
>  - Working around Tk geometry problem, especially on non Linux+X
>    platforms.  I've forwarded Mark Levedahl's patches
>    ($gmane/38361) to Paul Mackerras for his blessing; hopefully
>    he can Ack and/or suggest improvements.  I'd really like to
>    have them in 1.5.0 in some form.

Mark and I got a response from Paul; unfortunately he is too
busy right now, immediately after post 2.6.20 merge window has
opened.  I've parked Mark's patches and another one suggested by
Linus in response to Johannes Sixt's MinGW work in 'next' for
now.  Depending on Paul's availablity, I might end up applying
them in my tree first.

>  - Nico's "reflog on HEAD".
>  - Reverting the patch to allow tracking branch names as the
>    value of branch.*.merge ($gmane/38621).
>  - Teaching "git blame" to also use the working tree files
>    and/or index.
>  - "git remote add -t -f -m" ($gmane/38470).

These four are in ("git clone" rewrite is not).

>  - We might want to allow git-push to use the wildcard refspec,
>    like git-fetch does, for symmetry.

I've done this which was not too painful -- a patch in a
separate message to follow.

I also applied a handful patches from early this year that was
left unapplied.  After reviewing the message I am responding to,
and an earlier "a few remaining issues..." ($gmane/35993), I
think I am pretty much done with 1.5.0 preparation.

After pulling gfi from Shawn and applying the outstanding gitk
patches (either via Paul or myself), I'll tag -rc4 and give it a
week or so before the final.

I should remember to remove git-merge-recur before -rc4 ;-).
