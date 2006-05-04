From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Thu, 04 May 2006 01:14:54 -0700
Message-ID: <7vbque5hq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 10:15:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbYzU-0007la-GX
	for gcvg-git@gmane.org; Thu, 04 May 2006 10:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWEDIO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 04:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWEDIO4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 04:14:56 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30628 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750757AbWEDIO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 04:14:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504081455.VREA21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 04:14:55 -0400
To: git@vger.kernel.org
X-maint-at: 7abd7117ec57b8c3c2a469db62c7811fdac5c655
X-master-at: 5892fc6504dd23d7cf9415afb13bae8a61d6c70e
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19555>

* Latest maintenance release 1.3.2 is out from the 'maint' branch.

* The 'master' branch has these since the last announcement, not
  counting what is in v1.3.2.

 - blame path-pruning fix (Fredrik Kuivinen)

 - built-in push (Linus, Johannes Schindelin)

 - beginning of "put remotes/ info in config file" (Johannes Schindelin)

 - repo-config updates and fixes (Johannes Schindelin)

 - built-in count-objects and diff

 - core.prefersymlinkrefs can be given to use symlink HEAD;
   this may be needed to bisect kernel history before January
   2006 whose setlocalversion script depended on HEAD being a
   symlink.

 - "git-log --parents" fix (Linus)

 - use rev-list instead of log in git-cvsserver (Martin Langhoff)

 - sha1_to_hex() usage cleanup (Linus)

 - Document update-index --unresolve (Matthias Kestenholz)


* The 'next' branch, in addition, has these.

 - "put remotes/ info in config file" for fetch side (Johannes Schindelin)

 - built-in grep

   It now knows all the common grep options I personally use,
   including -l, -w, -E, -i, -[ABC]<n>, -v; I am planning to
   push this out perhaps mid next week.

 - built-in format-patch WIP

   I really should resume working on this again...

 - cache-tree

   Fixed a rather nasty bug; should be safe again to use it now.

 - get_sha1(): :path and :[0-3]:path to extract from index.

 - diff-delta enhancements (Nicolas Pitre)


* The 'pu' branch, in addition, has these.

 - partial tree reading/writing with --prefix option.

 - Transitively read alternatives (Martin Waitz)
