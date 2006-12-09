X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.4.2
Date: Sat, 09 Dec 2006 13:13:34 -0800
Message-ID: <7vu004ai2p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 9 Dec 2006 21:13:47 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33834>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt9Vs-0002tH-G3 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 22:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756344AbWLIVNh convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006 16:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbWLIVNh
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 16:13:37 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51122 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1756344AbWLIVNg convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 16:13:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209211335.XYCP7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 16:13:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wlDm1V00G1kojtg0000000; Sat, 09 Dec 2006
 16:13:46 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The latest maintenance release GIT 1.4.4.2 has been available at
the usual places for a few days, but vger seems to have eaten
the message I sent out, so here is a resend:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4.2-1.$arch.rpm	(RPM)

This contains a handful fixes since 1.4.4.1; nothing earth
shattering.

----------------------------------------------------------------

Changes since v1.4.4.1 are as follows:

Alex Riesen (1):
      git-blame: fix rev parameter handling.

Andy Parkins (2):
      Increase length of function name buffer
      Document git-repo-config --bool/--int options.

Eric Wong (4):
      git-svn: error out from dcommit on a parent-less commit
      git-svn: correctly handle revision 0 in SVN repositories
      git-svn: preserve uncommitted changes after dcommit
      git-svn: avoid fetching files twice in the same revision

Johannes Schindelin (1):
      git-mv: search more precisely for source directory in index

Junio C Hamano (5):
      git blame -C: fix output format tweaks when crossing file boundar=
y.
      tutorial: talk about user.name early and don't start with commit =
-a
      receive-pack: do not insist on fast-forward outside refs/heads/
      unpack-trees: make sure "df_conflict_entry.name" is NUL terminate=
d.
      git-reset to remove "$GIT_DIR/MERGE_MSG"

Ren=E9 Scharfe (1):
      archive-zip: don't use sizeof(struct ...)
