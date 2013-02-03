From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/3] Make Git compile warning-free with Clang
Date: Sun,  3 Feb 2013 14:37:08 +0000
Message-ID: <cover.1359901732.git.john@keeping.me.uk>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 15:38:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U20hs-0000JE-Aa
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 15:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3BCOhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 09:37:10 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55313 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab3BCOhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 09:37:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id D7E031FC7B;
	Sun,  3 Feb 2013 14:36:54 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XVheg2KFmxbR; Sun,  3 Feb 2013 14:36:52 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 0C03922B45;
	Sun,  3 Feb 2013 14:36:47 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215311>

The first two patches here were sent to the list before but seem to have
got lost in the noise [1][2].  The final one is new but was prompted by
discussion in the same thread.

After applying all of these patches, I don't see any warnings compiling
Git with Clang 3.2.

[1] http://article.gmane.org/gmane.comp.version-control.git/213817
[2] http://article.gmane.org/gmane.comp.version-control.git/213849

Antoine Pelisse (1):
  fix clang -Wtautological-compare with unsigned enum

John Keeping (2):
  combine-diff: suppress a clang warning
  builtin/apply: tighten (dis)similarity index parsing

 builtin/apply.c | 10 ++++++----
 combine-diff.c  |  2 +-
 grep.c          |  3 ++-
 grep.h          |  3 ++-
 4 files changed, 11 insertions(+), 7 deletions(-)

-- 
1.8.1.2
