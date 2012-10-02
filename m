From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] l10n: Fix to Swedish translation
Date: Tue, 2 Oct 2012 08:25:32 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210020821390.30557@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 09:26:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIwrX-0005tx-KI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 09:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab2JBHZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 03:25:41 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47102 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752725Ab2JBHZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 03:25:40 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q927PXR5030851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2012 09:25:33 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q927PWA6030848;
	Tue, 2 Oct 2012 09:25:32 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 02 Oct 2012 09:25:33 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206786>

=46ix bad translation of "Receiving objects".

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
  po/sv.po | 4 ++--
  1 fil =E4ndrad, 2 till=E4gg(+), 2 borttagningar(-)

Dear Junio,

could you please apply this patch to the 1.7.12 maintenance branch, if=20
you intend to do more releases past 1.17.12.2 from there? It contains=20
a fix for the most embarrasing typo in the Swedish translation=20
("Receiveing" became "Deleting"). The fix is already in the big=20
pull-request slated for the next feature release, but I would appreciat=
e=20
if a 1.17.12.3 did contain this...

diff --git a/po/sv.po b/po/sv.po
index b327a0e..141b8d5 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8,7 +8,7 @@
  "Project-Id-Version: git 1.7.12\n"
  "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
  "POT-Creation-Date: 2012-08-06 23:47+0800\n"
-"PO-Revision-Date: 2012-08-14 09:58+0100\n"
+"PO-Revision-Date: 2012-10-02 08:15+0100\n"
  "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
  "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
  "Language: sv\n"
@@ -3381,7 +3381,7 @@

  #: builtin/index-pack.c:986
  msgid "Receiving objects"
-msgstr "Tar bort objekt"
+msgstr "Tar emot objekt"

  #: builtin/index-pack.c:986
  msgid "Indexing objects"
--=20
1.7.12.439.g1414786
