From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] Documentation: update description of shell aliases
Date: Wed, 1 Jul 2009 21:30:31 +0530
Message-ID: <2e24e5b90907010900r23ddc8dfl67dee569b508a4b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM2Eg-00056m-7u
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 18:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbZGAQAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 12:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZGAQAa
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 12:00:30 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36743 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbZGAQA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 12:00:29 -0400
Received: by gxk26 with SMTP id 26so1529908gxk.13
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Z9d5pdQq88L19GNjFH9CDi33yD53CjbHteeNewXFmyQ=;
        b=eOsm4oIRj6va2A9RwEM8kfD+UEaKDO0A15stMB0pU2QUz+vXeSScMq0Gt3wJr8QOMO
         KVnbO8STLv44cVqnkpJ0bKuCuny6Gt5MDFtAmvp7K4DAiP8Mw9veDJw0uTYGfAkW/yYo
         qgEYkSRFpvBTs+LszEIw3hMcYOMrpC+fVOQnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cr1McXtQC2xOGaKNA5XgU/Q17jHUUyibQCfWrw4TcqF3nvtzSaVOriQQuNAVO1mRpQ
         JnQKHHwm0/sgUNO5c98izsOOoZHhaVuS7rlFLj9ckn0A1KXj2ipFk2LnDvTxewVqbWm2
         Spb5KoWqMGca5gpclvnAy/7lW/rPdBWP3qVyE=
Received: by 10.231.13.69 with SMTP id b5mr2638475iba.40.1246464031747; Wed, 
	01 Jul 2009 09:00:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122582>

Aliases that invoke shell commands start from the top-level directory,
but this was not documented.

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---
 Documentation/config.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2fecbe3..bf97e1d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -456,7 +456,9 @@ If the alias expansion is prefixed with an
exclamation point,
 it will be treated as a shell command.  For example, defining
 "alias.new = !gitk --all --not ORIG_HEAD", the invocation
 "git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".
+"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+executed from the top-level directory of a repository, which may
+not necessarily be the current directory.

 apply.whitespace::
 	Tells 'git-apply' how to handle whitespaces, in the same way
-- 
1.6.3.3
