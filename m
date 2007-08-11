From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: List environmental variables which were missing
Date: Sun, 12 Aug 2007 00:38:37 +0200
Message-ID: <1186871917846-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 00:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJzbc-0003ZA-Ue
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 00:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761124AbXHKWip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 18:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758990AbXHKWip
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 18:38:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:60457 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759200AbXHKWio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 18:38:44 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1046837fkz
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 15:38:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=V6qT6UouQkam6a7xPH1H8WkkhhOeuUO1niCJycHem8guxaQWsc0n1x/5DRxRhoc7iWurFFQEUzRuhO51dPwjzJZvG1zeaTB7OCr6q2FWYTgT1TILwMt11cWavJHuXGM3/FiKqZ1LlS02AK5Rjg2mg9RO+fuqMQorPEtwd+IbajM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=Q/fWbAJbGPgZuMu7YwiMHU6bn6cm73XSgB98+KhXa2xsFRp40XF4qijj5qfq9HT4GwKPCQ3nJ4YwjtnOqXlMXVuM+bDARLF70EuAZsDh9zjO4pVGkTwK4NIF8xHMwQka4KUGZjYNtXtzsinhbS/P6pC/8Obm2+TSnt9PzI4bp8U=
Received: by 10.86.1.1 with SMTP id 1mr3140145fga.1186871922625;
        Sat, 11 Aug 2007 15:38:42 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id g28sm8388277fkg.2007.08.11.15.38.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2007 15:38:41 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l7BMccf4025012;
	Sun, 12 Aug 2007 00:38:39 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l7BMcboV025011;
	Sun, 12 Aug 2007 00:38:37 +0200
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55645>

Add to list environmental variables in "Environment variables" section
of git(7) which are documented on other manpages, but were missing in
the list, in the form of link to appropriate manpage (similarly to how
GIT_AUTHOR_* variables are documented in git(7)).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 18f8b6a..8a0399e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -411,6 +411,24 @@ parameter, <path>.
 
 other
 ~~~~~
+'GIT_CONFIG'::
+'GIT_CONFIG_LOCAL'::
+	Specifies config file.
+	See gitlink:git-config[1]
+
+'GIT_PROXY_COMMAND'::
+'GIT_SSL_NO_VERIFY'::
+'GIT_SSL_CERT'::
+'GIT_SSL_KEY'::
+'GIT_SSL_CAINFO'::
+'GIT_SSL_CAPATH'::
+'GIT_HTTP_MAX_REQUESTS'::
+'GIT_HTTP_LOW_SPEED_LIMIT'::
+'GIT_HTTP_LOW_SPEED_TIME'::
+'GIT_CURL_FTP_NO_EPSV'::
+	Overrides appropriate configuration variable.
+	See gitlink:git-config[1]
+
 'GIT_MERGE_VERBOSITY'::
 	A number controlling the amount of output shown by
 	the recursive merge strategy.  Overrides merge.verbosity.
-- 
1.5.2.4
