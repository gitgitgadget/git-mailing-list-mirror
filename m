From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] Documentation/git-clean.txt: don't mention deletion of
 .git/modules/*
Date: Sat, 6 Feb 2016 15:25:41 -0500
Message-ID: <1454897459.2511.14.camel@mattmccutchen.net>
References: <1454790889.23898.225.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 03:11:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSbIA-00061y-16
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 03:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcBHCLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 21:11:00 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:49660 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052AbcBHCLA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 21:11:00 -0500
Received: from homiemail-a5.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id B03B570406A
	for <git@vger.kernel.org>; Sun,  7 Feb 2016 18:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	in-reply-to:references:from:date:subject:to
	:content-transfer-encoding:message-id:mime-version; s=
	mattmccutchen.net; bh=Orseb7BBzRtCY86NzUgGov5soMI=; b=ETu6CpfKEQ
	tD+scDmc3w1GC4VFq9ergxsdqy1k5X4dNoDZBA8g/L+GIlU363gVJJDLEWCWfhtN
	boFO2raiejjmKnc250LDY9XYKit8bjD5ntMbFbH3FEGOf5rcg2ZB/drmUnCpETT8
	LzdvW8bpX+l1g4mDIU5W3i9UiU3cVC9oI=
Received: from main (c-71-233-157-193.hsd1.ma.comcast.net [71.233.157.193])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTPSA id 6A764704063
	for <git@vger.kernel.org>; Sun,  7 Feb 2016 18:10:59 -0800 (PST)
In-Reply-To: <1454790889.23898.225.camel@mattmccutchen.net>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285743>

I found no evidence of such behavior in the source code.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
This is based on the maint branch, a08595f.

Try #2 to get correct email formatting.

 Documentation/git-clean.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 641681f..51a7e26 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -37,9 +37,7 @@ OPTIONS
 	to false, 'git clean' will refuse to delete files or directories
 	unless given -f, -n or -i. Git will refuse to delete directories
 	with .git sub directory or file unless a second -f
-	is given. This affects also git submodules where the storage area
-	of the removed submodule under .git/modules/ is not removed until
-	-f is given twice.
+	is given.
 
 -i::
 --interactive::
-- 
2.5.0
