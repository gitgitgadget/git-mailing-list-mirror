From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Mon, 15 Mar 2010 23:49:55 +0100
Message-ID: <m23a01yzcc.fsf@igel.home>
References: <m2tyswb1jp.fsf@igel.home>
	<7v3a0fr740.fsf@alter.siamese.dyndns.org> <m3r5nzw05p.fsf@hase.home>
	<ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 23:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJ6s-0007Lv-TF
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 23:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937044Ab0COWuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 18:50:00 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:41995 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937041Ab0COWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 18:50:00 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 2FEB81C0011F;
	Mon, 15 Mar 2010 23:49:57 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 2739090173;
	Mon, 15 Mar 2010 23:49:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id JQzjWAHxDO64; Mon, 15 Mar 2010 23:49:56 +0100 (CET)
Received: from igel.home (DSL01.83.171.186.255.ip-pool.NEFkom.net [83.171.186.255])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 15 Mar 2010 23:49:56 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id E36F9CA297; Mon, 15 Mar 2010 23:49:55 +0100 (CET)
X-Yow: We have DIFFERENT amounts of HAIR --
In-Reply-To: <ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>
	(Mark Lodato's message of "Sun, 7 Mar 2010 12:27:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142269>

The nested list in the description of the -t option wasn't properly
indented.  Additionally, make it a horizontal labeled list since the
labels are all short.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/git-ls-files.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..d39d8b8 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -108,13 +108,14 @@ OPTIONS
 -t::
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
-	H::	cached
-	S::	skip-worktree
-	M::	unmerged
-	R::	removed/deleted
-	C::	modified/changed
-	K::	to be killed
-	?::	other
+[horizontal]
+	H;;	cached
+	S;;	skip-worktree
+	M;;	unmerged
+	R;;	removed/deleted
+	C;;	modified/changed
+	K;;	to be killed
+	?;;	other
 
 -v::
 	Similar to `-t`, but use lowercase letters for files
-- 
1.7.0.2

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
