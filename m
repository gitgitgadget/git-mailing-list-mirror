From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] config: Add description of --local option
Date: Mon, 17 Jun 2013 22:31:31 +0900
Message-ID: <1371475891-2556-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 15:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoZXO-0003L0-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 15:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab3FQNb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 09:31:58 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:56813 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab3FQNb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 09:31:57 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so2785352pbc.32
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=n+DyFHHCAMZ1p04Ezwh42iWQhKkecBnsjfLtMTYKWPQ=;
        b=z9yWpXhDSBRT2xsQfrJDtMdRmJUe4kY6k9oil4ozWGYJXvaj3VyeLYw4WJW0D6OjA8
         7oLqFtDd4lmPK4lL8BeMPDJ0H3lpUo+tyaY6tCJB4WEwT3LUMHfRXq4V1Q6B8V1KLZD8
         AJeo9x1eC5h3BZ8TCJTomOYRbCP3MurvcED9MeBCX0hUscSObgdFd9OfVzT3ib8/XqMj
         qKrbafjP1R1cVlEi2lykBFzY8+Qvx9rH46zEifKHpvHSQpIzklzzgi3YZe5n2063B1xG
         r9JyNz416UYXVgyIobhgrwsaZEFAg9icx11u+453hx3YNgkiXndsJVbrYGlM32D1CEDP
         IdLQ==
X-Received: by 10.68.165.129 with SMTP id yy1mr11727241pbb.179.1371475917450;
        Mon, 17 Jun 2013 06:31:57 -0700 (PDT)
Received: from localhost.localdomain ([180.230.0.90])
        by mx.google.com with ESMTPSA id xl3sm12880056pbb.17.2013.06.17.06.31.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 06:31:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228066>

It was missed in the option list while mentioned from the general
description.  Add it for completeness.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/git-config.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d88a6fc..19a7be0 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -114,6 +114,15 @@ rather than from all available files.
 +
 See also <<FILES>>.
 
+--local::
+	For writing options: write to the repository .git/config file.
+	This is	the default behavior.
++
+For reading options: read only from the repository .git/config rather than
+from all available files.
++
+See also <<FILES>>.
+
 -f config-file::
 --file config-file::
 	Use the given config file instead of the one specified by GIT_CONFIG.
-- 
1.7.9.2
