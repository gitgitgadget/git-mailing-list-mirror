From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] dir.c: Fix two minor grammatical errors in comments
Date: Mon, 4 May 2009 13:37:30 -0400
Message-ID: <20090504173730.GA3940@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 19:38:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1277-0004vU-MM
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 19:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619AbZEDRhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 13:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbZEDRhm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 13:37:42 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:56480 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbZEDRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 13:37:40 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1027377eyd.37
        for <git@vger.kernel.org>; Mon, 04 May 2009 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=VfJVe0quPbhX7aXas835+CDPYL7WTt2lZxniy71T1Ps=;
        b=EIsMYPYZbBcl7w4qA1NeWaBzFxToCBNI3iF9dZUchyKbUDSX9Qim/R4sGIYCulHr0d
         YA/sDB/3yPp2OgNSxiEB5UZyyTaSWMhIjtB750t7qMtlE1i0V6+j5IQ2tb1uRLAR2vbX
         8GM0sO7jOtU+BkpdrtaL8riQCdPz6OWREuhvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=an3Yp/aXg2diJZOgFoUzYLCOwkCqNE3IdY3mfI9VFKpIJP3IGX8hTy1LgLbESK+6XM
         zSAS+tXv5o97hM07DCLwjBJHEkA3q43hw40p+GbbvrDDXxvoGF10NzBUVDBUR0e3qrCt
         2gtySoueGeVnnseQSOCpuh2PHOoNS4lBegy3w=
Received: by 10.142.231.7 with SMTP id d7mr2156545wfh.285.1241458659062;
        Mon, 04 May 2009 10:37:39 -0700 (PDT)
Received: from linux.vnet (n2-59-35.dhcp.drexel.edu [144.118.59.35])
        by mx.google.com with ESMTPS id 30sm1648653wff.9.2009.05.04.10.37.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 May 2009 10:37:38 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118252>

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 dir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 15677da..6aae09a 100644
--- a/dir.c
+++ b/dir.c
@@ -53,7 +53,7 @@ int common_prefix(const char **pathspec)
 }
 
 /*
- * Does 'match' matches the given name?
+ * Does 'match' match the given name?
  * A match is found if
  *
  * (1) the 'match' string is leading directory of 'name', or
@@ -290,7 +290,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	dir->basebuf[baselen] = '\0';
 }
 
-/* Scan the list and let the last match determines the fate.
+/* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
 static int excluded_1(const char *pathname,
-- 
1.6.3.rc3.12.gb7937
