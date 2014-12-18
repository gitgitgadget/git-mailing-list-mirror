From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/SubmittingPatches: unify whitespace/tabs for the DCO
Date: Wed, 17 Dec 2014 17:08:14 -0800
Message-ID: <1418864895-18583-2-git-send-email-sbeller@google.com>
References: <xmqq1tnx961q.fsf@gitster.dls.corp.google.com>
 <1418864895-18583-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 02:08:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Pa2-0003o4-9g
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 02:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbaLRBIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 20:08:31 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:53458 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaLRBI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 20:08:29 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so85502iga.8
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 17:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QxRSeNtaSl4kLNLAgYThY00MQ/cGi5oOfm4CREpG384=;
        b=QmuEKowByZaOedj3Bm601JdH87sK00rp5jyRFyvE7woMMz9XrFwvN/DDGyEI6e9x/R
         2LUjVf2KW4W8JVAQQ9Ehz0RVAZSsfB9ubjKvvrzEYvTpK1yg2q6ROXAP4IgdH/1O1mu7
         d6jq//pGQTUvYcOnrNV5xXH6r20UfiD16DpFx5rTL32akqGd9yCz8kfl9LUotW+hEM8P
         xsy9byLGXF9iM1yqh+WCrF7AjMaLnxwIkNyDNea0hc0qBzutw41UYwBmwnjgHRNzf/k+
         xOCV6PaleZLPnqdur6Thga5I8X3T0F+nJNm+Dc8IUNG9IVTlXprHF/DuiOIdzffXKpxG
         EXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QxRSeNtaSl4kLNLAgYThY00MQ/cGi5oOfm4CREpG384=;
        b=HQQkpC7jnUulPq23xIXmQ3FllHUo230VMYhg7rDcvLIQ2dGN1UU/cqaj1y4u/3x90W
         Wfow8TvVRXlJ3NWCRPd0+p/DM2E70GeGE0c4JDWw6oFFaCTmdzudG0o9zSZW61g6fdT8
         X5nWiINvWy457b4oRf1pO/IwZQwXKX2O4/53e0ImMhisTC/D6oTpYgqF22AJvCrWO8Ph
         FDippSPRLyNrjmN0L6adovt/tkgfpYobOx+/y+ULDY5gva9UCz8+k+xTahRyVl2d1MV/
         Q2IfWCe/dqRHy4S+XS4ZIe4Nzf4X96rl2Z0LCLJPpoPjzGnwjNBATChIHf83ZcOzBhq9
         aA3w==
X-Gm-Message-State: ALoCoQnVduspHHGOzbt1EenuZM/8NVdX+g8XFSh8ycMKsP8BMB0yTvPlhrUTi32QYWt4CBErofYA
X-Received: by 10.43.75.69 with SMTP id yz5mr48946icb.90.1418864908990;
        Wed, 17 Dec 2014 17:08:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id n2sm3057756igp.16.2014.12.17.17.08.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 17:08:28 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418864895-18583-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261514>

The Developers Certificate of Origin has a mixture of tabs and white
spaces which is annoying to view if your editor explicitly views white
space characters.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/SubmittingPatches | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 16b5d65..6124f34 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -258,15 +258,15 @@ pretty simple: if you can certify the below:
             person who certified (a), (b) or (c) and I have not modified
             it.
 
-	(d) I understand and agree that this project and the contribution
-	    are public and that a record of the contribution (including all
-	    personal information I submit with it, including my sign-off) is
-	    maintained indefinitely and may be redistributed consistent with
-	    this project or the open source license(s) involved.
+        (d) I understand and agree that this project and the contribution
+            are public and that a record of the contribution (including all
+            personal information I submit with it, including my sign-off) is
+            maintained indefinitely and may be redistributed consistent with
+            this project or the open source license(s) involved.
 
 then you just add a line saying
 
-	Signed-off-by: Random J Developer <random@developer.example.org>
+        Signed-off-by: Random J Developer <random@developer.example.org>
 
 This line can be automatically added by Git if you run the git-commit
 command with the -s option.
-- 
2.2.0.31.gad78000.dirty
