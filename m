From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Improve --patch option documentation in git-add
Date: Sun, 13 Sep 2009 09:44:32 +0300
Organization: Private
Message-ID: <87ab0zny27.fsf_-_@jondo.cante.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vbplw28js.fsf@alter.siamese.dyndns.org>
	<87y6p08lz5.fsf@jondo.cante.net>
	<7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 08:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmipF-0001zK-GO
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 08:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbZIMGod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 02:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZIMGoc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 02:44:32 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:43960 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZIMGob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 02:44:31 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 0962FC7AE9
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:44:34 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A025690693C; Sun, 13 Sep 2009 09:44:34 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id ECC7E41BE9
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:44:32 +0300 (EEST)
In-Reply-To: <7vmy5fy2hz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 31 Aug 2009 16:42:16 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128340>

Junio C Hamano <gitster@pobox.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>>     --patch:
>>     -p::
>>         In a modified work tree, choose interactively which patch hunks to
>>         add. This gives a change to review the difference between the
>>         index and the work before adding modified contents to the index.
>
> Sounds sensible.  You may want to be even more direct and succinct, e.g.
>
>     Interactively choose hunks of patch between the index and the work
>     tree and add them to the index.

Thanks, see below,
Jari

>From 63aa94e7782d6340ead0446ea80ed6223d7ac5c1 Mon Sep 17 00:00:00 2001
From: Jari Aalto <jari.aalto@cante.net>
Date: Sun, 13 Sep 2009 09:43:10 +0300
Subject: [PATCH] Improve --patch option documentation in git-add

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-add.txt |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e67b7e8..b94fbec 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -72,9 +72,14 @@ OPTIONS
 
 -p::
 --patch::
-	Similar to Interactive mode but the initial command loop is
-	bypassed and the 'patch' subcommand is invoked using each of
-	the specified filepatterns before exiting.
+	Interactively choose hunks of patch between the index and the
+	work tree and add them to the index. This gives a change to
+	review the difference before adding modified contents to the
+	index.
+
+	This effectively runs ``add --interactive``, but bypass the
+	initial command menu and directly jump to `patch` subcommand.
+	See ``Interactive mode'' for details.
 
 -e, \--edit::
 	Open the diff vs. the index in an editor and let the user
-- 
1.6.3.3
