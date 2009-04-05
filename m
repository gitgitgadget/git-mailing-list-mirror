From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] bash completion: Update 'git am' options
Date: Sun, 5 Apr 2009 12:33:38 -0400
Message-ID: <20090405163338.GA17135@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 18:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqVJX-0007Nw-5F
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 18:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbZDEQdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 12:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbZDEQdr
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 12:33:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZDEQdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 12:33:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 25014A83C3;
	Sun,  5 Apr 2009 12:33:44 -0400 (EDT)
Received: from inocybe.teonanacatl.org (unknown [98.117.8.36]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C4BE4A83C0; Sun,
  5 Apr 2009 12:33:40 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 877E6CFA-21FF-11DE-9466-BB14ECB1AA3C-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115674>

This adds --committer-date-is-author-date, --ignore-date, and --no-utf8
options.  The --binary option is removed, as it was made a no-op by
cb3a160.  The option list is also sorted alphabetically.
---
 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e72ce24..d3d8203 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -646,7 +646,8 @@ _git_am ()
 		;;
 	--*)
 		__gitcomp "
-			--signoff --utf8 --binary --3way --interactive
+			--3way --committer-date-is-author-date --ignore-date
+			--interactive --keep --no-utf8 --signoff --utf8
 			--whitespace=
 			"
 		return
-- 
1.6.2.2

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Formerly we suffered from crimes; now we suffer from laws.
    -- Publius Cornelius Tacitus, Roman historian, AD 56 - c. 120
