From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] git-clone.txt: document that pushing from a shallow clone may work
Date: Tue,  3 Mar 2009 12:33:37 +0100
Message-ID: <1236080017-13987-1-git-send-email-dato@net.com.org.es>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mikael Magnusson <mikachu@gmail.com>, Joey Hess <joey@kitenet.net>,
	=?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 03 12:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeStv-0003mt-7f
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZCCLdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 06:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbZCCLdm
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:33:42 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2618
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbZCCLdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:33:41 -0500
Received: from justin (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id E11ED801C02E;
	Tue,  3 Mar 2009 12:33:37 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LeSsT-0003eH-Dx; Tue, 03 Mar 2009 12:33:37 +0100
X-Mailer: git-send-email 1.6.2.rc2.271.ge939
In-Reply-To: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112057>

The documentation used to say that pushing from a shallow clone is not
supported; this is true, though it may work in some simple cases. If a
user notices this fact, such a mismatch between documentation and reali=
ty
may leave them assuming the documentation is wrong and that pushing fro=
m
a shallow clone is supported.

This commit updates the documentation to say that pushing from a shallo=
w
clone may work in some cases, but that it's not guaranteed to always do=
=2E

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
Hello,

this is about http://thread.gmane.org/gmane.comp.version-control.git/11=
0100,
which got a single reply from Mikael Magnusson stating:

> AFAIK, it will work in simple cases, but isn't guaranteed to work.

If that's the case, I think it should be documented, for the reasons
explained in the commit message.

Thanks!

 Documentation/git-clone.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 95f08b9..1b4f864 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -133,8 +133,10 @@ then the cloned repository will become corrupt.
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.  A shallow repository has a
-	number of limitations (you cannot clone or fetch from
-	it, nor push from nor into it), but is adequate if you
+	number of limitations: you cannot clone or fetch from it,
+	nor push into it; pushing from it into a regular repository
+	may work correctly in some cases, but it is not guaranteed to
+	always work.  However, a shallow repository is adequate if you
 	are only interested in the recent history of a large project
 	with a long history, and would want to send in fixes
 	as patches.
--=20
1.6.2.rc2.271.ge939
