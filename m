From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/23] Remove redundant call to bootstrap_attr_stack()
Date: Thu,  4 Aug 2011 06:36:21 +0200
Message-ID: <1312432593-9841-12-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgv-0005WA-3h
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab1HDEhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39660 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1HDEhD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:03 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHp029203;
	Thu, 4 Aug 2011 06:36:58 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178690>

prepare_attr_stack() does the same thing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index bc589f0..b8ce158 100644
--- a/attr.c
+++ b/attr.c
@@ -722,7 +722,6 @@ static void collect_all_attrs(const char *path)
 	struct attr_stack *stk;
 	int i, pathlen, rem;
 
-	bootstrap_attr_stack();
 	prepare_attr_stack(path);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
-- 
1.7.6.8.gd2879
