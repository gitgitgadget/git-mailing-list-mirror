From: Jakob Pfender <jpfender@elegosoft.com>
Subject: [PATCH] object.h: Remove obsolete struct object_refs
Date: Mon, 14 Mar 2011 17:23:52 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D7E4118.6060802@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 17:24:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzAZ0-0008AJ-51
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 17:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab1CNQYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 12:24:04 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:60577 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab1CNQYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 12:24:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id A50A21B4BAF;
	Mon, 14 Mar 2011 17:24:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4c7ZVJ5bhkX; Mon, 14 Mar 2011 17:23:53 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 46B631B4BB7;
	Mon, 14 Mar 2011 17:23:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168997>

The struct object_refs in object.h is never used anywhere, so remove it.

Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
---
  object.h |    5 -----
  1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/object.h b/object.h
index 4d1d615..b6618d9 100644
--- a/object.h
+++ b/object.h
@@ -6,11 +6,6 @@ struct object_list {
  	struct object_list *next;
  };

-struct object_refs {
-	unsigned count;
-	struct object *ref[FLEX_ARRAY]; /* more */
-};
-
  struct object_array {
  	unsigned int nr;
  	unsigned int alloc;
-- 
1.7.0.4
