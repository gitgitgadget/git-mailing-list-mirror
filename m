From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] fixup! pathspec: support :(glob) syntax
Date: Sat, 30 Mar 2013 17:51:22 +0000
Message-ID: <eeccb0bb969ed30420685c210865da22d9c85407.1364665628.git.john@keeping.me.uk>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 18:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULzwn-0006Xm-UQ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 18:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940Ab3C3Rvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 13:51:36 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:44304 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab3C3Rvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 13:51:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4DEBD198006;
	Sat, 30 Mar 2013 17:51:35 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1rjxO5QPmua; Sat, 30 Mar 2013 17:51:34 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D74FC198001;
	Sat, 30 Mar 2013 17:51:28 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.515.g52d783d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219594>

A formatting fix for a patch currently cooking on nd/magic-pathspecs
(cc3d8045ec1e2323c5654e2af834e887f26deb7e).

---
The latest version of this wasn't posted to the list in full, so I'm not
sure about the recommended way to provide feedback.  Hopefully this is
easy to squash in.

 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f423cd6..d6eb0d3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -443,13 +443,13 @@ help ...`.
 	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
 	variable to `1`.
 
---glob-pathspecs:
+--glob-pathspecs::
 	Add "glob" magic to all pathspec. This is equivalent to setting
 	the `GIT_GLOB_PATHSPECS` environment variable to `1`. Disabling
 	globbing on individual pathspecs can be done using pathspec
 	magic ":(literal)"
 
---noglob-pathspecs:
+--noglob-pathspecs::
 	Add "literal" magic to all pathspec. This is equivalent to setting
 	the `GIT_NOGLOB_PATHSPECS` environment variable to `1`. Enabling
 	globbing on individual pathspecs can be done using pathspec
-- 
1.8.2.515.g52d783d
