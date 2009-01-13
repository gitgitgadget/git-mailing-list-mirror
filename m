From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] git-rebase: Update --whitespace documentation
Date: Tue, 13 Jan 2009 12:01:52 -0500
Message-ID: <20090113170152.GW18365@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 18:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMmfj-0002tp-MF
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 18:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbZAMRB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 12:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbZAMRB5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 12:01:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbZAMRB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 12:01:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 298FA9041B
	for <git@vger.kernel.org>; Tue, 13 Jan 2009 12:01:54 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [68.83.124.46]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E228890419 for
 <git@vger.kernel.org>; Tue, 13 Jan 2009 12:01:53 -0500 (EST)
Content-Disposition: inline
X-Listening-To: Murphy's Law - Ebony & Ivory
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: E0F4B4EE-E193-11DD-B741-5720C92D7133-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105513>

The parameters accepted by the --whitespace option of "git apply" have
changed over time, and the documentation for "git rebase" was out of
sync.  Remove the specific parameter list from the "git rebase"
documentation and simply point to the "git apply" documentation for
details, as is already done in the "git am" documentation.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-rebase.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c8ad86a..dec2b2c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -241,7 +241,7 @@ OPTIONS
 	context exist they all must match.  By default no context is
 	ever ignored.
 
---whitespace=<nowarn|warn|error|error-all|strip>::
+--whitespace=<option>::
 	This flag is passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 
-- 
1.6.1

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
That men do not learn very much from the lessons of history is the
most important of all the lessons of history.
    -- Aldous Huxley Collected Essays, 1959
