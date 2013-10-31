From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/16] fetch: add missing documentation
Date: Thu, 31 Oct 2013 03:25:35 -0600
Message-ID: <1383211547-9145-5-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbocQ-00087Y-C8
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3JaJck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:40 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:62497 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3JaJcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:39 -0400
Received: by mail-oa0-f48.google.com with SMTP id m17so2753519oag.21
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EUCvsVaXlQO6mueyk0AuXx9dmLOBb2yoZLTqQuRPeP8=;
        b=0E2yM0ejxIsAIYT64pPByw3YJ/fpJD4lr5QK7G5D/7HjH2gTel4VaJtITBUSemOTSO
         OTjT6kGE9DAk0pKvhp2imYksXUGmeJXjMPu/enuGiAvkTatMwsKKukGcnzSIa7h6Zlgo
         jJ0EVNMktW3zTv3WJok0aTNHuh//coS0yas0Jlazpj3foNgXuRBrhl22ANx2G/8XOS+G
         4X8IBuqXrwM2Mvuw8+GoCaGPLEgsQpEu7xyzmenZwexuUDYvDTkue8iUsYeLl+EtcVZQ
         H4W84Ojx7jhD5fmwJ6fp3uERaKdQZGUZXJKjrxlKVMeEbj/WiaieYWU/QyWxEKfiPRqY
         OCDw==
X-Received: by 10.60.144.230 with SMTP id sp6mr1830281oeb.29.1383211958860;
        Thu, 31 Oct 2013 02:32:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm4517286obb.0.2013.10.31.02.32.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237090>

There's no mention of the 'origin' default, or the fact that the
upstream tracking branch remote is used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fetch.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e08a028..7e75dc4 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
 
+When no remote is specified, by the default the `origin` remote will be used,
+unless there's an upstream branch configured for the current branch.
+
 OPTIONS
 -------
 include::fetch-options.txt[]
-- 
1.8.4.2+fc1
