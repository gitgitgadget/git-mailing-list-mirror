From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 2/6] Remove whitespace breakage from *.h files
Date: Sun, 20 May 2007 12:27:05 +0200
Message-ID: <46502279.60408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpidC-0005pf-5S
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbXETK1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbXETK1M
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:27:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:39009 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbXETK1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:27:11 -0400
Received: by ug-out-1314.google.com with SMTP id 44so893146uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 03:27:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Ar+y7DPHH7QCj0wPn6AOYMwQ07DXkIjydNPBM8yv6HT52j85dE03PghCYfTEMYM1NFkNT5fumy09gWVP9Xhg2hi1Q8BtqrvEFnco+9jL5/UcC5DbDXxVMwxwVRNVc66IgOKZjuATQ8jDKLGcy5BJNrvjjPExdDMwRqMnJvz46+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=cpaWi+yPdCmsb7CpLX2vUgH6eYWvsqJD0Xry0rLiLxDk8Ij81ZcIlehr+EM6VcPEGbmaCH7ggbmpkR3QtcRxjljIkErtH/If1/gamncpcusOuywJOd0AgT2l8ufX3nv4jLDKqMz46vgQ7vOZRSI40xTArdvoCDc5mzkH17K5LyI=
Received: by 10.67.31.17 with SMTP id i17mr2516190ugj.1179656829277;
        Sun, 20 May 2007 03:27:09 -0700 (PDT)
Received: from ?10.0.0.13? ( [151.70.107.76])
        by mx.google.com with ESMTP id o1sm3740375uge.2007.05.20.03.27.07;
        Sun, 20 May 2007 03:27:08 -0700 (PDT)
User-Agent: Thunderbird 2.0b2 (X11/20070313)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47814>

Using 'git apply --whitespace=strip'

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
  cache.h             |    2 +-
  commit.h            |    2 +-
  mozilla-sha1/sha1.h |   18 +++++++++---------
  object.h            |    2 +-
  rsh.h               |    2 +-
  xdiff/xdiff.h       |    1 -
  xdiff/xdiffi.h      |    1 -
  xdiff/xemit.h       |    1 -
  xdiff/xinclude.h    |    1 -
  xdiff/xmacros.h     |    1 -
  xdiff/xprepare.h    |    1 -
  xdiff/xtypes.h      |    1 -
  xdiff/xutils.h      |    1 -
  13 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 4204bc1..9720129 100644
--- a/cache.h
+++ b/cache.h
@@ -480,7 +480,7 @@ extern void prepare_packed_git(void);
  extern void reprepare_packed_git(void);
  extern void install_packed_git(struct packed_git *pack);

-extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
+extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
  					 struct packed_git *packs);

  extern void pack_report(void);
diff --git a/commit.h b/commit.h
index 86e8dca..75b43a5 100644
--- a/commit.h
+++ b/commit.h
@@ -66,7 +66,7 @@ extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit
  /** Removes the first commit from a list sorted by date, and adds all
   * of its parents.
   **/
-struct commit *pop_most_recent_commit(struct commit_list **list,
+struct commit *pop_most_recent_commit(struct commit_list **list,
  				      unsigned int mark);

  struct commit *pop_commit(struct commit_list **stack);
diff --git a/mozilla-sha1/sha1.h b/mozilla-sha1/sha1.h
index 5d82afa..16f2d3d 100644
--- a/mozilla-sha1/sha1.h
+++ b/mozilla-sha1/sha1.h
@@ -1,29 +1,29 @@
-/*
+/*
   * The contents of this file are subject to the Mozilla Public
   * License Version 1.1 (the "License"); you may not use this file
   * except in compliance with the License. You may obtain a copy of
   * the License at http://www.mozilla.org/MPL/
- *
+ *
   * Software distributed under the License is distributed on an "AS
   * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
   * implied. See the License for the specific language governing
   * rights and limitations under the License.
- *
+ *
   * The Original Code is SHA 180-1 Header File
- *
+ *
   * The Initial Developer of the Original Code is Paul Kocher of
- * Cryptography Research.  Portions created by Paul Kocher are
+ * Cryptography Research.  Portions created by Paul Kocher are
   * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
   * Rights Reserved.
- *
+ *
   * Contributor(s):
   *
   *     Paul Kocher
- *
+ *
   * Alternatively, the contents of this file may be used under the
   * terms of the GNU General Public License Version 2 or later (the
- * "GPL"), in which case the provisions of the GPL are applicable
- * instead of those above.  If you wish to allow use of your
+ * "GPL"), in which case the provisions of the GPL are applicable
+ * instead of those above.  If you wish to allow use of your
   * version of this file only under the terms of the GPL and not to
   * allow others to use your version of this file under the MPL,
   * indicate your decision by deleting the provisions above and
diff --git a/object.h b/object.h
index 94f19ee..397bbfa 100644
--- a/object.h
+++ b/object.h
@@ -66,7 +66,7 @@ void set_object_refs(struct object *obj, struct object_refs *refs);

  void mark_reachable(struct object *obj, unsigned int mask);

-struct object_list *object_list_insert(struct object *item,
+struct object_list *object_list_insert(struct object *item,
  				       struct object_list **list_p);

  void object_list_append(struct object *item,
diff --git a/rsh.h b/rsh.h
index 3b41942..ee2f499 100644
--- a/rsh.h
+++ b/rsh.h
@@ -1,7 +1,7 @@
  #ifndef RSH_H
  #define RSH_H

-int setup_connection(int *fd_in, int *fd_out, const char *remote_prog,
+int setup_connection(int *fd_in, int *fd_out, const char *remote_prog,
  		     char *url, int rmt_argc, char **rmt_argv);

  #endif
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index e874a7c..9402bb0 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -103,4 +103,3 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
  #endif /* #ifdef __cplusplus */

  #endif /* #if !defined(XDIFF_H) */
-
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 472aeae..3e099dc 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -57,4 +57,3 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
  		  xdemitconf_t const *xecfg);

  #endif /* #if !defined(XDIFFI_H) */
-
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index e629417..440a739 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -31,4 +31,3 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,


  #endif /* #if !defined(XEMIT_H) */
-
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index 04a9da8..526ccb3 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -40,4 +40,3 @@


  #endif /* #if !defined(XINCLUDE_H) */
-
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index e2cd202..8ef232c 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -51,4 +51,3 @@ do { \


  #endif /* #if !defined(XMACROS_H) */
-
diff --git a/xdiff/xprepare.h b/xdiff/xprepare.h
index 344c569..8fb06a5 100644
--- a/xdiff/xprepare.h
+++ b/xdiff/xprepare.h
@@ -32,4 +32,3 @@ void xdl_free_env(xdfenv_t *xe);


  #endif /* #if !defined(XPREPARE_H) */
-
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 3593a66..2511aef 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -65,4 +65,3 @@ typedef struct s_xdfenv {


  #endif /* #if !defined(XTYPES_H) */
-
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 70d8b98..d5de829 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -45,4 +45,3 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,


  #endif /* #if !defined(XUTILS_H) */
-
-- 
1.5.2.rc3.90.gf33e-dirty
