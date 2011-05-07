From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Add commit to list of config.singlekey commands
Date: Sat,  7 May 2011 10:59:04 -0700
Message-ID: <1304791144-3374-1-git-send-email-conrad.irwin@gmail.com>
References: <BANLkTi=Y5o=KP1LnkKqGq31Sqfn-ZZCGNA@mail.gmail.com>
Cc: Valentin Haenel <valentin@fsfe.org>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 19:59:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIlmc-0005gI-Sn
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 19:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab1EGR7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 13:59:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59661 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1EGR7K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 13:59:10 -0400
Received: by pzk9 with SMTP id 9so1841835pzk.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0OTRXRDpYt1zNcAjbP5ij53lmFvJBFlX0z60tlf6Mpo=;
        b=tOeJvTunXvjW5Ed4qsVmrfaH7JXHcQbx4NDxYUtOsoYYpHmqE0Rw+0Q1zvro9tYbE5
         X/FqJnZ5VnTPEa/0O+AqOGljQMyl/b4X6T3iAfDZE0utvSgRI8dVe4pVPX0zUXA0SKYd
         FIjvCQs+MyZL1bGlv6cQEqVnor+vm9PG+CpPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rl9DxDxbNFv3Pfbu+3QxT7TOoE3XAru9qnd5I82QlDqrNz3X4dhv2+Q/ftvI5sbtP7
         u8YtaxhXcHCYjQIah95Y9gWCq4RKpQL6gxFT7J6Qx8y8L5tvrgY9dGMEJn9klBkY0TKY
         ulDGng4RcdSd8SAJW6FE/znJXY7JQ+0BMO6Zc=
Received: by 10.68.19.194 with SMTP id h2mr6925465pbe.84.1304791149131;
        Sat, 07 May 2011 10:59:09 -0700 (PDT)
Received: from scarlatti.dunvegan.biz (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id f5sm2577736pbt.92.2011.05.07.10.59.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 10:59:08 -0700 (PDT)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.75)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1QIlmU-0000t1-Rn; Sat, 07 May 2011 10:59:06 -0700
X-Mailer: git-send-email 1.7.5.188.g4817
In-Reply-To: <BANLkTi=Y5o=KP1LnkKqGq31Sqfn-ZZCGNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173059>

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/config.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 285c7f7..1a060ec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1310,9 +1310,10 @@ interactive.singlekey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
 	Currently this is used by the `\--patch` mode of
-	linkgit:git-add[1], linkgit:git-reset[1], linkgit:git-stash[1] and
-	linkgit:git-checkout[1]. Note that this setting is silently
-	ignored if portable keystroke input is not available.
+	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
+	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
+	setting is silently ignored if portable keystroke input
+	is not available.
 
 log.date::
 	Set the default date-time mode for the 'log' command.
-- 
1.7.5.188.g4817
