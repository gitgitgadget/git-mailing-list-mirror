From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-tag(1): Refer to git-check-ref-format(1) for <name>
Date: Thu, 06 Aug 2009 00:20:32 +0300
Organization: Private
Message-ID: <8763d2klen.fsf@jondo.cante.net>
References: <87ab2gsqst.fsf@jondo.cante.net>
	<7veirs6qxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYo1f-0004tV-1g
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZHEV1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZHEV1t
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:27:49 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:60666 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZHEV1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:27:49 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 17:27:48 EDT
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 1D66B18D2DB;
	Thu,  6 Aug 2009 00:20:37 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05884CE18C; Thu, 06 Aug 2009 00:20:36 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id BE8ED158A62;
	Thu,  6 Aug 2009 00:20:33 +0300 (EEST)
References: <87ab2gsqst.fsf@jondo.cante.net> <7veirs6qxn.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7veirs6qxn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 03 Aug 2009 23:20:20 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.91 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124992>

Explain briefly what characters are prohibited in tag <name>
and point to git-check-ref-format(1) manual page for
further information.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
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
