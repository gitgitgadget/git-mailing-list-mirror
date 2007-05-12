From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 2/3] Fix assorted white space damage in *.h files
Date: Sat, 12 May 2007 13:11:59 +0200
Message-ID: <e5bfff550705120411p6146b587s6d688a370536ef33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 13:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpWA-0004G5-EQ
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbXELLMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbXELLMB
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:12:01 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:31063 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbXELLMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:12:00 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1283591nzf
        for <git@vger.kernel.org>; Sat, 12 May 2007 04:11:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VhcmWq26iR4nIzGSlNgYW0C/H494Q4ddHedX+UdoodyB42Is+0rVdDMGpXxKM+fiscpRTTZIfnS9PNFmoYkZMSwD7oKepgOzc5u5sln5TwL+hHjfv9xmf2xPrxWJIY0ZyKqrG25r3vxLZv+/uOonYR01viPuHNeNKGhrk4veL4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GpwLARB49RKzjMfVtOIKFWYhvNx3+xz5Peuk9bT2RpVDNIfQF4g/SYQ08jCNbwSZTKQU9DsbWBxUhiiT5BzijfFMv3d7y6e7PZHU9YhFjOQ/FWKXE7V4/cy/5UbGfUn2vV4phE9sRcnqO9wgOKXd34wG24/lEh+Gfq0/BWKrCK4=
Received: by 10.115.49.16 with SMTP id b16mr218832wak.1178968319163;
        Sat, 12 May 2007 04:11:59 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 12 May 2007 04:11:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47038>

Used the new 'cleanfile' script by H. Peter Anvin, just merged
in Linux tree.

This script cleans up various classes of stealth whitespace.  In
particular, it cleans up:

  - Whitespace (spaces or tabs)before newline;
  - DOS line endings (CR before LF);
  - Space before tab (spaces are deleted or converted to tabs);
  - Empty lines at end of file.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 cache.h  |    2 +-
 commit.h |    2 +-
 diff.h   |    2 +-
 object.h |    2 +-
 rsh.h    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 8e76152..7b81d01 100644
--- a/cache.h
+++ b/cache.h
@@ -479,7 +479,7 @@ extern void prepare_packed_git(void);
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
@@ -66,7 +66,7 @@ extern unsigned long pretty_print_commit(enum
cmit_fmt fmt, const struct commit
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
  **/
-struct commit *pop_most_recent_commit(struct commit_list **list,
+struct commit *pop_most_recent_commit(struct commit_list **list,
 				      unsigned int mark);

 struct commit *pop_commit(struct commit_list **stack);
diff --git a/diff.h b/diff.h
index 63738c1..f7e6377 100644
--- a/diff.h
+++ b/diff.h
@@ -157,7 +157,7 @@ extern void diff_unmerge(struct diff_options *,

 extern int diff_scoreopt_parse(const char *opt);

-#define DIFF_SETUP_REVERSE      	1
+#define DIFF_SETUP_REVERSE		1
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4

diff --git a/object.h b/object.h
index 94f19ee..397bbfa 100644
--- a/object.h
+++ b/object.h
@@ -66,7 +66,7 @@ void set_object_refs(struct object *obj, struct
object_refs *refs);

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
-- 
1.5.2.rc3
