From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/remote-helpers: document common use-case for private ref
Date: Mon, 26 Aug 2013 11:21:39 +0200
Message-ID: <1377508899-11104-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: felipe.contreras@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 26 11:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDszk-0003q9-6k
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 11:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab3HZJVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 05:21:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39577 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531Ab3HZJVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 05:21:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7Q9LfWw023945
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Aug 2013 11:21:42 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VDszW-0001vb-Sz; Mon, 26 Aug 2013 11:21:42 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VDszW-0002ue-IN; Mon, 26 Aug 2013 11:21:42 +0200
X-Mailer: git-send-email 1.8.4.rc4.4.g57d5d3d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 26 Aug 2013 11:21:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7Q9LfWw023945
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378113702.61425@/7P5MYpxghrlyiUps9fdjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232989>

The current documentation mentions the private ref namespace, but does
not really explain why it can be useful.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This small patch was sent inline during a previous conversation, but
did not really catch attention ;-).

Resending as a proper patch.

 Documentation/gitremote-helpers.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 0827f69..9ae36da 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -176,6 +176,12 @@ applicable refspec takes precedence.  The left-hand of refspecs
 advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
++
+When writing remote-helpers for decentralized version control
+systems, it is advised to keep a local copy of the repository to
+interact with, and to let the private namespace refs point to this
+local repository, while the refs/remotes namespace is used to track
+the remote repository.
 
 'bidi-import'::
 	This modifies the 'import' capability.
-- 
1.8.4.rc4.4.g57d5d3d
