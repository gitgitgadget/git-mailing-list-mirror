From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Tue, 01 Aug 2006 16:54:17 -0700
Message-ID: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 02 01:55:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G844g-0000CY-6f
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 01:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWHAXyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 19:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWHAXyk
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 19:54:40 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54447 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750773AbWHAXyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 19:54:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801235418.CCUO2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 19:54:18 -0400
To: git@vger.kernel.org
X-maint-at: a0764cb838c2f1885fb58ca794c21523fb05c825
X-master-at: bc9e1b8483b16d117d2f868f96e354be2a678d52
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24615>

* The 'master' branch has these since the last announcement.

  I've merged too many stuff since 1.4.2-rc2, so there will be
  1.4.2-rc3 tonight and hopefully things can be stabilized to
  tag 1.4.2 over the weekend.

  - autoconf stuff by Jakub Narebski
  - portability to GNU/kFreeBSD by Gerrit Pape
  - various cleanups and fixes by Johannes
  - built-in git-mv by Johannes
  - git-apply -R by Johannes
  - setup_git_directory cleanups by Linus
  - gitweb clean-ups and blame improvements by Luben Tuikov
  - commit walker updates by Pasky
  - rebase tweaks by Robert Shearman
  - more tests and documentation updates

* The 'next' branch, in addition, has these.

  - Git.pm by Pasky with help from Pavel Roskin and others.

    I'd like to merge this immediately after 1.4.2, unless there
    still are concerns about its portability (in which case
    please help fixing them up before this hits the "master"
    branch).

  - many gitweb cleanups by Jakub Narebski, Martin Waitz and
    Matthias Lederhofer.

    I think these are low-impact and generally good changes.

  - "merge-recur" by Johannes and Alex with help from others.

    I still see a few TODO here and there in the code, but it
    appears that this operates correctly (I've been using this
    for real work for some time).  Do we have benchmarks?

* The 'pu' branch, in addition, has these.

   Johannes Schindelin:
      Add the --color-words option to the diff options family

   Junio C Hamano:
      upload-pack: minor clean-up in multi-ack logic
      upload-pack: stop the other side when they have more roots than we do.
      read-tree --rename and merge-rename
