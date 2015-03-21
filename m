From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2] t6039: fix broken && chain
Date: Sat, 21 Mar 2015 22:40:02 +0100
Message-ID: <550DE532.3010803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:46:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZRDn-0002Wc-P7
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 22:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbbCUVkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 17:40:08 -0400
Received: from mout.web.de ([212.227.17.12]:62974 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbbCUVkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 17:40:05 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MOAnY-1YckVT1KeS-005bGO; Sat, 21 Mar 2015 22:40:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Provags-ID: V03:K0:XnliGUwbgyrfYT9Jl29r+Ftn2HIvnZJt0b45tvAp+6kEHR8uWxv
 ob5iAMMTYdbqdxqX/MIMOsBdNMRpm8V8l4lr+X3cUlenE8icZWVu+3HqZjj9uYG/lXkzmj4
 oXPcpRCfT5ZGCkCc4Jah4OcN5KZsjushXkcAsxs2ZyTJ+GXpENpxFRESVaK6yg4hw5970uY
 VmY7CDgPg2giNxpWuHCjQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266036>

Add missing &&, detected by the --chain-lint option

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

side note: All other tests passed on jk/test-chain-lint

 t/t6039-merge-ignorecase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6039-merge-ignorecase.sh b/t/t6039-merge-ignorecase.sh
index a977653..531850d 100755
--- a/t/t6039-merge-ignorecase.sh
+++ b/t/t6039-merge-ignorecase.sh
@@ -15,7 +15,7 @@ test_expect_success 'merge with case-changing rename'=
 '
 	>TestCase &&
 	git add TestCase &&
 	git commit -m "add TestCase" &&
-	git tag baseline
+	git tag baseline &&
 	git checkout -b with-camel &&
 	>foo &&
 	git add foo &&
--=20
2.2.0.rc1.790.ge19fcd2
