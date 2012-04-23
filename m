From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] push: suggested updates to push configuration documentation
Date: Mon, 23 Apr 2012 09:48:06 -0700
Message-ID: <xmqqr4vejsxl.fsf_-_@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqipgqlass.fsf@junio.mtv.corp.google.com>
	<vpqobqil9ml.fsf@bauges.imag.fr>
	<xmqq8vhml8z7.fsf@junio.mtv.corp.google.com>
	<xmqqzka2jt64.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:48:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMQw-0002MF-FF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab2DWQsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:48:09 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:46942 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab2DWQsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:48:08 -0400
Received: by qcsp5 with SMTP id p5so1356962qcs.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 09:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Lo9l5KIOmRLm4R8yzJI2sl1YKOqwEn7GyFf7d/UJXzE=;
        b=lSNPNgM4DV+xuiwTw8Gyb9LoNrBs7k3C9eANlsJNvnkUGafUoeusSpumqYqq3Ax7xI
         5iNslCthLw0kgnxqNd6em9J8Ls6dEAThAPxPT7X9shh5pHuB7b3xdiYymv5HBvXXs5An
         6qVBgXNAXnuWlKyELb581RV4Gy4HbpfunkroWsEI4TWm9BEWfo2omcPbbpZk3i0J+0vn
         M4IniczNUp04wOCbcRA+ldxWTVoTNKbkSdvWxS9QMsLFDdgaJczJE4j+95gdBtz5qYtN
         GX/8A+dd/68ipyt3W8Tvj5l/87D5yS4uGjnqdE373r4qKeSjeAlHyu8Dl4l3wgFkqS2R
         hrhg==
Received: by 10.101.129.33 with SMTP id g33mr6138692ann.25.1335199687258;
        Mon, 23 Apr 2012 09:48:07 -0700 (PDT)
Received: by 10.101.129.33 with SMTP id g33mr6138673ann.25.1335199687135;
        Mon, 23 Apr 2012 09:48:07 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id v39si2376363anp.3.2012.04.23.09.48.07
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 09:48:07 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id E47301E004D;
	Mon, 23 Apr 2012 09:48:06 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 8D6E2E120A; Mon, 23 Apr 2012 09:48:06 -0700 (PDT)
In-Reply-To: <xmqqzka2jt64.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 09:42:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmyTGgSme8Nl5406je8hVTqBLbdQlJpq9ifkh/SW03uMAkhl2ISN+/7x4G1ETbS1yGrVExZehVIvbahWJKiCwcwPc8jQjF/fTZ9cK4nOxwxQnEIm/iGvukDWaPkwG6iEFdEDkOt9txdC7JmW+TSL4zWO9rFifp7dtEamnM2SoksVlO/A00=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196148>

This is only to show how the wording suggested in my review comment will
read on top of the endpoint of your series, primarily for reviewing the
counterproposal (I didn't split this apart to apply in steps).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 696544e..f724fc6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1681,29 +1681,29 @@ push.default::
 +
 * `nothing` - do not push anything.
 * `matching` - push all branches having the same name in both ends.
-  This allows those who prepare all the branches into a publishable
-  shape to push them out to a non-shared repository with a single
-  command. This is well suited when pushing to a non-shared
-  repository, but may give surprising results when used on a
-  repository shared by multiple users, since locally stalled
-  branches will attempt a non-fast forward push if other users
-  updated the branch remotely. This is currently the default, but Git
-  2.0 will change the default to `simple`.
+  This is for those who prepare all the branches into a publishable
+  shape and then push them out with a single command.  It is not
+  appropriate for pushing into a repository shared by multiple users,
+  since locally stalled branches will attempt a non-fast forward push
+  if other users updated the branch.
+  +
+  This is currently the default, but Git 2.0 will change the default
+  to `simple`.
 * `simple` - like `upstream`, but refuses to push if the upstream
   branch's name is different from the local one. This is the safest
   option and is well-suited for beginners. It will become the default
   in Git 2.0.
-* `upstream` - push the current branch to its upstream branch. See
-  "branch.<name>.merge" for how to configure the upstream branch. This
-  makes `git push` and `git pull` symmetrical in the sense that `push`
-  will update the same remote ref as the one which is merged by
-  `git pull`.
+* `upstream` - push the current branch to its upstream branch.
+  With this, `git push` will update the same remote ref as the one which
+  is merged by `git pull`, making `push` and `pull` symmetrical.
+  See "branch.<name>.merge" for how to configure the upstream branch.
 * `current` - push the current branch to a branch of the same name.
   +
   The `simple`, `current` and `upstream` modes are for those who want to
   push out a single branch after finishing work, even when the other
-  branches are not yet ready to be pushed out. They are safe when
-  pushing to a shared repository.
+  branches are not yet ready to be pushed out. If you are working with
+  other people to push into the same shared repository, you would want
+  to use one of these.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.7.10.376.g4eb25
