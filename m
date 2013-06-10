From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 2/6] templates: Reformat pre-commit hook's message
Date: Mon, 10 Jun 2013 20:36:01 +0200
Message-ID: <1370889365-6239-3-git-send-email-richih.mailinglist@gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 20:36:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6x1-00053u-DS
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129Ab3FJSgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:36:16 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:58266 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3FJSgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:36:15 -0400
Received: by mail-ea0-f176.google.com with SMTP id z15so2688841ead.7
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DiNN+Go0TvYn6rwnhhMbJ0rRNpElt28uoow7K4W8+go=;
        b=fVYVd9Yr9oFVBhO05woruobJFt+kbW4TAPnxk91qnsCSw2niaNMRUSWDBD0LRqZjdD
         9rAaPaGYDm5a5bBIw9zzsaN88cvR74MOriphG3yegO2S041+CiXSqW27qM+Y8FAFfqIS
         z3Q+pw63/3fEptvt+roGnl+gqAEbU9+8rsaAD9r7Nr6kQlZt7J5vDRPOYwrY2zPFYpfb
         M4UBMWolzDOXLTZduMVjvYGY9ZqGm4exTA2Ybp6NoBexGBsmz8tDPw5waMJsUznr1B6b
         TLwNanTS1MJS+eavRLhEHZbbwh5Ev6PieZ508N93rxsBAdPQQvTKl9x8BVHCGcJzm2fr
         WJvg==
X-Received: by 10.15.65.8 with SMTP id p8mr4055824eex.55.1370889374435;
        Mon, 10 Jun 2013 11:36:14 -0700 (PDT)
Received: from rockhopper.fritz.box (p54998111.dip0.t-ipconnect.de. [84.153.129.17])
        by mx.google.com with ESMTPSA id ba7sm24960845eeb.0.2013.06.10.11.36.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 11:36:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227348>

Now that the there's only one echo being spawned, the message can span
the full 80 chars.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-commit.sample |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 126ae13..7676c6e 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -33,13 +33,11 @@ if [ "$allownonascii" != "true" ] &&
 then
 	echo 'Error: Attempt to add a non-ascii file name.
 
-This can cause problems if you want to work
-with people on other platforms.
+This can cause problems if you want to work with people on other platforms.
 
 To be portable it is advisable to rename the file.
 
-If you know what you are doing you can disable this
-check using:
+If you know what you are doing you can disable this check using:
 
   git config hooks.allownonascii true
 '
-- 
1.7.10.4
