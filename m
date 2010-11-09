From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2] Doc: git-push: Specify the default mode in the description
Date: Tue,  9 Nov 2010 13:24:57 +0100
Message-ID: <1289305497-13883-1-git-send-email-santi@agolina.net>
References: <AANLkTimYTRvOb1SjjUyANuTX2sCRKj17bLMbkKKG3rFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 13:25:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFnGB-0002XI-EX
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab0KIMZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 07:25:07 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64228 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab0KIMZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 07:25:06 -0500
Received: by wyb36 with SMTP id 36so4748313wyb.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 04:25:05 -0800 (PST)
Received: by 10.216.180.133 with SMTP id j5mr3472062wem.79.1289305504419;
        Tue, 09 Nov 2010 04:25:04 -0800 (PST)
Received: from localhost.localdomain (ub222011.pcb.ub.es [161.116.222.11])
        by mx.google.com with ESMTPS id w8sm810390wei.45.2010.11.09.04.25.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 04:25:03 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.337.gc40334
In-Reply-To: <AANLkTimYTRvOb1SjjUyANuTX2sCRKj17bLMbkKKG3rFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161040>

Text extracted from the <refspec> option.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/git-push.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e11660a..2c0b311 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -23,6 +23,11 @@ You can make interesting things happen to a reposito=
ry
 every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
=20
+The default operation mode if no explicit refspec is found is
+to push "matching" branches, that is for every branch that exists on
+the local side, the remote side is updated if a branch of the same nam=
e
+already exists on the remote side. See the <refspec> option below for
+more details.
=20
 OPTIONS[[OPTIONS]]
 ------------------
--=20
1.7.3.2.337.gc40334
