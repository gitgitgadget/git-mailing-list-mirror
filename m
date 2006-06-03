From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sat, 03 Jun 2006 03:29:38 -0700
Message-ID: <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jun 03 12:30:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmTON-0005Kq-Sp
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 12:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWFCK3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 06:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWFCK3k
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 06:29:40 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57223 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750793AbWFCK3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 06:29:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060603102939.QEPH11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Jun 2006 06:29:39 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17537.22675.678700.118093@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sat, 3 Jun 2006 19:38:27 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21192>

Paul Mackerras <paulus@samba.org> writes:

> I just pushed out an update to the "new" branch of the gitk.git
> repository, which adds a feature that I have often wished for: it will
> now show the nearest preceding and following tags when you select a
> commit.  This is very useful if you need to identify which release was
> the first to incorporate a particular patch, or if you need to know
> which release a patch might have been based on.

Another thing that would equally be useful is to show which
branch a particular commit is on, so for example I can pick one
commit while doing "gitk next" to view the next branch and see
which topic it belongs to, and "gitk this-topic" to see which
commits on that topic, if any, are not yet in the "next" branch.

For a graphical interface like gitk it may not be such a big
deal (you can always follow the line), but an interface like tig
that shows commits in a linear fashion it would make a big
difference in usability.

BTW, what's the maintenance/rewind policy on the "new" branch of
gitk.git?  If you are never going to rewind it, I could pull it
in "next" (and keep pulling your "master" in my "master") for
wider exposure if you like.
