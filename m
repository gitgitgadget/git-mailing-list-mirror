From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/7] fetch: add missing documentation
Date: Sat,  7 Dec 2013 23:56:58 -0600
Message-ID: <1386482220-18558-6-git-send-email-felipe.contreras@gmail.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:06:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXVF-0004iR-Op
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810Ab3LHGF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:56 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:46719 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab3LHGEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:45 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so2540489oag.21
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUEOTrftkgLFAM6s6r2epwDe7/DbvpXRY1TDIkf0Epk=;
        b=RmXVnNECL44rwf8wP9K4J/JqnfhGJVw7ow8LrAeyjnYRtxiWLsfivg88yw2eZjPtFr
         DMNihODDmSHYV/oxCCTrHS/1hSOh9faIyy1PdrvCLFuEb4MIMssKc+3ggYNPqc9UPByE
         jkOC9HUyP/ARLr8UaYRRktqiNp/fkz/3xfYDJA7nMKFaG+0IJxZBt/XIkLOnIHp9TngC
         hzKlHZkc6+hWHTnSyrJHcglaY5QtNVGT32tsnnJV+1Nwh5SfZzc8CMYiWD8fXCKgO0r2
         mwJj0HjuHWetchjrVYWiHW14eOdPwFy8XrPxyiXttrqVK7xsKyOg8GsM3oyXRNSQC2az
         h8Vw==
X-Received: by 10.182.230.135 with SMTP id sy7mr8684797obc.24.1386482685066;
        Sat, 07 Dec 2013 22:04:45 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tr10sm8197536obb.6.2013.12.07.22.04.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:44 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
In-Reply-To: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239041>

There's no mention of the 'origin' default, or the fact that the
upstream tracking branch remote is used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fetch.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e08a028..a7b245d 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
 
+When no remote is specified, by default the `origin` remote will be used,
+unless there's an upstream branch configured for the current branch.
+
 OPTIONS
 -------
 include::fetch-options.txt[]
-- 
1.8.5.1+fc1.2.gebd1fb1
