From: Junio C Hamano <gitster@pobox.com>
Subject: typofix: commit is spelled with two ems
Date: Wed, 04 Sep 2013 15:28:45 -0700
Message-ID: <xmqq4na0kyqq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 00:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHLZt-0001Uf-Jr
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 00:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760572Ab3IDW3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 18:29:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756014Ab3IDW3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 18:29:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49AFE3F29E;
	Wed,  4 Sep 2013 22:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	/QrA0TQAax2z83L2onpFLcEOs4=; b=lMl+xjvwKaWC32mX6y9ADIE4JJy9kDp77
	Zc1VLQVwr1DntWo2ya9bQTgeK1Uo2pm4lFUHkNzJk1VH0prWbGoUkfChLwPqEI28
	qnzvrD9V8qfJnVcoDrAF4+cyy422AcADvHJslx0dGpb78jzyCjMir+yuoPPI0LIg
	sO6QQVwwKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=CsP
	CX/UVXdRB1JsjKTs0Tll0ZI+5d5qC7O2RpTV7SrCKuGvksKEP+86m/XGlMMQ9RbA
	qoM3aZn85uMzwfjhgGPICldSuf1mC9Vw0FAzhQShvdmmI/QP4MrQMAfoneF8ROZo
	NCybaEHXI6HpTWIAZ+LcEgKVFSHMQsg8jkxA2MP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ACA83F283;
	Wed,  4 Sep 2013 22:29:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC85D3F25C;
	Wed,  4 Sep 2013 22:29:09 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6AF5AAE4-15B1-11E3-9F3B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233882>

There are a handful of instances where we say commmit when we mean
commit.  Fix them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 notes-utils.h                   |  2 +-
 t/t3509-cherry-pick-merge-df.sh |  2 +-
 t/t6022-merge-rename.sh         | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/notes-utils.h b/notes-utils.h
index b4cb1bf..564e30c 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -9,7 +9,7 @@
  * Properties of the created commit:
  * - tree: the result of converting t to a tree object with write_notes_tree().
  * - parents: the given parents OR (if NULL) the commit referenced by t->ref.
- * - author/committer: the default determined by commmit_tree().
+ * - author/committer: the default determined by commit_tree().
  * - commit message: msg
  *
  * The resulting commit SHA1 is stored in result_sha1.
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index a5b6a5f..1e5b394 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -74,7 +74,7 @@ test_expect_success 'Setup rename with file on one side matching different dirna
 	echo content > sub/file &&
 	echo foo > othersub/whatever &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	git rm -rf othersub &&
 	git mv sub/file othersub &&
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index c680f78..a89dfbe 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -259,7 +259,7 @@ test_expect_success 'setup for rename + d/f conflicts' '
 	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >sub/file &&
 	echo foo >dir/file-in-the-way &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	echo 11 >>sub/file &&
 	echo more >>dir/file-in-the-way &&
@@ -439,7 +439,7 @@ test_expect_success 'setup both rename source and destination involved in D/F co
 	mkdir one &&
 	echo stuff >one/file &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	git mv one/file destdir &&
 	git commit -m "Renamed to destdir" &&
@@ -479,7 +479,7 @@ test_expect_success 'setup pair rename to parent of other (D/F conflicts)' '
 	echo stuff >one/file &&
 	echo other >two/file &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	git rm -rf one &&
 	git mv two/file one &&
@@ -539,7 +539,7 @@ test_expect_success 'setup rename of one file to two, with directories in the wa
 
 	echo stuff >original &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	mkdir two &&
 	>two/file &&
@@ -583,7 +583,7 @@ test_expect_success 'setup rename one file to two; directories moving out of the
 	mkdir one two &&
 	touch one/file two/file &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	git rm -rf one &&
 	git mv original one &&
@@ -618,7 +618,7 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 
 	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >original &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	git mv original rename &&
 	echo 11 >>rename &&
@@ -649,7 +649,7 @@ test_expect_success 'setup to test avoiding unnecessary update, with D/F conflic
 	mkdir df &&
 	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >df/file &&
 	git add -A &&
-	git commit -m "Common commmit" &&
+	git commit -m "Common commit" &&
 
 	git mv df/file temp &&
 	rm -rf df &&
