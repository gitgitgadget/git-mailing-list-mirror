From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/5] ls-remote: document --quiet option
Date: Tue, 19 Jan 2016 00:20:46 +0100
Message-ID: <1453159250-21298-2-git-send-email-t.gummerer@gmail.com>
References: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 00:21:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLJ6w-0006iQ-EH
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 00:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbcARXUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 18:20:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33690 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbcARXUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 18:20:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so19464078wmu.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2tzA7/jZowcbhNqJUwQk2IDabrQhIx0y3KgKDmNQESI=;
        b=rxX5iPtcDYJehg7ubJdK4jz0XO9EVsaFJOAj9WyCdegNlYzPdQVlrl+0u/LuD5EYoX
         UIPKkAxW1M1skg8vTiKUo0pa4Rpp6j6uay/sJCDw3oJeSYlqj316i+oY8PXD+/6J5PdR
         yuA7CLa4bDGCyp11v49IccIzhxG5ylkiYpg5Q1Bq+OYWq/oeVxn+5vrmkLlmSP9WlBsa
         DkdeHeYgX+GxIzdHhKtFucMSDh7Cy0edVFCNhs/NVaN8vQI4UhgozChDcO7qH2kRuG8L
         0/umbRVVByIkQMatOSNRVb949BYKUj/3zrYXtyFdDGDQbbcboVuTE6ht3JCTEuXfJpbw
         +2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2tzA7/jZowcbhNqJUwQk2IDabrQhIx0y3KgKDmNQESI=;
        b=GMR+7bVD3EKERqktVOGjmMQM9l9wzkBek/FpiRDBnQgGeWqiJGIH7B1kXIKxV65CwX
         ftUldi1VMS1y8p7Wmd4ZrHZFuBhKakUGuzJ1FwoozRN3MRJM5IWaPt8HMk+Zy7cyPU9X
         /qWtnLLketDZHr34rLl/GgjMUplwHwER7FzjlJjtaygPt7D5wPmNvnF8t9WnETdfmeNp
         EC3cnpUoon3FopOPkNQby7U47soZK6mBOzyrDSdUtCdmTprmpvNHQBbS00AYwrZrYUnv
         dqiZZ89A75S31hJIRyaMI+7+lVFmERftC6L49fIiDIA07UIbNzXDX7yrfFgzgg0M5r8w
         pwFQ==
X-Gm-Message-State: AG10YOT3AROBdR/NG/H/Bcg8MiSDaedtCPIEKPoC+ei1W+0GOYW8tQeK9nndEZSxPbib5g==
X-Received: by 10.28.30.138 with SMTP id e132mr14773855wme.86.1453159242166;
        Mon, 18 Jan 2016 15:20:42 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id ka4sm25839052wjc.47.2016.01.18.15.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 15:20:41 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.g56a8654.dirty
In-Reply-To: <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284337>

cefb2a5e3 ("ls-remote: print URL when no repo is specified") added a
quiet option to ls-remote, but didn't add it to the documentation.  Add
it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index d510c05..27380de 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
-	      [--exit-code] <repository> [<refs>...]
+	      [-q | --quiet] [--exit-code] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,10 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+-q::
+--quiet::
+	Do not print remote URL to stderr.
+
 --upload-pack=<exec>::
 	Specify the full path of 'git-upload-pack' on the remote
 	host. This allows listing references from repositories accessed via
-- 
2.7.0.30.g56a8654.dirty
