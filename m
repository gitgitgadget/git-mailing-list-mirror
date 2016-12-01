Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9CF20756
	for <e@80x24.org>; Thu,  1 Dec 2016 16:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbcLAQbv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 11:31:51 -0500
Received: from mout.web.de ([212.227.17.11]:55554 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbcLAQbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 11:31:51 -0500
Received: from [192.168.178.36] ([79.213.126.9]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNLNt-1cJM1j44TZ-006sir; Thu, 01
 Dec 2016 17:31:47 +0100
Subject: Re: [PATCH 1/3] compat: add qsort_s()
To:     Git List <git@vger.kernel.org>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f35e31c6-c9c3-3514-3932-f069b34488e5@web.de>
Date:   Thu, 1 Dec 2016 17:31:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:nhhvzCvH8HVfsS75r6rYzTkwfq3SvO/etT5KseMalARH6Kre4/K
 /3YmVyNn+LYd1x1GqwUQUVS9UxXxh4507UiKwWrCrE/CsyxXmIQeSs+h7aPLrbs+Nzh/Mxn
 XOuoXHM3WND3Zx2eTvmiI9NT+T6M5f65PYRBaIrOOXlgBglxdRByN5Ckcq/6ud6zwQw7S5q
 YZh2eceIxVo+Gk+o7Scfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aHv2lCvV4Mk=:AIz1ytr1CA1uClJZvdK0DP
 LgGFKPhAPygSVagOQ7y6U4WCJ8k4qlWAePG5EgCKnx95sIW1WdnmzYvdMaUMeVLI/uVDOcUJR
 6UbVF/SF6k3hTFBN2cUSUzQsICS1QRexkpI0im0CFYT7uqApfpURca2HwOvuIyRSXZzRA5vB4
 T7nUKCLcYz6yLJM+oemUOVv7ixSnCpBZqDdDVuITymOXF+y7ZHD5l7/rFNjsIh90AlzH2BkaT
 hrvylOh3y8Ii0/xrqecmdXQ9sbZuOVUCygK/PV7sXn+3gvuG7TrRj/SyJPH4GYAB6qxbuqMvD
 occMjNcxTSHm2WjWHtu2DWEDiCebI71VCYpeVOLJTZn9BZce1H4KFmRhlw+DPEPYtWq8CMe7K
 t9LgiCV9vcfrQtBk9h4rnVnAAb/g92D7Jh8FllEAOnzqnsUaQQ/zRDliywZKUodyjDyLe0SaA
 C+KGTKG7jrRgSshDPY9AgGocuh85r02mq9iW0tpSefgi/eEJVzkAO2UY2Zr1RmmOmOV36W9Du
 N1yNjNUhCv88Or41kUKfwu7Biuy4A4fNh9J2FXQOv3XfIIjS50tN0sD7cDOwaCEGMRSjW4HMU
 7fD8qqn9eI6zKEM4aiAOk2ANTXFaiG+atasyAzlmugOb3RnGKEr0XjSYfXVHu6cpYNt9/ad8B
 7Bq6PP0KfnItWPHzVcb9yWUBzPJPyySlkpbX1UJITpDPtzazU5Ct7HkP/ufE5347PI70ng5+d
 xpUv563H4o1RmqZviZbrnLMUfQQeMeqELipSlVBbI37IJwX/urCQ/iKVGusrQy8+mRiws4SU8
 ipl4KLt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2016 um 17:26 schrieb René Scharfe:
> The function qsort_s() was introduced with C11 Annex K; it provides the
> ability to pass a context pointer to the comparison function, supports
> the convention of using a NULL pointer for an empty array and performs a
> few safety checks.
> 
> Add an implementation based on compat/qsort.c for platforms that lack a
> native standards-compliant qsort_s() (i.e. basically everyone).  It
> doesn't perform the full range of possible checks: It uses size_t
> instead of rsize_t and doesn't check nmemb and size against RSIZE_MAX
> because we probably don't have the restricted size type defined.  For
> the same reason it returns int instead of errno_t.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  Makefile          | 10 ++++++++
>  compat/qsort_s.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  git-compat-util.h |  6 +++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 compat/qsort_s.c

And here's the diff for compat/qsort_s.c with copy detection (-C -C):
---
 compat/{qsort.c => qsort_s.c} | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/compat/qsort.c b/compat/qsort_s.c
similarity index 62%
copy from compat/qsort.c
copy to compat/qsort_s.c
index 7d071afb7..52d1f0a73 100644
--- a/compat/qsort.c
+++ b/compat/qsort_s.c
@@ -3,11 +3,12 @@
 /*
  * A merge sort implementation, simplified from the qsort implementation
  * by Mike Haertel, which is a part of the GNU C Library.
+ * Added context pointer, safety checks and return value.
  */
 
 static void msort_with_tmp(void *b, size_t n, size_t s,
-			   int (*cmp)(const void *, const void *),
-			   char *t)
+			   int (*cmp)(const void *, const void *, void *),
+			   char *t, void *ctx)
 {
 	char *tmp;
 	char *b1, *b2;
@@ -21,13 +22,13 @@ static void msort_with_tmp(void *b, size_t n, size_t s,
 	b1 = b;
 	b2 = (char *)b + (n1 * s);
 
-	msort_with_tmp(b1, n1, s, cmp, t);
-	msort_with_tmp(b2, n2, s, cmp, t);
+	msort_with_tmp(b1, n1, s, cmp, t, ctx);
+	msort_with_tmp(b2, n2, s, cmp, t, ctx);
 
 	tmp = t;
 
 	while (n1 > 0 && n2 > 0) {
-		if (cmp(b1, b2) <= 0) {
+		if (cmp(b1, b2, ctx) <= 0) {
 			memcpy(tmp, b1, s);
 			tmp += s;
 			b1 += s;
@@ -44,19 +45,25 @@ static void msort_with_tmp(void *b, size_t n, size_t s,
 	memcpy(b, t, (n - n2) * s);
 }
 
-void git_qsort(void *b, size_t n, size_t s,
-	       int (*cmp)(const void *, const void *))
+int git_qsort_s(void *b, size_t n, size_t s,
+		int (*cmp)(const void *, const void *, void *), void *ctx)
 {
 	const size_t size = st_mult(n, s);
 	char buf[1024];
 
+	if (!n)
+		return 0;
+	if (!b || !cmp)
+		return -1;
+
 	if (size < sizeof(buf)) {
 		/* The temporary array fits on the small on-stack buffer. */
-		msort_with_tmp(b, n, s, cmp, buf);
+		msort_with_tmp(b, n, s, cmp, buf, ctx);
 	} else {
 		/* It's somewhat large, so malloc it.  */
 		char *tmp = xmalloc(size);
-		msort_with_tmp(b, n, s, cmp, tmp);
+		msort_with_tmp(b, n, s, cmp, tmp, ctx);
 		free(tmp);
 	}
+	return 0;
 }

