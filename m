From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] SubmittingPatches: Remove diff tool examples
Date: Mon, 19 Sep 2011 00:11:41 +0200
Message-ID: <1316383901-17580-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 00:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Pin-0006Z5-IB
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 00:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778Ab1IRWUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 18:20:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53958 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707Ab1IRWUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 18:20:06 -0400
Received: by eya28 with SMTP id 28so1352868eya.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qB0XM84hM14CLETUOwGGZeVmvajwoVbL/jMu73/smm8=;
        b=DRJ7U3xiVZYsJlxjwnaLFvOh79NMEVf4GehczyHY2GLgW8xCRiKVamYpTHp48tFNQz
         d9dleQEivxrdH9Tpcq7XsQIP3M4Ofzo/gE/JDdz3vs0lyprjEUy06Z/vza/18GOV9Tgr
         YxrP+N1THx2mDtYFzAV0yr48hmFYTOQmk4S64=
Received: by 10.213.114.136 with SMTP id e8mr510022ebq.43.1316383952253;
        Sun, 18 Sep 2011 15:12:32 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id x45sm40006125eeh.11.2011.09.18.15.12.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 15:12:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.1.724.g9519c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181654>

Since Cogito is long deprecated, it is somewhat awkward to leave it
as example. Removing Cogito leaves just git and StGit, which is a
rather incomplete list of git diff tools available. Sidestep the
problem of deciding what tools to mention by not mentioning any.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  This uses the subject Ramkumar suggested. Since the subject no
  longer references Cogito, I've added a reference to the reason
  for this removal as the first line of the description.

 Documentation/SubmittingPatches |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 938eccf..0dbf2c9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -134,8 +134,7 @@ Another thing: NULL pointers shall be written as NULL, not as 0.
 
 (2) Generate your patch using git tools out of your commits.
 
-git based diff tools (git, Cogito, and StGIT included) generate
-unidiff which is the preferred format.
+git based diff tools generate unidiff which is the preferred format.
 
 You do not have to be afraid to use -M option to "git diff" or
 "git format-patch", if your patch involves file renames.  The
-- 
1.7.6.1.724.g9519c
