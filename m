From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: AsciiDoc spells em-dash as double-dashes, not triple
Date: Thu, 22 Oct 2015 13:10:53 -0700
Message-ID: <xmqqpp06r7ea.fsf_-_@gitster.mtv.corp.google.com>
References: <561F8DE9.4040703@cetitec.com>
	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>
	<xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
	<5628EBAF.1030205@cetitec.com>
	<xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
	<562911AD.50004@cetitec.com>
	<xmqqd1w6ssg5.fsf@gitster.mtv.corp.google.com>
	<56292612.3020609@cetitec.com>
	<xmqq4mhisqgg.fsf@gitster.mtv.corp.google.com>
	<xmqqzizarb7y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Riesen <alexander.riesen@cetitec.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 22:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpMCc-0006WI-DT
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 22:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917AbbJVULE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 16:11:04 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751330AbbJVULB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 16:11:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E3022495B;
	Thu, 22 Oct 2015 16:10:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=em0Ix/AGfHkhTpkKRQBa6YwFEnE=; b=nxy/70
	uiNe99w8NDvsLxcPrG7nyU17YAtMrnt/T5O2wJQ+W12tthzsHfov+L2FwAlsDddU
	pqMBBiJ77IS4OSuotGKKpY3vcMbKQlM4sRmY78T4qH+pH1Wv2vb5LhZ4hHzJIOs6
	g7bbUnkH8L0RdDUCuOIHADyWW7yPiW47quC3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCkbB1FvW8NKWezGRXqdbYSniZp4sEIQ
	TZU1XHD6iOvz4mfTP9tg5IwUn8GYBHYDCVs8YhrrxdPXTjbAtEu+/5HN92Hzk9Ov
	hsnIu5HruZzu8O9nEaOAnDuXW7yKz9WAcxMYcNMYtxp6SFEf7dmF1gXt1rjGJyYd
	pjp9wnEQm6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45BDC24959;
	Thu, 22 Oct 2015 16:10:55 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B05B324958;
	Thu, 22 Oct 2015 16:10:54 -0400 (EDT)
In-Reply-To: <xmqqzizarb7y.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 22 Oct 2015 11:48:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0007518A-78F9-11E5-AAE9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280072>

Again, we do not usually process release notes with AsciiDoc, but it
is better to be consistent.

This incidentally reveals breakages left by an ancient 5e00439f
(Documentation: build html for all files in technical and howto,
2012-10-23).  The index-format documentation was originally written
to be read as straight text without formatting and when the commit
forced everything in Documentation/ to go through AsciiDoc, it did
not do any adjustment--hence the double-dashes will be seen in the
resulting text that is rendered as preformatted fixed-width without
converted into em-dashes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * An follow-up to recent AsciiDoc markup fixes.

 Documentation/RelNotes/1.7.7.txt         | 2 +-
 Documentation/RelNotes/1.9.0.txt         | 2 +-
 Documentation/git-bisect.txt             | 2 +-
 Documentation/git-fetch.txt              | 2 +-
 Documentation/git-push.txt               | 2 +-
 Documentation/technical/index-format.txt | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes/1.7.7.txt b/Documentation/RelNotes/1.7.7.txt
index 7655ccc..6eff128 100644
--- a/Documentation/RelNotes/1.7.7.txt
+++ b/Documentation/RelNotes/1.7.7.txt
@@ -84,7 +84,7 @@ Updates since v1.7.6
    logic used by "git diff" to determine the hunk header.
 
  * Invoking the low-level "git http-fetch" without "-a" option (which
-   git itself never did---normal users should not have to worry about
+   git itself never did--normal users should not have to worry about
    this) is now deprecated.
 
  * The "--decorate" option to "git log" and its family learned to
diff --git a/Documentation/RelNotes/1.9.0.txt b/Documentation/RelNotes/1.9.0.txt
index 752d791..4e4b88a 100644
--- a/Documentation/RelNotes/1.9.0.txt
+++ b/Documentation/RelNotes/1.9.0.txt
@@ -177,7 +177,7 @@ Performance, Internal Implementation, etc.
  * The naming convention of the packfiles has been updated; it used to
    be based on the enumeration of names of the objects that are
    contained in the pack, but now it also depends on how the packed
-   result is represented---packing the same set of objects using
+   result is represented--packing the same set of objects using
    different settings (or delta order) would produce a pack with
    different name.
 
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4cb52a7..617efa0 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -245,7 +245,7 @@ cannot be tested. If the script exits with this code, the current
 revision will be skipped (see `git bisect skip` above). 125 was chosen
 as the highest sensible value to use for this purpose, because 126 and 127
 are used by POSIX shells to signal specific error status (127 is for
-command not found, 126 is for command found but not executable---these
+command not found, 126 is for command found but not executable--these
 details do not matter, as they are normal errors in the script, as far as
 "bisect run" is concerned).
 
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 8deb614..ee51c1a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -71,7 +71,7 @@ This configuration is used in two ways:
 * When `git fetch` is run without specifying what branches
   and/or tags to fetch on the command line, e.g. `git fetch origin`
   or `git fetch`, `remote.<repository>.fetch` values are used as
-  the refspecs---they specify which refs to fetch and which local refs
+  the refspecs--they specify which refs to fetch and which local refs
   to update.  The example above will fetch
   all branches that exist in the `origin` (i.e. any ref that matches
   the left-hand side of the value, `refs/heads/*`) and update the
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index b17283a..3267e21 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -61,7 +61,7 @@ be named.
 If `git push [<repository>]` without any `<refspec>` argument is set to
 update some ref at the destination with `<src>` with
 `remote.<repository>.push` configuration variable, `:<dst>` part can
-be omitted---such a push will update a ref that `<src>` normally updates
+be omitted--such a push will update a ref that `<src>` normally updates
 without any `<refspec>` on the command line.  Otherwise, missing
 `:<dst>` means to update the same ref as the `<src>`.
 +
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 1250b5c..61cb55d 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -170,7 +170,7 @@ Git index format
 
   The entries are written out in the top-down, depth-first order.  The
   first entry represents the root level of the repository, followed by the
-  first subtree---let's call this A---of the root level (with its name
+  first subtree--let's call this A--of the root level (with its name
   relative to the root level), followed by the first subtree of A (with
   its name relative to A), ...
 
-- 
2.6.2-390-g2f019b7
