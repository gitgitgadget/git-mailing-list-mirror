From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/8] t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
Date: Sun, 10 May 2015 04:45:31 +0200
Message-ID: <1431225937-10456-3-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 05:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHUk-0004o6-97
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 05:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbbEJDBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 23:01:12 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54618 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072AbbEJDBK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 23:01:10 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2015 23:01:09 EDT
X-AuditID: 12074411-f79fa6d000006b8a-24-554ec660a5cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.78.27530.066CE455; Sat,  9 May 2015 22:45:52 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxa015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:50 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqJtwzC/U4O9bPouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8b/K2uYCz6yV+zolGpgPMDWxcjJISFgItHU/o0dwhaTuHBvPVCci0NI
	4DKjxLX375kgnONMEi/2HmMBqWIT0JVY1NMMlODgEBHwkmibWQxSwyzQyyjxaPErRpAaYYFg
	ie+nn4FNZRFQlejbcB5sG6+Ai8Tie69ZIbbJSZw//pMZxOYUcJW4fWYumC0EVNO4tIllAiPv
	AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghISa4g3HGSblDjAIcjEo8
	vB+2+YUKsSaWFVfmHmKU5GBSEuW1WQgU4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7cj1Qjjcl
	sbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwRt7FKhRsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDtrQRp5y0uSMwFikK0nmJUlBLn9QJJCIAk
	Mkrz4MbCEscrRnGgL4V5A0GqeIBJB677FdBgJqDBf4t9QAaXJCKkgFHuv1HOrcrpyTGD4Bk3
	Ox3vMmlcUrDTcrjqNXeB8Pxbyk/WtJY3SemZ92+wMq6f5R+1pGjtnBNFyzO6M1xXbWlXmfH9
	900feZYi7esam+7cFZqqs4T9V085T+/Sr6v1530T02R/0KAScfde29driSfDNqe1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268723>

From: Stefan Beller <sbeller@google.com>

During creation of the patch series our discussion we could have a
more descriptive name for the prerequisite for the test so it stays
unique when other limits of ulimit are introduced.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t7004-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 796e9f7..06b8e0d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1463,10 +1463,10 @@ run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
 
-test_lazy_prereq ULIMIT 'run_with_limited_stack true'
+test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
 
 # we require ulimit, this excludes Windows
-test_expect_success ULIMIT '--contains works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE '--contains works in a deep repo' '
 	>expect &&
 	i=1 &&
 	while test $i -lt 8000
-- 
2.1.4
