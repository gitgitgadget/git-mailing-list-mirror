From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] Documentation: Add filter.<driver>.* to config
Date: Sun,  3 Apr 2011 19:55:20 +0530
Message-ID: <1301840722-24344-2-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1301840722-24344-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Helped-by: Michael J Gruber" <git@drmicha.warpmail.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 16:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6OGU-0002ct-06
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 16:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab1DCO0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 10:26:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42759 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1DCO0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 10:26:39 -0400
Received: by iwn34 with SMTP id 34so4981839iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hogCKYt3pia1y0GAXzAB4SkK1W3ygiAKbsKLzaAYSn0=;
        b=AW06A1RLnAtZT3sxBLKbHXjgPSaIRrefT/tlYKpUwjK2A65i7FeVyO5XQgkfA+vR8R
         dEFQxIgTZPN/MMMsBhu+cTi3SQQ/4KWIZlRGSm1ValWBhEEeevQQs3bpgIcwJEafMD6B
         J3WofdjKmmUN0Q/QQPKIiX4rhsOFMs5R0rZnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hYsS5E8Y2s+A0wXmppX/KIZzvRK8MIu7RlMWPT6sAYSkPHfdttNKMPOMK6Dg1FNsZv
         r0cIG1F45ZlIUDsUTksJQrp7hcze/tKpFfPwxOcv3+JzfsR1uP3bGYHf34B+oJqn+rQO
         DsFNZ3MEYxv3TSB6ge4EploUVqbOeht1eDb3c=
Received: by 10.43.58.135 with SMTP id wk7mr8581932icb.433.1301840798893;
        Sun, 03 Apr 2011 07:26:38 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i3sm3011074iby.40.2011.04.03.07.26.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 07:26:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301840722-24344-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170693>

Although the gitattributes page contains comprehensive information
about these configuration options, they should be included in the
config documentation for completeness.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ea55d4..711072c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -973,6 +973,16 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+filter.<driver>.clean::
+	Defines the command to be used to convert the contents of
+	worktree file upon checkin.  See linkgit:gitattributes[5] for
+	details.
+
+filter.<driver>.smudge::
+	Defines the command to be used to convert the blob object to
+	worktree file upon checkout.  See linkgit:gitattributes[5] for
+	details.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-- 
1.7.4.rc1.7.g2cf08.dirty
