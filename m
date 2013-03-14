From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/3] difftool --dir-diff: symlink all files matching the working tree
Date: Thu, 14 Mar 2013 20:19:38 +0000
Message-ID: <cover.1363291949.git.john@keeping.me.uk>
References: <cover.1363206651.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 21:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGEde-0006eh-8r
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 21:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab3CNUUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 16:20:04 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:48638 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3CNUUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 16:20:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 84444161E41A;
	Thu, 14 Mar 2013 20:20:02 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJ+dWIYhXNmM; Thu, 14 Mar 2013 20:20:02 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 27B48161E4DB;
	Thu, 14 Mar 2013 20:19:52 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.396.g36b63d6
In-Reply-To: <cover.1363206651.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218164>

Changes since v1:
- A new second patch to make it safer to compare symlink targets in
  tests
- Test in patch 3 (formerly patch 2) re-written thanks to feedback from
  David Aguilar

This series is based on next, although I think Git's clever enough to
ignore the changes in the context of the t7800 hunk so it should apply
to master as well.

John Keeping (3):
  git-difftool(1): fix formatting of --symlink description
  difftool: avoid double slashes in symlink targets
  difftool --dir-diff: symlink all files matching the working tree

 Documentation/git-difftool.txt |  8 +++++---
 git-difftool.perl              | 25 +++++++++++++++++++++----
 t/t7800-difftool.sh            | 22 ++++++++++++++++++++++
 3 files changed, 48 insertions(+), 7 deletions(-)

-- 
1.8.2.396.g36b63d6
