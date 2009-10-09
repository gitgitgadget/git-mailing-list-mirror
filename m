From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/9] Documentation: branch: update --merged description
Date: Fri, 9 Oct 2009 05:18:58 -0500
Message-ID: <20091009101858.GF16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:14:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCUv-0002is-1L
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760574AbZJIKLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760391AbZJIKLz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:11:55 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:17839 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZJIKLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:11:54 -0400
Received: by qw-out-2122.google.com with SMTP id 3so2525213qwe.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IjtDy1tdCWmQGXOdvQdNuGi46Drfx0rydtpn8OFtyHk=;
        b=i/GQDIw6mMnO85alQ/pGuUzqkH02O3IkPvNAObilTrAIt6C9/gyZuaJdM2nSzYRagM
         tJyXRwkSjkojycJfJl/mI1ysW3Pco4WGyEF42nKFyjPg57CIlER8eUEekkAoM3QJO0Xe
         nuJSN2tQmPgqfATWzFNvgED0XD72frSBm3wSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gcl0BcncH7a0MVQ2vDawihgSVi++P07La1B5lU4jF6UvH9+CLNQzlXrzouDfi51w7C
         ynszyxl352AUOugLU9LN8YSHw1KNcFraQdYwZe5trjfnd0/K9+8l3bd5cWokAasOETri
         AdX6h6dXQK9cWmodUMDnvthbQ4TVi5vi/xa7U=
Received: by 10.224.86.134 with SMTP id s6mr2362098qal.63.1255083046601;
        Fri, 09 Oct 2009 03:10:46 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm980yxe.15.2009.10.09.03.10.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:10:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129761>

Update the documentation for --merged and --no-merged to explain
the meaning of the optional parameter introduced in commit 049716b
(branch --merged/--no-merged: allow specifying arbitrary commit,
2008-07-08).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-branch.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index aad71dc..e8b32a2 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -134,11 +134,13 @@ start-point is either a local or remote branch.
 --contains <commit>::
 	Only list branches which contain the specified commit.
 
---merged::
-	Only list branches which are fully contained by HEAD.
+--merged [<commit>]::
+	Only list branches whose tips are reachable from the
+	specified commit (HEAD if not specified).
 
---no-merged::
-	Do not list branches which are fully contained by HEAD.
+--no-merged [<commit>]::
+	Do not list branches whose tips are reachable from the
+	specified commit (HEAD if not specified).
 
 <branchname>::
 	The name of the branch to create or delete.
-- 
1.6.5.rc1.199.g596ec
