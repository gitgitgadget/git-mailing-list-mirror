From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 10/11] Documentation/replace: list long option names
Date: Tue, 03 Sep 2013 09:10:24 +0200
Message-ID: <20130903071026.29838.46822.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGkrs-0008AL-7F
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552Ab3ICHRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:30 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:45686 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932527Ab3ICHRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:21 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 9364649;
	Tue,  3 Sep 2013 09:17:20 +0200 (CEST)
X-git-sha1: ecd8b57447481d7bcbef03affc7ed4aca5d24171 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233693>

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
