From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.3.1
Date: Fri, 20 Oct 2006 22:32:19 -0700
Message-ID: <7v4ptyi68s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 07:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb9T9-00076P-07
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 07:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992826AbWJUFcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 01:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWJUFcX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 01:32:23 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58870 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932222AbWJUFcW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 01:32:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021053221.ZAT22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Oct 2006 01:32:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ctY51V0011kojtg0000000
	Sat, 21 Oct 2006 01:32:05 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29583>

The latest maintenance release GIT 1.4.3.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.1-1.$arch.rpm	(RPM)

This is primarily to work around changes in the recent GNU diff output
format.  Also it contains irritation fix for "git diff" which now
paginates its output by default.

----------------------------------------------------------------

Changes since v1.4.3 are as follows:

Junio C Hamano (1):
      pager: default to LESS=3DFRS

Lars Hjemli (1):
      Fix typo in show-index.c

Linus Torvalds (1):
      git-apply: prepare for upcoming GNU diff -u format change.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      Reject hexstring longer than 40-bytes in get_short_sha1()
      Add revspec documentation for ':path', ':[0-3]:path' and git-desc=
ribe

Nicolas Pitre (1):
      reduce delta head inflated size
