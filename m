From: =?UTF-8?q?M=C3=A5rten=20Kongstad?= <marten.kongstad@gmail.com>
Subject: [PATCH] completion: remove duplicate block for "git commit -c"
Date: Wed, 24 Apr 2013 22:49:06 +0200
Message-ID: <1366836546-11081-1-git-send-email-marten.kongstad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, felipe.contreras@gmail.com, peff@peff.net,
	manlio.perillo@gmail.com,
	=?UTF-8?q?M=C3=A5rten=20Kongstad?= <marten.kongstad@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 22:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6d5-0000IL-UL
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852Ab3DXUtX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 16:49:23 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:55897 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757633Ab3DXUtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:49:22 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so2192090lbi.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=lMuRv88+E4Stx2n9ZEHQOPeIUxi/DpYqLrQzh1BCSU4=;
        b=g4FmksOG2wRyiadrK5NeFPYlSR0K9ZtyzHcJY3zX9TyNCPxPzaqQ2WUywE+gDflaYS
         6EjMWNV6KH6OarvYM/Gfc3rthXeMFyFrXVR68873Tfc2P7DkWK2OYVbe9HOjn65O8H8o
         jKUOoxvTF9PLPtmPH3cVx4aAMrd68cMGPIRMwgTWFOhh1Zc626u/MSg3TGKg3G5PvDA+
         AVO8Fr6ACXp7YhNSwIKH7qdJX8rmLt4JAVCQHoeBRKBBSS16Ym6kjiU2Pb2Ny1JC00g/
         h7Fn2nSfIhXMv3RpfkSjVdwWvpWwZKhXgOjCHMdS9S6y5kQTLown/4BhVjxZ5+NTgOUt
         G2TQ==
X-Received: by 10.112.156.137 with SMTP id we9mr13336764lbb.44.1366836561468;
        Wed, 24 Apr 2013 13:49:21 -0700 (PDT)
Received: from localhost.localdomain ([95.109.106.222])
        by mx.google.com with ESMTPSA id wc5sm1829576lbb.13.2013.04.24.13.49.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 13:49:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222319>

Remove one of two consecutive, identical blocks for "git commit -c".

Signed-off-by: M=C3=A5rten Kongstad <marten.kongstad@gmail.com>
---
 contrib/completion/git-completion.bash |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 93eba46..f67b0f0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1182,13 +1182,6 @@ _git_commit ()
 		;;
 	esac
=20
-	case "$prev" in
-	-c|-C)
-		__gitcomp_nl "$(__git_refs)" "" "${cur}"
-		return
-		;;
-	esac
-
 	case "$cur" in
 	--cleanup=3D*)
 		__gitcomp "default strip verbatim whitespace
--=20
1.7.9.5
