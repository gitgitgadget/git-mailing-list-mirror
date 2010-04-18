From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] Fixup: Second argument may be any arbitrary string
Date: Sun, 18 Apr 2010 06:26:37 +0530
Message-ID: <1271552177-sup-2396@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:58:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3IqZ-000540-4J
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab0DRA6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:58:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39690 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab0DRA6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:58:44 -0400
Received: by gwaa18 with SMTP id a18so2017456gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=xWY8mXPpWgLJXXL1WUQk7xxEfqb/wkPpfg0sJq9bj0g=;
        b=oU/UYwWclcDnjgkEASNo9O4yGdzY2H88tlupRkjeMVNsW9OkEkNnhqrCNmD7chdJhP
         M/aNPILxcgBRwM7jrjA5WF5A6jUnwVUay+iAJfhWSdQT0ixzZ0/49mZVEQ3KVGPCP3rV
         /Zi2YNxkDD3Z9RybM2QzytVpgmcwLXl1BwJ3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=gJ25IVad1ibFmMqWa/D5RpVSVatr3WvqHdM1tg6kXQ2qOLoEpFJ0B1bhZSaQPi7Mr8
         mGqMu0bjuSaGqkgMRP8Zda9z7AM7tN+u3aqrEAdr/1JGeMdLzJVO4hb3LNki7dov8bgJ
         Acio4ObL3fgZGtt1wmOuTFXHb5dO9/SZjjSWs=
Received: by 10.151.87.6 with SMTP id p6mr3712369ybl.320.1271552323227;
        Sat, 17 Apr 2010 17:58:43 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm3347469iwn.6.2010.04.17.17.58.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 17:58:42 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145198>

This is intended to be a fixup for commit ad466d1 in pu. As Jonathan
Neider pointed out, the second argument may be any arbitrary string,
and need not conform to any URL-like shape.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 25a0a16..1d0de7f 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -44,9 +44,8 @@ INVOCATION
 Remote helper programs are invoked with one or (optionally) two
 arguments. The first argument specifies a remote repository as in git;
 it is either the name of a configured remote or a URL. The second
-argument specifies a URL of the form '<transport>://<address>' or
-'<transport>::<address>', where '<address>' may be an arbitrary
-string.
+argument specifies a URL; it is usually of the form
+'<transport>://<address>', but any arbitrary string is possible.
 
 When git encounters a URL of the form '<transport>://<address>', where
 '<transport>' is a protocol that it cannot handle natively, it
-- 
1.7.0.4
