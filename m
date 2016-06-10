From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/6] t1404: document function test_update_rejected
Date: Fri, 10 Jun 2016 10:14:46 +0200
Message-ID: <8d628cac9086238c1507c08838963a7900a1cd32.1465544913.git.mhagger@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, David Turner <novalis@novalis.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:15:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHbM-0001m3-Tj
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbcFJIPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:15:12 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51908 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888AbcFJIPB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:15:01 -0400
X-AuditID: 12074412-51bff700000009f7-b7-575a77040781
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 58.07.02551.4077A575; Fri, 10 Jun 2016 04:15:00 -0400 (EDT)
Received: from michael.fritz.box (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8EpD5028943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:14:58 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465544913.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqMtSHhVu8O+KlEXXlW4mi4beK8wW
	T+beZba4vWI+s8WSh6+ZLbqnvGW0+NHSw+zA7vH3/Qcmj52z7rJ7PHzVxe7R1X6EzeNZ7x5G
	j4uXlD0+b5ILYI/itklKLCkLzkzP07dL4M6Y/fsMa8E5jor7k5+wNTB2sncxcnJICJhIXHr9
	krmLkYtDSGAro8T/v4tYIJyTTBIfF7xkAaliE9CVWNTTzARiiwioSUxsOwRWxCzQySRxYs8b
	sCJhAVeJdxdWgI1lEVCVOHzkNVgDr0CUxJVzB1gg1slJXJ7+gA3E5hSwkDh9fQKYLSRgLvFv
	dhP7BEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCwkxoB+P6k3KH
	GAU4GJV4eCN2RYYLsSaWFVfmHmKU5GBSEuXdGRgVLsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	Vwwkx5uSWFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwTu1FKhRsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQF8cXAOABJ8QDtbQdp5y0uSMwFikK0nmLU5Tiy
	/95aJiGWvPy8VClx3kUgRQIgRRmleXArYEnlFaM40MfCvJplQFU8wIQEN+kV0BImoCXLj4SD
	LClJREhJNTDWlVSzxvx8ev7i1mR5uaiTR57MuLd4tsiLl8e25Zfb5SmGfxX+2xGsnXlxdXRh
	aclivc/f1OZckv68QKc9MbxEV8YvoXSSkNX81b83y4ZGl0aIr3iwwn7Xhejjbwti 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296954>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-errors.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 541cad1..7cfeaa9 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -3,6 +3,16 @@
 test_description='Test git update-ref error handling'
 . ./test-lib.sh
 
+# Create some references, perhaps run pack-refs --all, then try to
+# create some more references. Ensure that the second creation fails
+# with the correct error message.
+# Usage: test_update_rejected <before> <pack> <create> <error>
+#   <before> is a ws-separated list of refs to create before the test
+#   <pack> (true or false) tells whether to pack the refs before the test
+#   <create> is a list of variables to attempt creating
+#   <error> is a string to look for in the stderr of update-ref.
+# All references are created in the namespace specified by the current
+# value of $prefix.
 test_update_rejected () {
 	before="$1" &&
 	pack="$2" &&
-- 
2.8.1
