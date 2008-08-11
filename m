From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Do not talk about "diff" in rev-list documentation.
Date: Mon, 11 Aug 2008 11:46:56 -0700
Message-ID: <7vsktbxucf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 20:48:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScR8-0004bR-9D
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 20:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYHKSrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 14:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755074AbYHKSrF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 14:47:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbYHKSrD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 14:47:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F1114F6F8;
	Mon, 11 Aug 2008 14:47:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7570E4F6F6; Mon, 11 Aug 2008 14:46:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E220F810-67D5-11DD-9212-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91970>

Since 8c02eee (git-rev-list(1): group options; reformat; document more
options, 2006-09-01), git-rev-list documentation talks as if it supports
any kind of diff output.  It doesn't.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/rev-list-options.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3aa3809..3d54b94 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -94,6 +94,7 @@ you would get an output line this:
 This implies the '--topo-order' option by default, but the
 '--date-order' option may also be specified.
 
+ifndef::git-rev-list[]
 Diff Formatting
 ~~~~~~~~~~~~~~~
 
@@ -123,6 +124,7 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 -t::
 
 	Show the tree objects in the diff output. This implies '-r'.
+endif::git-rev-list[]
 
 Commit Limiting
 ~~~~~~~~~~~~~~~
