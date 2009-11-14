From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] git-add.txt: fix formatting of --patch section
Date: Fri, 13 Nov 2009 17:45:46 -0800
Message-ID: <1258163146-15595-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:46:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N97iV-00063Y-I7
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 02:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZKNBpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 20:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZKNBpp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 20:45:45 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35679 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbZKNBpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 20:45:45 -0500
Received: by yxe17 with SMTP id 17so3451755yxe.33
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 17:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=QbrKjuz4uvszmHeAbXMU2BnjFL7FlxsMVKSpkChvlyg=;
        b=muiUqaPXwxM0huY+yaEMYcWJg8keDbBI/g8WOV2Ty5728dV1j2/eSm8y+31UhOwdSW
         J1VL0OAoq64w16veWtNAomiVEuzmjPLIuLg719micM1p7X9pziv7qyLXkVsuyJE7+fJe
         ANpogj4FTP5xTVQdmfq5WKuVRyi7MJaAGb32k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BD0NUEskc3UeB1k/h9qANPDiIjWKbOBE7b33KrukQDZHUnLyY4NaOgQtVhZuw/T/Xo
         +Zc4vYRyzj/uNGjCspdh/qd0cyQ+3PMSOkB/d0Ho+KIZgVRNNd3dhZgT0yoqH/G8QWrL
         KO9lJyY3cMNBiXs1FyjyGYC0JZgaQTkz/Bxhg=
Received: by 10.150.214.11 with SMTP id m11mr8027016ybg.130.1258163150316;
        Fri, 13 Nov 2009 17:45:50 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 20sm168538ywh.47.2009.11.13.17.45.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 17:45:49 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Fri, 13 Nov 2009 17:45:46 -0800
X-Mailer: git-send-email 1.6.5.2.155.gbb47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132855>

Extra paragraphs should be prefixed with a plus sign.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-add.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 45ebf87..e93e606 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -76,10 +76,10 @@ OPTIONS
 	work tree and add them to the index. This gives the user a chance
 	to review the difference before adding modified contents to the
 	index.
-
-	This effectively runs ``add --interactive``, but bypasses the
-	initial command menu and directly jumps to `patch` subcommand.
-	See ``Interactive mode'' for details.
++
+This effectively runs `add --interactive`, but bypasses the
+initial command menu and directly jumps to the `patch` subcommand.
+See ``Interactive mode'' for details.
 
 -e, \--edit::
 	Open the diff vs. the index in an editor and let the user
-- 
1.6.5.2.155.gbb47
