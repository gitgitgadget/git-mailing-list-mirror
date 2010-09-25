From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH/RFC v2 4/4] rev-parse: update documentation of --flags and --no-flags options
Date: Sat, 25 Sep 2010 19:04:14 +1000
Message-ID: <1285405454-12521-6-git-send-email-jon.seymour@gmail.com>
References: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 11:02:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzQe6-0001vl-U1
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 11:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab0IYJCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 05:02:03 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45840 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab0IYJCC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 05:02:02 -0400
Received: by pxi10 with SMTP id 10so997894pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CybTewyJfiEQn5Pi8Tauo2F0InuonmwJfW83QhPy2O8=;
        b=MVVIU0zqPq/79Ty4e5zk+od85yZNpCm9sBDnpvN4+Eclp4o7aAJvIt5xHFyqGtpddQ
         Zu2E5u8Wq/0VFAKfMkb3IJrgpeoIs49ujH6Svw77EnMZMHnmJQvPqZsnIpEXnKVUETRv
         jI1N4nKT8Hto6O6kh4yKG1TLQXXXQT0GoD6X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VwvQstxxP19VDuXroW6U97Jnz3KMa+wJmTPCGrOVZuV4rwOH4LcaqYmL473zwuHB3r
         HhT6wtFa4wUulC+7nuuWHejxOqocxsRu0S9RLsBz+H90YOlUTGo65Z1JeIcdK5fbMfcF
         RLpZJZAy/gJqYipIu2frOathtyXPEMhvbj5hE=
Received: by 10.142.90.12 with SMTP id n12mr3820675wfb.192.1285405320986;
        Sat, 25 Sep 2010 02:02:00 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.90])
        by mx.google.com with ESMTPS id y36sm3574521wfd.6.2010.09.25.02.01.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 02:02:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.gc81ce.dirty
In-Reply-To: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157138>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 341ca90..8fb8f6b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -49,10 +49,16 @@ OPTIONS
 	'git rev-list' command.
 
 --flags::
-	Do not output non-flag parameters.
+	Do not output non-flag parameters. All remaining
+	arguments will not be interpreted as options
+	to 'git rev-parse' even if they match options that
+	'git rev-parse' might otherwise recognise. As such,
+	this option, if specified, should always be the
+	last option specified.
 
 --no-flags::
-	Do not output flag parameters.
+	Do not output flag parameters. If specified, this
+	option causes any subsequent `--flags` option to be ignored.
 
 --default <arg>::
 	If there is no parameter given by the user, use `<arg>`
-- 
1.7.3.1.gc81ce.dirty
