From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/5] More "use rev-parse -q" patches
Date: Wed,  3 Dec 2008 14:26:47 +0100
Message-ID: <cover.1228310570.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rm1-0000KC-5J
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYLCN0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbYLCN0z
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:26:55 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46166 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYLCN0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:26:54 -0500
Received: from vmobile.example.net (dsl5401C5DE.pool.t-online.hu [84.1.197.222])
	by yugo.frugalware.org (Postfix) with ESMTPA id 92477446CDA;
	Wed,  3 Dec 2008 14:26:52 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2FE9319DC71; Wed,  3 Dec 2008 14:26:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102255>

Hi,

I'm sending these as separate patches as they touch completely unrelated
parts of Git, but feel free to squash them together you think that's
better.

All of them is about using rev-parse -q instead of rev-parse 2>/dev/null.

Miklos Vajna (5):
  filter-branch: use git rev-parse -q
  lost-found: use git rev-parse -q
  pull: use git rev-parse -q
  rebase: use git rev-parse -q
  submodule: use git rev-parse -q

 git-filter-branch.sh |    2 +-
 git-lost-found.sh    |    2 +-
 git-pull.sh          |    8 ++++----
 git-rebase.sh        |    4 ++--
 git-submodule.sh     |    6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)
