From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 10/11] Documentation/replace: list long option names
Date: Sat, 31 Aug 2013 21:12:13 +0200
Message-ID: <20130831191215.26699.45790.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqcB-00015H-F2
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab3HaTNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:36 -0400
Received: from [194.158.98.14] ([194.158.98.14]:54211 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753727Ab3HaTNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:16 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 67CF866;
	Sat, 31 Aug 2013 21:12:55 +0200 (CEST)
X-git-sha1: 530f5ce7396abcbd1e9c0ebbf061287efccfe48c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233534>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index a2bd2ee..414000e 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -54,13 +54,16 @@ achieve the same effect as the `--no-replace-objects` option.
 OPTIONS
 -------
 -f::
+--force::
 	If an existing replace ref for the same object exists, it will
 	be overwritten (instead of failing).
 
 -d::
+--delete::
 	Delete existing replace refs for the given objects.
 
 -l <pattern>::
+--list <pattern>::
 	List replace refs for objects that match the given pattern (or
 	all if no pattern is given).
 	Typing "git replace" without arguments, also lists all replace
-- 
1.8.4.rc1.31.g530f5ce.dirty
