From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] diff-options.txt: document --[no]-textconv
Date: Mon, 23 May 2011 20:27:54 -0400
Message-ID: <1306196874-64687-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 02:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfTj-00060T-SU
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839Ab1EXA2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 20:28:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58938 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786Ab1EXA2B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 20:28:01 -0400
Received: by vws1 with SMTP id 1so4562326vws.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=1b38l+nYLp4uYo0u/P0aMyDlUSv7vZak8LPhE15Prfw=;
        b=DJQTWPzY8wTc606HWIDY4PMv+UZ8ahXOTVgEXYGr2ESt6qI9OR1TcHJ1IST8eoO7u3
         jaQ2m8hsvw0RkR8hgBn0cvmySxOwyxQr11s6noezUWxqBPpQGT7czYN3I4v/frWBZTGD
         7JYzAsHDe5Yx/Iuj3fdaPlLaubg9JR4Io7cgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IlD16DdFwEJYRJiW1xJ0PSJI6j7+/+Ozj/rS2bZ1t2ad2MMCNS3KhOf0Uayjovml8w
         0+uRdwcEDwWYJzMZwZK5/zZ8V26o4f9kD0q+CeQX0sBLedwKaBGP1VCf4xB1bAZQQvQj
         /pTedlyHo/2+hBqYpJj27Q8Etg1EEvqEj6VQw=
Received: by 10.52.71.111 with SMTP id t15mr655730vdu.37.1306196880543;
        Mon, 23 May 2011 17:28:00 -0700 (PDT)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id p1sm1473858vdv.26.2011.05.23.17.27.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2011 17:27:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.323.g00f3d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174303>


Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
textconv also seems to be supported by blame, it isn't clear to me whether
it respects --no-textconv.

 Documentation/diff-options.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c7ed946357..8b311a60ea 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -412,6 +412,15 @@ endif::git-format-patch[]
 --no-ext-diff::
 	Disallow external diff drivers.
 
+--textconv::
+	Text conversion of binary files is enabled by default if configured
+	according to "Performing text diffs of binary files" in
+	linkgit:gitattributes[5], but may be disabled with `--no-textconv`.
+	This option overrides a previously given `--no-textconv`.
+
+--no-textconv::
+	Disable text conversion of binary files.
+
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules in the diff generation. <when> can be
 	either "none", "untracked", "dirty" or "all", which is the default
-- 
1.7.5.2.323.g00f3d
