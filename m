From: Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Sat, 28 Feb 2015 23:18:14 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 01 05:23:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRvPf-0006tG-BS
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 05:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbbCAEXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 23:23:22 -0500
Received: from dmz-mailsec-scanner-5.mit.edu ([18.7.68.34]:55842 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280AbbCAEXV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2015 23:23:21 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Feb 2015 23:23:21 EST
X-AuditID: 12074422-f79d16d0000024cf-ab-54f293090291
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E5.DF.09423.90392F45; Sat, 28 Feb 2015 23:18:17 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id t214IG7I029431;
	Sat, 28 Feb 2015 23:18:16 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id t214IE6B002842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 28 Feb 2015 23:18:15 -0500
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixG6noss5+VOIwbmlXBZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfGkTOP2Qq2slWc+7GatYHxAGsXIyeHhICJxJoz
	B1kgbDGJC/fWs3UxcnEICSxmkph48wU7hLORUeLiyw6ozG4miR/vfrCDtLAIaEssXXuVGcRm
	E1CT+HD0K9hYEQFRiSPzF7GB2MwC4hKblr9hArGFBZwl/vesBFvHK+Au0fvvBVivqICuxKF/
	f9gg4oISJ2c+YYHo1ZJYPn0bywRGvllIUrOQpBYwMq1ilE3JrdLNTczMKU5N1i1OTszLSy3S
	NdXLzSzRS00p3cQIDi8XpR2MPw8qHWIU4GBU4uFN4PsYIsSaWFZcmXuIUZKDSUmU93rNpxAh
	vqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwc/UA53pTEyqrUonyYlDQHi5I476YffCFCAumJJanZ
	qakFqUUwWRkODiUJ3pcTgRoFi1LTUyvSMnNKENJMHJwgw3mAhp8EqeEtLkjMLc5Mh8ifYtTl
	WNC+fyaTEEtefl6qlDjvCpAiAZCijNI8uDmwtPCKURzoLWGIKh5gSoGb9ApoCRPQkoXrP4As
	KUlESEk1MLbv2jKRVV3A8vGpXpeVP4N7lKfyFlmqdm9VisuK+Nm7bL/Tj3MX07a/Djy4vH3P
	Urn7Bcf/T+V0F2OP0cpzzZQ5d2XtxLUmchZd1913Xd9fqrfXLM+iap8CbxnTjzKzaLnfb5iL
	V+WtWiNmeGibhjyr5C3WRDN/3za/w7u0awOSbsRGzHuvpsRSnJFoqMVcVJwIAGTJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264550>

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 85c7fec..594d7a6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -238,7 +238,7 @@ test_expect_success 'push with pushInsteadOf' '
 test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
 	mk_empty testrepo &&
 	test_config "url.trash2/.pushInsteadOf" testrepo/ &&
-	test_config "url.trash3/.pusnInsteadOf" trash/wrong &&
+	test_config "url.trash3/.pushInsteadOf" trash/wrong &&
 	test_config remote.r.url trash/wrong &&
 	test_config remote.r.pushurl "testrepo/" &&
 	git push r refs/heads/master:refs/remotes/origin/master &&
-- 
2.3.1
