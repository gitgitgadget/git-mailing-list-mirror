From: Santi <sbejar@gmail.com>
Subject: [PATCH] Document that "git add" only adds non-ignored files.
Date: Fri, 19 May 2006 23:02:34 +0200
Message-ID: <8aa486160605191402k2863e5edk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri May 19 23:02:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhC7P-0007dH-E7
	for gcvg-git@gmane.org; Fri, 19 May 2006 23:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWESVCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 May 2006 17:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWESVCf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 17:02:35 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:52883 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964844AbWESVCe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 17:02:34 -0400
Received: by wx-out-0102.google.com with SMTP id s6so578530wxc
        for <git@vger.kernel.org>; Fri, 19 May 2006 14:02:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pUrF6bYVaID1M+2s33rUI2JIQzL6kigJvM/4z2K1zG9zK9fJJow5SIWMV8X6mH+ivRn1/ViaIHGZqkHOCH8nVSXU3xe9+VyoAjwlpg0RndKmqKKcFxFUA+Mz8lgFscsiHKP0WqZ9nknxyDnWDjIJdaD906/HbsHcpKEmxrr6q2w=
Received: by 10.70.133.7 with SMTP id g7mr2540734wxd;
        Fri, 19 May 2006 14:02:34 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Fri, 19 May 2006 14:02:34 -0700 (PDT)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20356>

Signed-off-by: Santi B=E9jar <sbejar@gmail.com>


---

 Documentation/git-add.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

9c057bcba388450963085eb5c751b734c04ff045
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 5e31129..1b6a22a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,18 +7,20 @@ git-add - Add files to the index file

 SYNOPSIS
 --------
-'git-add' [-n] [-v] [--] <file>...
+'git-add' [-n] [-v] [--] <filepattern>...

 DESCRIPTION
 -----------
 A simple wrapper for git-update-index to add files to the index,
 for people used to do "cvs add".

+It only adds non-ignored files, to add ignored files use
+"git update-index --add".

 OPTIONS
 -------
-<file>...::
-       Files to add to the index.
+<filepattern>...::
+       Files to add to the index, see gitlink:git-ls-files[1].

 -n::
         Don't actually add the file(s), just show if they exist.
@@ -68,6 +70,7 @@ git-add git-*.sh::
 See Also
 --------
 gitlink:git-rm[1]
+gitlink:git-ls-files[1]

 Author
 ------
--
1.3.3.g97ee3
