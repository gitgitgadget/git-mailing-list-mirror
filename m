From: Mark Szepieniec <mszepien@gmail.com>
Subject: [PATCH] Documentation: improve phrasing in git-push.txt
Date: Tue, 27 Nov 2012 01:37:34 +0000
Message-ID: <1353980254-8033-1-git-send-email-mszepien@gmail.com>
Cc: Mark Szepieniec <mszepien@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 02:38:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdA8L-0000os-62
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 02:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821Ab2K0Bi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 20:38:29 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45652 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757808Ab2K0Bi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 20:38:28 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm6so3911929wib.1
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 17:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qhZlwerQwGkcd2AV65D1kjdEnjLoxB2E267EwZf7YSo=;
        b=zMoeHyiJ5GlTkX29CkN7nOm6teReRmg9ArcBa0cu9GBEswL6AREGq6TesPoTPnO6e2
         SaOWYl/ygDdfHc7q5W8LA5iJ9MZOFnEJpWtnsb/YmzY/WayHp22CSohUAOCUlBYitnza
         OE6708s7LN8vi2Bi319MbaBOOFvwSuUac7pR12ur3lWmThbInGrrkTcbokmS2GMbLFPE
         0VeSFC2icxWTasSKqbYgJYeX/QXUEUAereoWFtJdfaLEuPnPBATntTjUPibJlMZA/2gi
         VfnEvrp359CXvE+pl6tKM1IecLk6z966B5a6VCmwu/5LK+jMzafr5gSWY1SSLN6axB8H
         wIhg==
Received: by 10.180.93.40 with SMTP id cr8mr24096691wib.15.1353980307291;
        Mon, 26 Nov 2012 17:38:27 -0800 (PST)
Received: from localhost.localdomain ([109.125.10.66])
        by mx.google.com with ESMTPS id y3sm482795wix.6.2012.11.26.17.38.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Nov 2012 17:38:26 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210525>

The current version contains the sentence:

Further suppose that the other person already pushed changes leading to
A back to the original repository you two obtained the original commit
X.

which doesn't parse for me; I've changed it to

Further suppose that the other person already pushed changes leading to
A back to the original repository from which you two obtained the
original commit X.

Signed-off-by: Mark Szepieniec <mszepien@gmail.com>
---
 Documentation/git-push.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index fe46c42..6d19d59 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -286,7 +286,8 @@ leading to commit A.  The history looks like this:
 ----------------
 
 Further suppose that the other person already pushed changes leading to A
-back to the original repository you two obtained the original commit X.
+back to the original repository from which you two obtained the original
+commit X.
 
 The push done by the other person updated the branch that used to point at
 commit X to point at commit A.  It is a fast-forward.
-- 
1.7.5.4
