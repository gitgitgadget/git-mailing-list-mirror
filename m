From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] Documentation/git-clean.txt: don't mention deletion of
 .git/modules/*
Date: Sat, 06 Feb 2016 15:34:49 -0500
Message-ID: <1454790889.23898.225.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 21:35:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS9Zt-0007uL-1L
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 21:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbcBFUfC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2016 15:35:02 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:34507 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751931AbcBFUfB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 6 Feb 2016 15:35:01 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Feb 2016 15:35:00 EST
Received: from homiemail-a2.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 98E5728006D
	for <git@vger.kernel.org>; Sat,  6 Feb 2016 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	message-id:subject:from:to:date:content-type:mime-version:
	content-transfer-encoding; s=mattmccutchen.net; bh=62E0xuKXGdhE8
	Nh9l0BwG0pjc98=; b=tlxzvK7+nJaAnoFuDrD6aT3SYxW8jqBLgveizSd/I8l01
	C5UQ4+2KI4GFqIk62xBWCDq3NoZQafBYNnfxIq/hoR9UIfztQb2aDFD0Y7Ks3/PC
	DK/pnTvGUlr9dXiM1302+bPpsPksbecs1G3W86QLWTwPYjElbI9F7O/yg01vI4=
Received: from main (dhcp-18-189-13-223.dyn.MIT.EDU [18.189.13.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTPSA id 739FE280063
	for <git@vger.kernel.org>; Sat,  6 Feb 2016 12:34:59 -0800 (PST)
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285703>

I found no evidence of such behavior in the source code.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---

This is based on the maint branch,=C2=A0a08595f.

=C2=A0Documentation/git-clean.txt | 4 +---
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 641681f..51a7e26 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -37,9 +37,7 @@ OPTIONS
=C2=A0	to false, 'git clean' will refuse to delete files or directories
=C2=A0	unless given -f, -n or -i. Git will refuse to delete directories
=C2=A0	with .git sub directory or file unless a second -f
-	is given. This affects also git submodules where the storage area
-	of the removed submodule under .git/modules/ is not removed until
-	-f is given twice.
+	is given.
=C2=A0
=C2=A0-i::
=C2=A0--interactive::
--=C2=A0
2.5.0
