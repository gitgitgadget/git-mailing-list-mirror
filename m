From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix graph in git-rev-parse.txt
Date: Mon, 26 May 2008 16:21:17 -0700
Message-ID: <7vbq2s4poy.fsf@gitster.siamese.dyndns.org>
References: <200805261524.02355.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0m1H-0001Sb-4e
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbYEZXVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbYEZXVb
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:21:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYEZXVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:21:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B478F3BC4;
	Mon, 26 May 2008 19:21:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BE8EE3A5E; Mon, 26 May 2008 19:21:25 -0400 (EDT)
In-Reply-To: <200805261524.02355.barra_cuda@katamail.com> (Michele Ballabio's
 message of "Mon, 26 May 2008 15:24:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77D27944-2B7A-11DD-AA2F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82975>

Michele Ballabio <barra_cuda@katamail.com> writes:

> Preformatted html and man pages show a mangled graph, caused by a
> backslash.
>
> Commit f1ec6b22a8c1ab1cca0f1875f85aea5d2434e5a6 fixed this same issue,
> but it seems that new versions of the Asciidoc toolchain changed their
> behaviour.
>
> Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> ---
>
> This should fix the problem, but I can't test it because I have an old
> Asciidoc installation (works either way here).

Thanks.  I think you also should de-dent the whole picture to keep the
same output, like this...

 Documentation/git-rev-parse.txt |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 6513c2e..5981c79 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -238,16 +238,18 @@ Here is an illustration, by Jon Loeliger.  Both commit nodes B
 and C are parents of commit node A.  Parent commits are ordered
 left-to-right.
 
-    G   H   I   J
-     \ /     \ /
-      D   E   F
-       \  |  / \ 
-        \ | /   |
-         \|/    |
-          B     C
-           \   /
-            \ /
-             A
+........................................
+G   H   I   J
+ \ /     \ /
+  D   E   F
+   \  |  / \
+    \ | /   |
+     \|/    |
+      B     C
+       \   /
+        \ /
+         A
+........................................
 
     A =      = A^0
     B = A^   = A^1     = A~1
