From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Tue, 18 Apr 2006 01:44:09 -0700
Message-ID: <7vslobff3a.fsf@assigned-by-dhcp.cox.net>
References: <7vodz4tx4s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 18 10:44:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVlox-000521-NN
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 10:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWDRIoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 04:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDRIoM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 04:44:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43947 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750829AbWDRIoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 04:44:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418084410.PXDK18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 04:44:10 -0400
To: git@vger.kernel.org
X-master-at: 2855d58079cd56361879cc03f7c769409bb445e5
In-Reply-To: <7vodz4tx4s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 14 Apr 2006 00:49:23 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18848>

* The 'master' branch has these since the last announcement.

 - Update xdiff (Davide Libenzi)
 - Add diff --stat and --patch-with-stat (Johannes Schindelin)
 - Miscellaneous fixes (A Large Angry SCM, Linus, Serge
   E. Hallyn, Yann Dirson, me)
 - Fix rev-list --boundary (me)
 - Update gitk (Paul Mackerras)

* The 'next' branch, in addition, has these.

 - Common option parsing for "git log --diff" and friends (Linus)
 - Log message printout cleanups (Linus)
 - Log/show/whatchanged commands are now built-in (Linus and me)
 - Similarity fingerprint (Geert Bosch)
 - Define "log --stat" to be "stat with first parent" (Linus and me)

The commits on the lt/logopt branch (part of "next" branch) are
proving to be more stable and safe enough to use.  It cleans up
the code quote a lot,

I'm really resisting the temptation to merge these before 1.3.0.
There is a slight output format change from diff-tree --pretty;
while I would not expect no Porcelains is affected in practice,
technically this is a backward incompatible change, so...

Anyway, they will be merged immediately after the big release.
