From: Patrick Palka <patrick@parcs.ath.cx>
Subject: [PATCH] Documentation: improve the example of overriding LESS via core.pager
Date: Sun, 28 Oct 2012 16:12:46 -0400
Message-ID: <1351455166-2579-1-git-send-email-patrick@parcs.ath.cx>
Cc: Patrick Palka <patrick@parcs.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 21:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSZEO-00067I-RB
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 21:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab2J1UM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 16:12:58 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34509 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab2J1UM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 16:12:56 -0400
Received: by mail-qa0-f53.google.com with SMTP id c1so1127703qae.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 13:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=Sdx66Sm1QzDHvxhOV2ibi33p2kqS0Whjdw7d0JnYyB8=;
        b=TsLh3rDX9hRzCDn4Rnw/QDnvWbvsNR6igjBo0nwE6vB/sXhWDtI71GdAAGaOFpTWlV
         RWQjQVuZdczM0WKp3kzokvxnErNA7BJupbSgcQZfNMHirplz9h3ja0Ue9eUe6WDqAnAP
         IkWRXQcb6vv41PUBjaXAOmaiQqV6yCbNzS2uZAtrbd7zT7M666aY23ykb2F/D+6tfKXC
         qKJvBzns2G6GGpFzdRGShr9ACdeBqQZXTBewjHNZWMU3gmdIiM7X53aGl70N/h/yLCbU
         MQFgdiup6ujVWnd7kTQQnWzTPLQMLq33Snf9xsAfe1J6K8qNihgwo/EetCR4juxQxHBl
         P6MA==
Received: by 10.224.208.68 with SMTP id gb4mr14862013qab.99.1351455175867;
        Sun, 28 Oct 2012 13:12:55 -0700 (PDT)
Received: from localhost.localdomain (ool-4354cf0f.dyn.optonline.net. [67.84.207.15])
        by mx.google.com with ESMTPS id h8sm2740016qap.17.2012.10.28.13.12.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Oct 2012 13:12:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
X-Gm-Message-State: ALoCoQl3rgr+HdGs/d1as3uLewg2RR1xTLu1GnK1b2opX849MLmehIyqGiuvybq5Qm2zRI7pA56U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208563>

You can override an option set in the LESS variable by simply prefixing
the command line option with `-+`. This is more robust than the previous
example if the default LESS options are to ever change.

Signed-off-by: Patrick Palka <patrick@parcs.ath.cx>
---
 Documentation/config.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 11f320b..9a0544c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -538,14 +538,14 @@ core.pager::
 	`LESS` variable to some other value.  Alternately,
 	these settings can be overridden on a project or
 	global basis by setting the `core.pager` option.
-	Setting `core.pager` has no affect on the `LESS`
+	Setting `core.pager` has no effect on the `LESS`
 	environment variable behaviour above, so if you want
 	to override git's default settings this way, you need
 	to be explicit.  For example, to disable the S option
 	in a backward compatible manner, set `core.pager`
-	to `less -+$LESS -FRX`.  This will be passed to the
-	shell by git, which will translate the final command to
-	`LESS=FRSX less -+FRSX -FRX`.
+	to `less -+S`.  This will be passed to the shell by
+	git, which will translate the final command to
+	`LESS=FRSX less -+S`.
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
-- 
1.7.10.4
