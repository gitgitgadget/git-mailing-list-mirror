From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-tag(1): Refer to git-check-ref-format(1) for <name>
Date: Mon, 03 Aug 2009 21:20:02 +0300
Message-ID: <87ab2gsqst.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jari.aalto@cante.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 20:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY297-0004wm-Mi
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbZHCSUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZHCSUT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:20:19 -0400
Received: from main.gmane.org ([80.91.229.2]:36732 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbZHCSUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:20:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MY28s-0006oD-Vv
	for git@vger.kernel.org; Mon, 03 Aug 2009 18:20:15 +0000
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 18:20:14 +0000
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 18:20:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.91 (gnu/linux)
Cancel-Lock: sha1:I/ofvkv7S+ixeiesb321yicSZWg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124714>

Explain briefly what characters are prohibited in tag <name>
and point to git-check-ref-format(1) manual page for
more information.
---
 Documentation/git-tag.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index fa73321..1118ce2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -17,7 +17,10 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Adds a 'tag' reference in `.git/refs/tags/`
+
+Adds a 'tag' reference in `.git/refs/tags/`.  The tag <name> must pass
+linkgit:git-check-ref-format[1] which basicly means that control characters,
+space, ~, ^, :, ?, *, [ and \ are prohibited.
 
 Unless `-f` is given, the tag must not yet exist in
 `.git/refs/tags/` directory.
-- 
1.6.3.3
