From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 15/19] refs.h: add some parameter names to function declarations
Date: Mon, 22 Jun 2015 16:03:06 +0200
Message-ID: <802ff45bc3c789ff60964ceed3e4c14650ad583f.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Kk-0005vu-QU
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933708AbbFVOES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50574 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933685AbbFVODz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:55 -0400
X-AuditID: 1207440d-f79136d00000402c-8e-558815b61e30
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F4.42.16428.6B518855; Mon, 22 Jun 2015 10:03:34 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3CcD030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:33 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLtNtCPU4OJLXouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ3RNPcpccEu4YsmMUywNjM8Euhg5OCQETCT2TGXtYuQEMsUkLtxbz9bFyMUhJHCZUaLh
	wEQo5ySTxJZjDewgVWwCuhKLepqZQGwRATWJiW2HWECKmAU6GCUuLN8GViQsECwxrWEbI8gG
	FgFViR0nakDCvAJREg/mH2WD2CYncf74T2YQm1PAQmL+vv9grUIC5hITZz5imcDIu4CRYRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSEDx7mD8v07mEKMAB6MSD+8M+/ZQ
	IdbEsuLK3EOMkhxMSqK8B14DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwtpwFyvGmJFZWpRbl
	w6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHjPinSECgkWpaanVqRl5pQgpJk4OEGG
	c0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL05IO28xQWJuUBRiNZTjIpS4rz+IAkBkERGaR7c
	WFiaeMUoDvSlMG8xSBUPMMXAdb8CGswENPhLbhvI4JJEhJRUA2OKcWBDDsN2P8fwM6+O68w8
	HcJys3CXo01ZYuYbWdGZ332v+KhG8Cx/+aF3p+y2rDT13a7ddW0ngiW//9x+XGujuF3Q7pzn
	MZMlVs6MuidfeK7q4lG1HXw2K2eddImaNT30jx6729dNwhfFsmceCuV4OfOB61fW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272358>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs.h b/refs.h
index b22e308..c9596ea 100644
--- a/refs.h
+++ b/refs.h
@@ -62,7 +62,7 @@ extern int read_ref_full(const char *refname, int resolve_flags,
 			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
 
-extern int ref_exists(const char *);
+extern int ref_exists(const char *refname);
 
 extern int is_branch(const char *refname);
 
@@ -170,15 +170,15 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration.
  */
-extern int head_ref(each_ref_fn, void *);
-extern int for_each_ref(each_ref_fn, void *);
-extern int for_each_ref_in(const char *, each_ref_fn, void *);
-extern int for_each_tag_ref(each_ref_fn, void *);
-extern int for_each_branch_ref(each_ref_fn, void *);
-extern int for_each_remote_ref(each_ref_fn, void *);
-extern int for_each_replace_ref(each_ref_fn, void *);
-extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
-extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
+extern int head_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
+extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
@@ -192,7 +192,7 @@ extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
-extern int for_each_rawref(each_ref_fn, void *);
+extern int for_each_rawref(each_ref_fn fn, void *cb_data);
 
 static inline const char *has_glob_specials(const char *pattern)
 {
-- 
2.1.4
