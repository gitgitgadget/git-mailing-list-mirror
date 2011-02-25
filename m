From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 0/3] add/commit -u/-a/-A
Date: Fri, 25 Feb 2011 15:45:51 +0100
Message-ID: <cover.1298644872.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 15:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psyyu-0005dJ-GL
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 15:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab1BYOtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 09:49:15 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49960 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753713Ab1BYOtO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 09:49:14 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 60B13209B6;
	Fri, 25 Feb 2011 09:49:14 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 25 Feb 2011 09:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=0aFgt97xLFqYIgUrs28SAO3CHZg=; b=TuX9+dK4H0Ouo/cJZEwLWcFioG1eKDTyoVBF+UyvmuN3aNsX3zWo/WAd2GsyUqSRC6+kx/z59+s2ji2MtFD21ejZIWOk1YnHaABUzEpXWZP6pG/Z21QgREjjU05ufZ17eGRnJeZrOC+s4+KCOlnkJcHIJskabM4eBSTiHTF57rA=
X-Sasl-enc: o0Dm56F09zY8OpmNFdzSxXkxEqFAVqQKS4T53L4iLRRU 1298645353
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DBD5B4491E4;
	Fri, 25 Feb 2011 09:49:13 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.224.gefc87
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167907>

This is the first part of the grand add/commit unification.
It makes the use of -u,-a,-A and the long names uniform across
add and commit, breaking only "commit --all" (by renaming it).

It comes before Jeff's series from p^3u which refactors add/commit and
implements "commit -A".

Michael J Gruber (3):
  git-add: make -A description clearer vs. -u
  git-commit: rename --all to --track
  git-add: rename -u to -a

 Documentation/git-add.txt         |    8 ++++----
 Documentation/git-commit.txt      |    2 +-
 Documentation/git-rm.txt          |    2 +-
 Documentation/gitattributes.txt   |    4 ++--
 builtin/add.c                     |    7 ++++---
 builtin/commit.c                  |   12 ++++++------
 t/t1511-rev-parse-caret.sh        |    2 +-
 t/t2200-add-update.sh             |   26 +++++++++++++-------------
 t/t2201-add-update-typechange.sh  |    6 +++---
 t/t2203-add-intent.sh             |    2 +-
 t/t3030-merge-recursive.sh        |    2 +-
 t/t3415-rebase-autosquash.sh      |   16 ++++++++--------
 t/t4037-diff-r-t-dirs.sh          |    2 +-
 t/t6022-merge-rename.sh           |    2 +-
 t/t6036-recursive-corner-cases.sh |    2 +-
 15 files changed, 48 insertions(+), 47 deletions(-)

-- 
1.7.4.1.224.gefc87
