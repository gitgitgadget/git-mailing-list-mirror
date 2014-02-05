From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 0/4] Teach diff_tree_sha1() to accept NULL sha1 for empty trees
Date: Wed,  5 Feb 2014 20:57:08 +0400
Message-ID: <cover.1391619218.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 17:55:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB5lC-0000JO-P9
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 17:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbaBEQze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 11:55:34 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60066 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbaBEQzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 11:55:33 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WB5l6-0004CO-58; Wed, 05 Feb 2014 20:55:32 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WB5ms-0004zE-SY; Wed, 05 Feb 2014 20:57:22 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241606>

Some preparatory patches for my reworked nparent tree-walker. Please apply.

Thanks beforehand,
Kirill

Kirill Smelkov (4):
  tree-diff: allow diff_tree_sha1 to accept NULL sha1
  tree-diff: convert diff_root_tree_sha1() to just call diff_tree_sha1
    with old=NULL
  line-log: convert to using diff_tree_sha1()
  revision: convert to using diff_tree_sha1()

 line-log.c  | 26 ++------------------------
 revision.c  | 12 +-----------
 tree-diff.c | 27 +++++----------------------
 3 files changed, 8 insertions(+), 57 deletions(-)

-- 
1.9.rc1.181.g641f458
