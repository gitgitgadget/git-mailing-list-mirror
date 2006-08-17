From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 16 Aug 2006 23:45:12 -0700
Message-ID: <7vu04buah3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 17 08:45:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDbdA-0002VG-VE
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 08:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWHQGpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Aug 2006 02:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWHQGpP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 02:45:15 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:64953 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750824AbWHQGpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 02:45:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817064513.DEE6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 02:45:13 -0400
To: git@vger.kernel.org
X-maint-at: d78b0f3d6aa04510dd0c22c3853d3954c5f5b531
X-master-at: 409d1d2053657f73a3222651111740606122aa80
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25552>


* The 'maint' branch has these fixes since the last announcement.
  I am planning to cut a 1.4.2.1 with them soon.

   Dennis Stosberg:
      Solaris does not support C99 format strings before version 10

   Johannes Schindelin:
      git-mv: succeed even if source is a prefix of destination
      git-mv: add more path normalization

   Junio C Hamano:
      finish_connect(): thinkofix


* The 'master' branch has these since the last announcement.

  - Many many clean-ups by David Rientjes.

  - Portability fixes by Dennis Stosberg for Solaris.

  - Franck Bui-Huu's "format-patch --signoff" updates.

  - Gitweb clean-up continues, headed by Jakub Narebski with
    help from Martin Waitz and Yasushi Shoji.

  - There was a code to sleep before writing out the index, in
    order to avoid paying runtime costs in the racy-git
    avoidance code later.  After some experimenting and a bit of
    thinking, removed this sleep.  While at it, documented what
    the racy-git problem is and how the avoidance works.

  - Ville Skytt=E4 updated Emacs VC support.

* The 'next' branch, in addition, has these.

  - Git.pm/Git.xs series as before (no change)

  - git-merge-recur as before (no change)

  - upload-pack tweaks for the case where downloader has more
    root than the server (no change -- need testing)

  - git-apply --reverse --binary (new)

    Earlier "git apply --reverse" rejected binary patch because
    our binary patch format was irreversible.  So I made it
    reversible, and wrote some tests.  This affects both diff
    and apply.

* The 'pu' branch, in addition, has these.

  - git-status WIP

    I am hoping I can drop this; the implementation Peff
    outlined sounded far simpler and cleaner.

  - git-apply --reject (WIP)

    I started working on an option to let 'git apply' apply a
    patch whose some hunks do and some hunks do not apply, while
    leaving rejects in a separate file (or files).  Haven't
    started testing this yet, though.
