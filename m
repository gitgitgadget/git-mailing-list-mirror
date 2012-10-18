From: jari.aalto@cante.net
Subject: [PATCH] Documentation/fetch-options.txt: Clarify --prune with option --tags
Date: Fri, 19 Oct 2012 01:41:22 +0300
Organization: Private
Message-ID: <1350600082-23789-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 00:50:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOyvN-0003mR-CT
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 00:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641Ab2JRWue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 18:50:34 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:54611 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272Ab2JRWud (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 18:50:33 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2012 18:50:33 EDT
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02.mail.saunalahti.fi (Postfix) with SMTP id 2828A818DB
	for <git@vger.kernel.org>; Fri, 19 Oct 2012 01:41:24 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A046651D52E; Fri, 19 Oct 2012 01:41:24 +0300
Received: from picasso.cante.net (a91-155-178-192.elisa-laajakaista.fi [91.155.178.192])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 1563A818DB
	for <git@vger.kernel.org>; Fri, 19 Oct 2012 01:41:23 +0300 (EEST)
Received: from webgit.cante.net ([192.168.1.5] helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.80)
	(envelope-from <jari.aalto@cante.net>)
	id 1TOymI-0006C9-LI; Fri, 19 Oct 2012 01:41:22 +0300
X-Mailer: git-send-email 1.7.10.4
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208027>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/fetch-options.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-option=
s.txt
index b4d6476..90d50fb 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -38,7 +38,8 @@ ifndef::git-pull[]
 -p::
 --prune::
 	After fetching, remove any remote-tracking branches which
-	no longer exist	on the remote.
+	no longer exist	on the remote. If used with option `--tags`,
+	remove tags in a similar manner.
 endif::git-pull[]
=20
 ifdef::git-pull[]
--=20
1.7.10.4
