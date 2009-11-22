From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 4/4] apply: Use the term "working tree" consistently
Date: Sun, 22 Nov 2009 20:53:29 +0100
Message-ID: <4B0996B9.8060608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 20:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCIV7-0000S1-Og
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 20:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbZKVTx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 14:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbZKVTx0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 14:53:26 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52974 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZKVTxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 14:53:25 -0500
Received: by ewy19 with SMTP id 19so1212234ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=CD5e6xwp6GPm5gjs9ARo0ZcDB7RjRovkjZZxyJjQnEI=;
        b=wOwM6wX/NInmVZd26XD7qLAb8LyW0ZhFGwKXfGcouRiIGu18Lb/PZlfeOPpVhn6LAh
         65gAekwqhnLZ5JawF4b8YrHK1qgr0nNPZqtE6zTImWvqtoHifwT9fjA9x2hnBgX5Et8f
         R00EzUFQlddQhAqo2JnHUXvTAqypJqLjSBoR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=SJpTWmonKnl1/wVzwkou7qcVWpcX2gwj1IQSs2EQd3hpzFBTDK7b9KYQj51iYCT+48
         TLlcIQBI4ATFfXCJ95XBwP1agPqvtw+JNtGb8Pw7/t7Nenfs5qV4RhJQAPxIOSfRUwR4
         0y7uB1MD+7UgOueHVs7epfCUXfc04hANiCo4k=
Received: by 10.213.0.144 with SMTP id 16mr2745386ebb.37.1258919610647;
        Sun, 22 Nov 2009 11:53:30 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm870007eya.35.2009.11.22.11.53.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 11:53:30 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133454>

The documentation for 'git apply' uses both the terms
"work tree" and "working tree". Since the glossary uses
the term "working tree", change all occurrences of
"work tree" to "working tree".

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
Junio wrote that he personally would vote for changing
it the other way around starting from the glossary.

"Work tree" feels fine for me (and is shorter than
"working tree"), but I am not a native speaker.

 Documentation/git-apply.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 6a07ec2..c2528a7 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -51,7 +51,7 @@ OPTIONS
=20
 --check::
 	Instead of applying the patch, see if the patch is
-	applicable to the current work tree and/or the index
+	applicable to the current working tree and/or the index
 	file and detects errors.  Turns off "apply".
=20
 --index::
@@ -59,7 +59,7 @@ OPTIONS
 	(which is the default when none of the options that
 	disables it is in effect), make sure the patch is
 	applicable to what the current index file records.  If
-	the file to be patched in the work tree is not
+	the file to be patched in the working tree is not
 	up-to-date, it is flagged as an error.  This flag also
 	causes the index file to be updated.
=20
--=20
1.6.5.3.298.g39add
