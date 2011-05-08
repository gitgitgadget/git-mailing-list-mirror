From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/48] i18n: git-am echo + gettext message
Date: Sun,  8 May 2011 12:20:37 +0000
Message-ID: <1304857280-14773-6-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2zc-0003bV-Tz
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab1EHMVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 08:21:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1EHMVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:36 -0400
Received: by ewy4 with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zpFCWCyEYcUEpT+KBbMuvZr9TidVM6ZvaHZeGmB4s5c=;
        b=J+wse27lbR9pP4OWQosaIiMLZrFthJqFs9AsrjSWOXbdOs+BR2Ekd6ltRUMOC+UrnL
         7ndBe0zfwFppXumuqdPTZ+fwYvqLwpOWmpfTCYY5w7fmaImuhqP12wonKIe9XrVMg7zc
         60AXnETu2m+/LdfBg28iS+CCJIwBEhDU75svU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TOMotIDprZUdwlVr0gMRPP8Mby4H9M3/nqNwRJxlzMvzEQpjnF9+xLnsMh7hGrv2bA
         m0u8qDhPs6IIhGZZ6r5oEWlBuligfmHlcq3c6KF0BRMyANUJIBd7V9QdlmsHhwDs6EeG
         dlPMLYD98IwbRVEnRJXJlZa3RxF9M0Eb+IT4w=
Received: by 10.213.106.200 with SMTP id y8mr1847457ebo.67.1304857294918;
        Sun, 08 May 2011 05:21:34 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.34
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173109>

---
 git-am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 7c0273c..688f689 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -89,8 +89,8 @@ safe_to_abort () {
 	then
 		return 0
 	fi
-	echo >&2 "You seem to have moved HEAD since the last 'am' failure."
-	echo >&2 "Not rewinding to ORIG_HEAD"
+	echo >&2 "$(gettext "You seem to have moved HEAD since the last 'am' failure.
+Not rewinding to ORIG_HEAD")"
 	return 1
 }
 
-- 
1.7.4.4
