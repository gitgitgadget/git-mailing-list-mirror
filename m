From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 02/10] Documentation/bisect: move getting help section to the end
Date: Mon, 29 Jun 2015 17:40:27 +0200
Message-ID: <1435592435-27914-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bBG-0003AV-FW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbbF2PlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:41:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33109 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbbF2Pku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:40:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFeevZ018372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFegv3031666;
	Mon, 29 Jun 2015 17:40:42 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAo-0008DT-Po; Mon, 29 Jun 2015 17:40:42 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Jun 2015 17:40:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFeevZ018372
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197244.11377@oGWQW/lNUmygU7J9TuG4Hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272960>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4cb52a7..2bdc3b8 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -31,12 +31,6 @@ This command uses 'git rev-list --bisect' to help drive the
 binary search process to find which change introduced a bug, given an
 old "good" commit object name and a later "bad" commit object name.
 
-Getting help
-~~~~~~~~~~~~
-
-Use "git bisect" to get a short usage description, and "git bisect
-help" or "git bisect -h" to get a long usage description.
-
 Basic bisect commands: start, bad, good
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -379,6 +373,11 @@ In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit
 has at least one parent whose reachable graph is fully traversable in the sense
 required by 'git pack objects'.
 
+Getting help
+~~~~~~~~~~~~
+
+Use `git bisect` to get a short usage description, and `git bisect
+help` or `git bisect -h` to get a long usage description.
 
 SEE ALSO
 --------
-- 
2.5.0.rc0.10.gd2bff5d
