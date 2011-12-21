From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] builtin/commit: add missing '/' in help message
Date: Wed, 21 Dec 2011 15:56:00 +0100
Message-ID: <4EF1F380.3090901@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 15:57:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdNbT-0007K2-RY
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 15:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab1LUO5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 09:57:07 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:52259 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab1LUO5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 09:57:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 59336DE971;
	Wed, 21 Dec 2011 15:57:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZgGBifX6CSy; Wed, 21 Dec 2011 15:57:05 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 2DB1ADE969;
	Wed, 21 Dec 2011 15:57:05 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111108 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187566>

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 626036a..be1ab2e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -139,7 +139,7 @@ static struct option builtin_commit_options[] = {
 	OPT_STRING('C', "reuse-message", &use_message, "commit", "reuse message from specified commit"),
 	OPT_STRING(0, "fixup", &fixup_message, "commit", "use autosquash formatted message to fixup specified commit"),
 	OPT_STRING(0, "squash", &squash_message, "commit", "use autosquash formatted message to squash specified commit"),
-	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
+	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C/-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOL('e', "edit", &edit_flag, "force edit of commit"),
-- 
1.7.8.521.g64725
