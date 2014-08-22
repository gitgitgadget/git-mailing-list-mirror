From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2 3/3] t0026: Add missing &&
Date: Fri, 22 Aug 2014 21:19:15 +0200
Message-ID: <53F797B3.3070107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 21:19:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKuMs-0000rE-6N
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 21:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaHVTTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2014 15:19:18 -0400
Received: from mout.web.de ([212.227.17.12]:50946 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbaHVTTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 15:19:17 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LuuNx-1WL08g2c1R-0106vS; Fri, 22 Aug 2014 21:19:15
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:aEhkm+inAni9ppI+BaI6vhs/21D3aDfWkWHW2u1Hp83EWIyUaSu
 ep+DAt+cvSCrfhDRfadYMtWWjyLxlBmPeylct6M8i/yKs4AZZ+0L8aXTpNdcYXALC3GwRoC
 klj+MIbOJ5Vut52kZeY7QDwfc9XwLh0RuIFBUYmslfjjPSL31i+TAm0xbv1nRcg5OJVnsjC
 eSvo76sgbzT9t5qAMPCPQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255696>

=46ix the broken && chain

Reported-By: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0026-eol-config.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index 43a580a..4806969 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -84,9 +84,9 @@ test_expect_success NATIVE_CRLF 'eol native is crlf' =
'
=20
 	rm -rf native_eol && mkdir native_eol &&
 	( cd native_eol &&
-	printf "*.txt text\n" > .gitattributes
-	printf "one\r\ntwo\r\nthree\r\n" > filedos.txt
-	printf "one\ntwo\nthree\n" > fileunix.txt
+	printf "*.txt text\n" > .gitattributes &&
+	printf "one\r\ntwo\r\nthree\r\n" > filedos.txt &&
+	printf "one\ntwo\nthree\n" > fileunix.txt &&
 	git init &&
 	git config core.autocrlf false &&
 	git config core.eol native &&
--=20
2.1.0.rc2.210.g636bceb
