From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Document git-show-ref [-s|--hash] option.
Date: Wed, 20 Sep 2006 06:14:54 +0200
Message-ID: <20060920061454.8fc28c1f.chriscool@tuxfamily.org>
References: <20060918123241.GA8238@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 06:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPtOT-0000iS-7h
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 06:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWITEIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 00:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWITEIs
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 00:08:48 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:62399 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751111AbWITEIr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 00:08:47 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id C970675BA5;
	Wed, 20 Sep 2006 06:08:45 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
In-Reply-To: <20060918123241.GA8238@diku.dk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27327>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-show-ref.txt |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 529ea17..b724d83 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-show-ref' [-q|--quiet] [--verify] [-h|--head] [-d|--dereference]
-	     [--tags] [--heads] [--] <pattern>...
+	     [-s|--hash] [--tags] [--heads] [--] <pattern>...
 
 DESCRIPTION
 -----------
@@ -40,6 +40,12 @@ OPTIONS
 	Dereference tags into object IDs. They will be shown with "^{}"
 	appended.
 
+-s, --hash::
+
+	Only show the SHA1 hash, not the reference name. When also using
+	--dereference the dereferenced tag will still be shown after the SHA1,
+	this maybe a bug.
+
 --verify::
 
 	Enable stricter reference checking by requiring an exact ref path.
@@ -72,6 +78,16 @@ The output is in the format: '<SHA-1 ID>
 ...
 -----------------------------------------------------------------------------
 
+When using --hash (and not --dereference) the output format is: '<SHA-1 ID>'
+
+-----------------------------------------------------------------------------
+$ git show-ref --heads --hash
+2e3ba0114a1f52b47df29743d6915d056be13278
+185008ae97960c8d551adcd9e23565194651b5d1
+03adf42c988195b50e1a1935ba5fcbc39b2b029b
+...
+-----------------------------------------------------------------------------
+
 EXAMPLE
 -------
 
-- 
1.4.2.1.g4251-dirty
