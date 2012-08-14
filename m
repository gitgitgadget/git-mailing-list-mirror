From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Document bash style we prefer for if and functions
Date: Tue, 14 Aug 2012 22:39:31 +0200
Message-ID: <20120814203931.GB33843@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Nts-0006cV-9z
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab2HNUje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:39:34 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:56840 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab2HNUjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:39:33 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T1Ntk-0004rB-He; Tue, 14 Aug 2012 22:39:32 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203446>

During discussion of other patches these preferences have been revealed.
Lets add them to the guidelines.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4557711..0a07990 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -76,11 +76,16 @@ For shell scripts specifically (not exhaustive):
 
  - We do not use Process Substitution <(list) or >(list).
 
+ - We prefer "then" on the next line for if statements.
+
  - We prefer "test" over "[ ... ]".
 
  - We do not write the noiseword "function" in front of shell
    functions.
 
+ - We prefer a space between the function name and the parentheses.
+   E.g.: my_function ()
+
  - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
    [::], [==], nor [..]) for portability.
 
@@ -97,6 +102,7 @@ For shell scripts specifically (not exhaustive):
    interface translatable. See "Marking strings for translation" in
    po/README.
 
+
 For C programs:
 
  - We use tabs to indent, and interpret tabs as taking up to
-- 
1.7.12.rc2.11.g5d52328
