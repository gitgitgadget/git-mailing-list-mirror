From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.1.1
Date: Mon, 24 Jul 2006 20:53:29 -0700
Message-ID: <7vejwae3wm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 05:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5DzC-000847-W9
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 05:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWGYDxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 23:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWGYDxb
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 23:53:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:40398 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932159AbWGYDxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 23:53:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060725035330.IQAD2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 23:53:30 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24157>

The latest maintenance release GIT 1.4.1.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.1.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.1.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.1.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.1.1-1.$arch.rpm	(RPM)

The primary purpose of this release is to fix the breakage
people reported while cloning large quantity of data via git
protocol, and the server side incorrectly timing out.  I am very
sorry for the breakage.

A big thanks goes to Matthias Lederhofer who fixed the breakage
for us.  The fix was cherry-picked from the "master" branch.

The "master" branch has the same fix already and we will have an
1.4.2-rc2 sometime this week, hopefully soon.

----------------------------------------------------------------

Changes since v1.4.1 are as follows:

Junio C Hamano:
      Makefile: tighten git-http-{fetch,push} dependencies

Linus Torvalds:
      revision.c: fix "dense" under --remove-empty

Matthias Lederhofer:
      upload-pack: fix timeout in create_pack_file

Robin Rosenberg:
      Empty author may be presented by svn as an empty string or a null value.
