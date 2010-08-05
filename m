From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] pretty-options.txt: match --format's documentation with implementation.
Date: Thu,  5 Aug 2010 15:08:05 +0200
Message-ID: <1281013685-29950-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 05 15:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh0Bi-0008QM-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 15:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760201Ab0HENIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 09:08:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56946 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219Ab0HENIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 09:08:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o75D5uX0011943
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 15:05:56 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oh0B4-0001cl-Am; Thu, 05 Aug 2010 15:08:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oh0B4-0007nf-9Y; Thu, 05 Aug 2010 15:08:06 +0200
X-Mailer: git-send-email 1.7.2.1.30.g18195
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Aug 2010 15:05:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o75D5uX0011943
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281618360.32464@9WssorfO9rRqmHkzBCtrBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152655>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Simple alternative to my other patch, which matched the implementation
with the doc. Shouldn't be controversial ...

 Documentation/pretty-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index d78e121..9b6f389 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,5 +1,5 @@
 --pretty[='<format>']::
---format[='<format>']::
+--format='<format>'::
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-- 
1.7.2.1.30.g18195
