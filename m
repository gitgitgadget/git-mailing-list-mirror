From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 2/5] tag.h: Remove unused signature field
Date: Mon, 12 Apr 2010 16:25:26 -0700
Message-ID: <1271114729-18166-2-git-send-email-spearce@spearce.org>
References: <20100411024008.GC23075@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 01:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1T70-0000fn-Qx
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 01:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab0DLXcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 19:32:09 -0400
Received: from mail-qy0-f201.google.com ([209.85.221.201]:33837 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0DLXcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 19:32:08 -0400
Received: by qyk39 with SMTP id 39so5500040qyk.24
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 16:32:05 -0700 (PDT)
Received: by 10.229.222.76 with SMTP id if12mr720476qcb.17.1271114734760;
        Mon, 12 Apr 2010 16:25:34 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id f5sm6718614qcg.20.2010.04.12.16.25.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 16:25:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.246.g978a8
In-Reply-To: <20100411024008.GC23075@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144775>

Its documented as unused.  So lets just drop it from the structure
since we haven't ever used it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 tag.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/tag.h b/tag.h
index 7a0cb00..c437890 100644
--- a/tag.h
+++ b/tag.h
@@ -9,7 +9,6 @@ struct tag {
 	struct object object;
 	struct object *tagged;
 	char *tag;
-	char *signature; /* not actually implemented */
 };
 
 extern struct tag *lookup_tag(const unsigned char *sha1);
-- 
1.7.1.rc1.246.g978a8
