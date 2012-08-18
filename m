From: mhagger@alum.mit.edu
Subject: [RFC 1/3] t9300: format test in modern style prior to modifying it
Date: Sat, 18 Aug 2012 19:14:44 +0200
Message-ID: <1345310086-20089-2-git-send-email-mhagger@alum.mit.edu>
References: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 19:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2mja-0007AD-RL
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab2HRRWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:22:44 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:46262 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302Ab2HRRWH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 13:22:07 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 13:22:06 EDT
X-AuditID: 12074413-b7f786d0000008bb-12-502fcd96c5ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B4.C7.02235.69DCF205; Sat, 18 Aug 2012 13:15:03 -0400 (EDT)
Received: from michael.fritz.box (p57A25507.dip.t-dialin.net [87.162.85.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7IHEnrS001968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Aug 2012 13:15:01 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqDv9rH6AwaoWJouFff3MFl1Xupks
	GnqvMFtMuN/AbHF7xXxmix8tPcwWK3ctZHJg9/j7/gOTx85Zd9k9nvXuYfS4eEnZY+6nRawe
	nzfJBbBFcdskJZaUBWem5+nbJXBnLGw7wVQwgb1i8tkNbA2MT1i7GDk4JARMJJo+BnUxcgKZ
	YhIX7q1n62Lk4hASuMwoMWftHhYI5zSTxPPv39lBqtgEpCReNvaA2SICshLfD29kBCliFpjI
	JLFr5xxmkISwgLfEtTPH2UBsFgFViVfLJ4DZvAIuEr+frWGGWKco8eM7hM0p4Crx6u5WMFsI
	qGbaiffMExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p3cQICTnhHYy7
	TsodYhTgYFTi4VVYoxcgxJpYVlyZe4hRkoNJSZT3/Rn9ACG+pPyUyozE4oz4otKc1OJDjBIc
	zEoivLongMp5UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8+sDYEhIs
	Sk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUZ8MTA6QFI8QHsdQdp5iwsSc4GiEK2n
	GHU5Jt86e5dRiCUvPy9VSpxXAaRIAKQoozQPbgUswbxiFAf6WJg3GKSKB5ic4Ca9AlrCBLRk
	pYguyJKSRISUVAOjjkOhS8N3ppqZOWGla3Y7lDEEfFneaOtmdv7tc83JexIXG8/VcjKufVFZ
	URzta9Rze9qJPRt8T7EL7d21Kav5RDFX+NYrquWb2nwfhltOXGCicmZ24FWOdRND 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203679>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t9300-fast-import.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2fcf269..266ae30 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1698,12 +1698,12 @@ M 160000 $SUBLAST sub
 
 INPUT_END
 
-test_expect_success \
-	'P: verbatim SHA gitlinks' \
-	'git branch -D sub &&
-	 git gc && git prune &&
-	 git fast-import <input &&
-	 test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)'
+test_expect_success 'P: verbatim SHA gitlinks' '
+	git branch -D sub &&
+	git gc && git prune &&
+	git fast-import <input &&
+	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+'
 
 test_tick
 cat >input <<INPUT_END
-- 
1.7.11.3
