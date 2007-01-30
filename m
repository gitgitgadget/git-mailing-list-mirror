From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] blameview: Fix a typo.
Date: Tue, 30 Jan 2007 13:26:48 +0530
Message-ID: <45befa4d.6d3e3b9c.5d1f.569e@mx.google.com>
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 08:57:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnrq-0008LJ-RG
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965434AbXA3H5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965436AbXA3H5F
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:57:05 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:22180 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965434AbXA3H5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:57:04 -0500
Received: by py-out-1112.google.com with SMTP id a29so949562pyi
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:57:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:x-mailer:message-id;
        b=rcPI6M3ToNlRbuiuM9EX0Mz++hDdewK694+CZxwyVZ9pJ/mmKjZPXFCatuYmlypMtXTtCKSj8wrEEKNm7duwEWFmhnVp5oeEiKtLFZ7FzHomzH++qIkRH9UAzjgtdddKxwy92cip7kxz2w0VW+zH3YI8ule+xoZ/V9JjcIBAT6A=
Received: by 10.35.57.5 with SMTP id j5mr14607817pyk.1170143823583;
        Mon, 29 Jan 2007 23:57:03 -0800 (PST)
Received: from localhost ( [59.92.165.143])
        by mx.google.com with ESMTP id w29sm5981604pyg.2007.01.29.23.56.57;
        Mon, 29 Jan 2007 23:57:01 -0800 (PST)
X-Mailer: git-send-email 1.5.0.rc2.75.gdbaa0-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38129>

We should use lno to print the line number

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/blameview/blameview.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blameview.perl
index a55f799..e8bcb1b 100755
--- a/contrib/blameview/blameview.perl
+++ b/contrib/blameview/blameview.perl
@@ -62,7 +62,7 @@ sub flush_blame_line {
 	for(my $i = 0; $i < $cnt; $i++) {
 		@{$fileview->{data}->[$lno+$i-1]}[0,1,2] =
 		    (substr($commit, 0, 8), $info,
-		     $filename . ':' . ($s_lno+$i));
+		     $filename . ':' . ($lno+$i));
 	}
 }
 
-- 
1.5.0.rc2.75.gdbaa0-dirty
