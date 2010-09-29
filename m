From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/2] Fix typo in pack-objects' usage
Date: Wed, 29 Sep 2010 23:22:33 +0100
Message-ID: <1285798953-15320-3-git-send-email-patthoyts@users.sourceforge.net>
References: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 00:23:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P153x-0006UH-NP
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 00:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab0I2WXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 18:23:40 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:39618 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752379Ab0I2WXk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 18:23:40 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P153q-0005A7-SV; Wed, 29 Sep 2010 23:23:38 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P153f-0003Ig-Ev; Wed, 29 Sep 2010 23:23:27 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 7ABDA26646; Wed, 29 Sep 2010 23:23:25 +0100 (BST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157615>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..3756cf3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -30,7 +30,7 @@ static const char pack_usage[] =
   "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]\n"
   "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]\n"
   "        [--reflog] [--stdout | base-name] [--include-tag]\n"
-  "        [--keep-unreachable | --unpack-unreachable \n"
+  "        [--keep-unreachable | --unpack-unreachable]\n"
   "        [<ref-list | <object-list]";
 
 struct object_entry {
-- 
1.7.3
