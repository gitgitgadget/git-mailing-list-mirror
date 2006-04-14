From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Fri, 14 Apr 2006 00:49:23 -0700
Message-ID: <7vodz4tx4s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 14 09:49:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUJ3l-0003Kh-Lv
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 09:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWDNHt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 03:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDNHt1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 03:49:27 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:46235 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751215AbWDNHt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 03:49:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414074924.YWSP18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 03:49:24 -0400
To: git@vger.kernel.org
X-master-at: dfdcb558ecf93c0e09b8dab89cff4839e8c95e36
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18686>

Getting closer with bunch of fixes, perhaps a real 1.3.0 early
next week.

I'd appreciate people beating what's in the "master" branch to
shake down the last minute brown paper bag problems.  

BTW, I shifted my git day from usual Wednesday to Thursday this
week.  I may do the same the next week.

* The 'master' branch has these since the last announcement.

 - More Solaris 9 portability (Dennis Stosberg)
 - kill index() and replace it with strchr() (Dennis Stosberg)
 - git-apply -C to apply patch with fuzz (Eric W. Biederman)
 - git-log [diff options]
 - Retire git-log.sh
 - Combine-diff fix
 - Retire t5501 test
 - Fix "echo -n foo | git commit -F -"
 - diff --patch-with-raw (Pasky and me)
 - Documentation updates (Pasky and me)
 - Fix running t3600 test as root.
 - "expr match : foobar" fix (Mark Wooding and me)
 - commit message formatting fix for incomplete line (Linus)
 - git-log memory footprint fix (Linus)

* The 'next' branch, in addition, has these.

 - xdiff: post-process hunks to make them consistent (Davide Libenzi)
 - diff --stat (Johannes Schindelin and me)
 - t5500 test fix
