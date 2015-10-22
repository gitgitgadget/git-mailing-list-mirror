From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Match underline with the text
Date: Thu, 22 Oct 2015 09:57:16 -0700
Message-ID: <xmqqvb9ysuxf.fsf_-_@gitster.mtv.corp.google.com>
References: <1445518740-18221-1-git-send-email-xfq.free@gmail.com>
	<xmqq37x2uah6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Xue Fuqiao <xfq.free@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 18:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpJBB-0006MU-RA
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 18:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbbJVQ5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 12:57:20 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752982AbbJVQ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 12:57:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A898237D5;
	Thu, 22 Oct 2015 12:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbGoKmTnhpYMWD/km+3zyNqLJF0=; b=AXWw7F
	O/L1rTEjzks3gel7oCoI+cFo4RfaIAU+w53lWD5w+RqPGkp77YVYXeeAzBS0Py0h
	/6EKD4dYGc0b7qTbxiVIxGRnf+BdAAptr9v36qHD5z4vBxf0lE1+A4gtYNApv5E4
	3wzFDHtwkCpL9emVKgvQApd9ZS3k0/8PC7sIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjHLYCANWqmB/GIIBzS86g+9QPgc6nne
	UwB/o/f9KihSAd70YIMdeGmYUpmBRP8/YPosS9qLVDvc+1KEmDePbK4+mBFWppCU
	VUbWBjd+YhplIC5wzhJnx5Xujrn46vrQWupLECAjX1TUGuiI8ODY31enimNND/8m
	B9zJdQ7uaGI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41DA6237D4;
	Thu, 22 Oct 2015 12:57:18 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B9946237D3;
	Thu, 22 Oct 2015 12:57:17 -0400 (EDT)
In-Reply-To: <xmqq37x2uah6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 22 Oct 2015 09:36:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3C797CE-78DD-11E5-87FE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280064>

Even though AsciiDoc is more lenient when deciding if an underline
is for the contents on the previous line to find section headers, we
should match the length of them for other formatters to help them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A few more instances I found.

 Documentation/git-bisect.txt         | 2 +-
 Documentation/git-remote.txt         | 2 +-
 Documentation/git-upload-archive.txt | 2 +-
 Documentation/giteveryday.txt        | 2 +-
 Documentation/gitrevisions.txt       | 2 +-
 Documentation/urls-remotes.txt       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 2044fe6..51cacd7 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -256,7 +256,7 @@ Then compile and test the chosen revision, and afterwards mark
 the revision as good or bad in the usual manner.
 
 Bisect skip
-~~~~~~~~~~~~
+~~~~~~~~~~~
 
 Instead of choosing a nearby commit by yourself, you can ask Git to do
 it for you by issuing the command:
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 3c9bf45..1d7ecea 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -1,5 +1,5 @@
 git-remote(1)
-============
+=============
 
 NAME
 ----
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index cbef61b..fba0f1c 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -1,5 +1,5 @@
 git-upload-archive(1)
-====================
+=====================
 
 NAME
 ----
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 7be6e64..35473ad 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -1,5 +1,5 @@
 giteveryday(7)
-===============
+==============
 
 NAME
 ----
diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index c0ed6d1..e903eb7 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -1,5 +1,5 @@
 gitrevisions(7)
-================
+===============
 
 NAME
 ----
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 282758e..bd184cd 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -36,7 +36,7 @@ The `<pushurl>` is used for pushes only. It is optional and defaults
 to `<url>`.
 
 Named file in `$GIT_DIR/remotes`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You can choose to provide the name of a
 file in `$GIT_DIR/remotes`.  The URL
