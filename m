From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH/resend] git-rebase: Update --whitespace documentation
Date: Sat, 28 Feb 2009 13:42:02 -0500
Message-ID: <20090228184202.GP4505@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 19:43:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdU9x-0004DQ-NU
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 19:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbZB1SmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 13:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbZB1SmK
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 13:42:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbZB1SmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 13:42:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 456509E2A6;
	Sat, 28 Feb 2009 13:42:06 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [71.173.205.56]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A60D59E2A5; Sat,
 28 Feb 2009 13:42:04 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 7F73BB18-05C7-11DE-9A6D-CFA5EBB1AA3C-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111785>

The parameters accepted by the --whitespace option of "git apply" have
changed over time, and the documentation for "git rebase" was out of
sync.  Remove the specific parameter list from the "git rebase"
documentation and simply point to the "git apply" documentation for
details, as is already done in the "git am" documentation.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

I sent this a few weeks back, but it may have arrived during a
particularly busy time and been lost among the many more important
patches. :)

 Documentation/git-rebase.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30487de..da3c38c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -243,7 +243,7 @@ OPTIONS
 	context exist they all must match.  By default no context is
 	ever ignored.

---whitespace=<nowarn|warn|error|error-all|strip>::
+--whitespace=<option>::
 	This flag is passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Incompatible with the --interactive option.
-- 
1.6.2.rc1

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The power of accurate observation is frequently called cynicism by
those who don't have it.
    -- George Bernard Shaw
