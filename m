From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] User Manual: Write "Git" instead of "GIT"
Date: Sun, 22 Nov 2009 10:47:04 +0100
Message-ID: <4B090898.8020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 10:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC92Y-0005DH-Pv
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 10:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbZKVJrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 04:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZKVJrB
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 04:47:01 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58352 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZKVJq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 04:46:59 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so908373ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=fq2JEW6pEoAigQjYBg1H3yofvlP1JSLmqCd7LUag/Ug=;
        b=HBkAdTWy1dKycDuUxyraLj8WeqXq8pHyC9DneMYavKhZqf9ZphIA+cWHxTS6HYleM2
         7QjGZUrC/EQ6Vyxlrsq+9lIEmPhvQ6zvc3IBOUQ1Q6WVFdjC8XxQ5P3nF9pXcPFAi7f1
         IKZFs7sd/id2fY+qH5UYFGwQBG0IZF81+lA/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=gURrjUTcBmp8WzP296IJFwhSI2WX5v1xRCfFhOB/cQmYjRLHMAYwqNtAKAp1ni/NrT
         ef6qyiagxMT8yjWaKk08wuNCkNP51TczmSFBM6NnRbBkgccimOxr05FPbw0VWrRmuccf
         5/470gcYyNA7GKPLve1WsCaA+LSzm1AOJOaLE=
Received: by 10.213.102.65 with SMTP id f1mr2238350ebo.61.1258883225781;
        Sun, 22 Nov 2009 01:47:05 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm768617eyd.29.2009.11.22.01.47.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 01:47:05 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133429>

In the Table of Contents, there is a notable inconsistency:
first there is "GIT Glossary", followed by "Git Quick Reference"
on the very next line.

Running "grep -c" on user-manual.txt, I find 780 occurrrences of
"git", 37 occurrences of "Git", and 9 occurrences of "GIT".
In general, "git" is the preferred spelling, except at the
beginning of a sentence.

Therefore, change "GIT Glossary" to "Git Glossary" for consistency
with the rest of the document.

Looking at the other eight occurrences of "GIT" I found one other
occurrence that should be changed:

* The mention of "StGIT". Looking at the web pages for "Stacked Git"
  at http://www.procode.org/stgit, I only saw the spelling "StGit",
  except in http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT_Tutorial,
  but that page was last updated in 2006.

The other seven occurrences should not be changed:

* Three occurrences were in the output of 'git show-branch' run
  on the git.git repository.

* One occurrence was in the output of 'git cat-file'.

* One occurrence was as part of the file name "GIT-VERSION-GEN".

* Two occurrences were in comments in scripts quoted in a description
  of Tony Luck's workflow.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/user-manual.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 269ec47..27d97b6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2569,7 +2569,7 @@ them again with linkgit:git-am[1].
 Other tools
 -----------
=20
-There are numerous other tools, such as StGIT, which exist for the
+There are numerous other tools, such as StGit, which exist for the
 purpose of maintaining a patch series.  These are outside of the scope=
 of
 this manual.
=20
@@ -4275,7 +4275,7 @@ You see, Git is actually the best tool to find ou=
t about the source of Git
 itself!
=20
 [[glossary]]
-GIT Glossary
+Git Glossary
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 include::glossary-content.txt[]
--=20
1.6.5.3.298.g39add
