From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v4 0/3] git-svn: svn.pathnameencoding for dcommit
Date: Mon, 22 Feb 2016 02:55:08 +0000
Message-ID: <1456109711-26866-1-git-send-email-normalperson@yhbt.net>
Cc: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 03:55:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgeu-0006co-Nj
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 03:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbcBVCz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 21:55:27 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39285 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbcBVCz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 21:55:26 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E91320455;
	Mon, 22 Feb 2016 02:55:26 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286869>

The following changes since commit 0233b800c838ddda41db318ee396320b3c21a560:

  Merge branch 'maint' (2016-02-17 10:14:39 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git ks/svn-pathnameencoding-4

for you to fetch changes up to 1b42f45255de5844b7fe8d0c60fea74cd5b9f954:

  git-svn: apply "svn.pathnameencoding" before URL encoding (2016-02-22 02:29:36 +0000)

----------------------------------------------------------------
Eric Wong (1):
      git-svn: hoist out utf8 prep from t9129 to lib-git-svn

Kazutoshi Satoda (2):
      git-svn: enable "svn.pathnameencoding" on dcommit
      git-svn: apply "svn.pathnameencoding" before URL encoding

 perl/Git/SVN/Editor.pm                   |  4 +++-
 t/lib-git-svn.sh                         | 12 ++++++++++
 t/t9115-git-svn-dcommit-funky-renames.sh | 40 ++++++++++++++++++++++++++++++--
 t/t9129-git-svn-i18n-commitencoding.sh   | 12 +---------
 4 files changed, 54 insertions(+), 14 deletions(-)
