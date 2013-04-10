From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive: clarify explanation of --worktree-attributes
Date: Wed, 10 Apr 2013 19:49:57 +0200
Message-ID: <5165A645.9090300@lsrfire.ath.cx>
References: <CAFGOX=VXifkn4oNkqLLF_WG5Dzf4rjd15EV7C=9a_H9CTM+w2Q@mail.gmail.com> <7vk3obpfwc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Amit Bakshi <ambakshi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 19:50:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPz9p-0000ex-VH
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 19:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936815Ab3DJRuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 13:50:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:47530 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936184Ab3DJRt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 13:49:59 -0400
Received: from [192.168.2.105] (p4FFD9211.dip.t-dialin.net [79.253.146.17])
	by india601.server4you.de (Postfix) with ESMTPSA id 0688A1E5;
	Wed, 10 Apr 2013 19:49:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vk3obpfwc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220709>

Make it a bit clearer that --worktree-attributes is about files in the
working tree (checked out files, possibly changed) and not the current
working directory ($PDW).  Link to the ATTRIBUTES section, which has
more details.

Reported-by: Amit Bakshi <ambakshi@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Does this help a bit?

 Documentation/git-archive.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index b4c2e24..3dd3069 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -56,7 +56,8 @@ OPTIONS
 	Write the archive to <file> instead of stdout.
 
 --worktree-attributes::
-	Look for attributes in .gitattributes in working directory too.
+	Look for attributes in .gitattributes files in the working tree
+	as well (see <<ATTRIBUTES>>).
 
 <extra>::
 	This can be any options that the archiver backend understands.
-- 
1.8.2.1
