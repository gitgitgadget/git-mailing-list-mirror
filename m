From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 8/8] config.txt: Make configuration paragraph more consistent
Date: Thu, 23 Apr 2009 02:38:02 -0700
Message-ID: <1240479482-31366-9-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
 <1240479482-31366-2-git-send-email-bebarino@gmail.com>
 <1240479482-31366-3-git-send-email-bebarino@gmail.com>
 <1240479482-31366-4-git-send-email-bebarino@gmail.com>
 <1240479482-31366-5-git-send-email-bebarino@gmail.com>
 <1240479482-31366-6-git-send-email-bebarino@gmail.com>
 <1240479482-31366-7-git-send-email-bebarino@gmail.com>
 <1240479482-31366-8-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvQB-0001FG-G2
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbZDWJih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbZDWJig
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:4161 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430AbZDWJie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:34 -0400
Received: by wf-out-1314.google.com with SMTP id 26so389637wfd.4
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=vOGvjXwRbPgyoiGUR5Kreh0AVxBvz9yZJODkrVbgrUY=;
        b=uO49hhqDGXM6kl3pF3pPJrk0BCxXjYxLQFI28hJe97Gl7TrQYMBacfJWq0zD+5LZml
         BtMNN6stO+kpKgIAOzs+maa/modINfC4lFuedAXFPJHLtGx2BCEnNIKLIR7RB64UkZ7B
         plpRg9i3GJPptE7Bn/gkOPWidQQFsh0bhJuLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k6OrJrHTW4NteURzUqr+EINBNR8ujAFP+5Z7wOEw2zbhw/ArwRAzeEKco3YqWY2ESK
         gVKBlfbcMIiyEwfDhW7dWMcN2BePDh6WYSmXV9ua2ew3bj3Q8K3ne+7FcBjlZ8+dR3rc
         3uT6Iffo3G3kHoDfQMw32468hC1Tz5dGDMPwQ=
Received: by 10.142.158.3 with SMTP id g3mr281719wfe.265.1240479514213;
        Thu, 23 Apr 2009 02:38:34 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 22sm2780279wfg.23.2009.04.23.02.38.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:33 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:30 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-8-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117322>

By renaming 'information' to 'configuration' we capture more clearly
what a configuration file holds.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/config.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index acd9b31..0b5dad3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3,10 +3,10 @@ CONFIGURATION FILE
 
 The git configuration file contains a number of variables that affect
 the git command's behavior. The `.git/config` file in each repository
-is used to store the information for that repository, and
-`$HOME/.gitconfig` is used to store per user information as
+is used to store the configuration for that repository, and
+`$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
-can be used to store system-wide defaults.
+can be used to store a system-wide default configuration.
 
 The configuration variables are used by both the git plumbing
 and the porcelains. The variables are divided into sections, wherein
-- 
1.6.2.3
