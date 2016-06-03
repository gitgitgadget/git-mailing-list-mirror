From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/13] do_for_each_ref(): move docstring to the header file
Date: Fri,  3 Jun 2016 14:33:42 +0200
Message-ID: <39f17243f5f85aab5eaa1f8355929027e20fcb74.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oIl-00052N-4H
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbcFCMeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:08 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57645 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932152AbcFCMeG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:06 -0400
X-AuditID: 1207440c-c53ff70000000b85-06-5751793b2684
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B2.57.02949.B3971575; Fri,  3 Jun 2016 08:34:03 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtim005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:02 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqGtdGRhuMP+rocX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDO27d/EWvCav+LxxWesDYyfeLoY
	OTkkBEwk7p6/xN7FyMUhJLCVUeLDxBVsEM5xJolLp/aygFSxCehKLOppZgKxRQQiJBpetTCC
	FDELzGGSuP2wkxkkISzgJ/Fv8TYgm4ODRUBVou1UPYjJKxAlceqdOsQyOYnL0x+wgdicAhYS
	ffd+sIPYQgLmEg/n7GafwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrp
	JkZIyPHsYPy2TuYQowAHoxIP74oFAeFCrIllxZW5hxglOZiURHnPnwUK8SXlp1RmJBZnxBeV
	5qQWH2KU4GBWEuH9UxAYLsSbklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQ
	kuD9UQ7UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KgPhiYAyApHiA9n4Gaect
	LkjMBYpCtJ5iVJQS52UASQiAJDJK8+DGwhLJK0ZxoC+FeX0qgKp4gEkIrvsV0GAmoMEFj/xB
	BpckIqSkGhiNS07ckvyYvWj7Zh77iw3SVv3Pnmn1b7nbnqGdfGpbyYczhp0eR47ME2V6b3Tr
	6+crfFrxcTf2yd/4feeRRmj8uxi+j0sebvNL2PRx+oeLs5hv2ekkTWC6obU38Pcx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296315>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  9 ---------
 refs/refs-internal.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1230dfb..68db3e8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1878,15 +1878,6 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	return retval;
 }
 
-/*
- * Call fn for each reference in the specified ref_cache for which the
- * refname begins with base.  If trim is non-zero, then trim that many
- * characters off the beginning of each refname before passing the
- * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
- * broken references in the iteration.  If fn ever returns a non-zero
- * value, stop the iteration and return that value; otherwise, return
- * 0.
- */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 1bb3d87..b4dd545 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -249,7 +249,15 @@ int rename_ref_available(const char *oldname, const char *newname);
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
 /*
- * The common backend for the for_each_*ref* functions
+ * Call fn for each reference in the specified submodule for which the
+ * refname begins with base. If trim is non-zero, then trim that many
+ * characters off the beginning of each refname before passing the
+ * refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
+ * broken references in the iteration. If fn ever returns a non-zero
+ * value, stop the iteration and return that value; otherwise, return
+ * 0.
+ *
+ * This is the common backend for the for_each_*ref* functions.
  */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
-- 
2.8.1
