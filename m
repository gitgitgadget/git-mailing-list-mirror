From: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
Subject: [PATCH] Add a hint to the output of git-rebase.
Date: Tue, 23 Jun 2009 14:40:18 +0200
Message-ID: <20090623124018.GA9531@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Trstenjak <Daniel.Trstenjak@online.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 14:53:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ5VG-0004Th-Qo
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 14:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbZFWMxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2009 08:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbZFWMxX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 08:53:23 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:50386 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbZFWMxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2009 08:53:23 -0400
X-Greylist: delayed 817 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2009 08:53:22 EDT
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp1.belwue.de with ESMTP id n5NCdj4b026843
	for <git@vger.kernel.org>; Tue, 23 Jun 2009 14:39:46 +0200 (MEST)
	env-from (prvs=41829b1a9=D.Trstenjak@science-computing.de)
X-IronPort-AV: E=Sophos;i="4.42,275,1243807200"; 
   d="scan'208";a="4781694"
Received: from unknown (HELO scmail.science-computing.de) ([192.168.2.1])
  by mx3.science-computing.de with ESMTP; 23 Jun 2009 14:39:45 +0200
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 22826414003;
	Tue, 23 Jun 2009 14:39:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oKId2iOM-4cr; Tue, 23 Jun 2009 14:39:40 +0200 (CEST)
Received: from bug.science-computing.de (bug.science-computing.de [10.10.8.89])
	by scmail.science-computing.de (Postfix) with ESMTP id C362B414001;
	Tue, 23 Jun 2009 14:39:40 +0200 (CEST)
Received: by bug.science-computing.de (Postfix, from userid 1014)
	id 135C41282A6; Tue, 23 Jun 2009 14:40:18 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122085>

Signed-off-by: Daniel Trstenjak <daniel.trstenjak@science-computing.de>
---
 git-rebase.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 334629f..fc02b89 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -36,7 +36,8 @@ cd_to_toplevel
=20
 OK_TO_SKIP_PRE_REBASE=3D
 RESOLVEMSG=3D"
-When you have resolved this problem run \"git rebase --continue\".
+When you have resolved this problem add the resolved files with
+\"git add\" and then run \"git rebase --continue\".
 If you would prefer to skip this patch, instead run \"git rebase --ski=
p\".
 To restore the original branch and stop rebasing run \"git rebase --ab=
ort\".
 "
--=20
1.6.2


--=20
                                                                       =
                                                                   =20
 Daniel Trstenjak         Tel   : +49 (0)7071-9457-264
 science + computing ag   FAX   : +49 (0)7071-9457-511
 Hagellocher Weg 73       mailto: Daniel.Trstenjak@science-computing.de
 D-72070 T=FCbingen         WWW   : http://www.science-computing.de/   =
                                                                  =20
--=20
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier,=20
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196=20
