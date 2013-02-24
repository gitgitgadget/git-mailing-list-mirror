From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 07/16] git-cvsimport: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:15 -0800
Message-ID: <1361667024-49776-8-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoJ-0007hj-He
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab3BXAux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:53 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:50375 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:52 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so734338dan.37
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=eBS9eCDzxGCHxo1srkBdVj926wJ+Oztn7EgFFIFzTMM=;
        b=vTHsx9VZYSA39O5tA3XXTYyNJqsU3agg8ljVBuM/iho+Vy6KJILRq5QE1qzrKYIXtW
         69s8/2T1+VBvlBAUvAF3oDFXBqukvRzFSDs0u8jxkVNZqf9IjFNeYM6oZr8b9yODC139
         Df4RvMv/bCxANR2a1VuAKqU8++KIA7yo98bv3W4ssbBNPiMk2JvRh9yAhmKjDyzsX+B3
         fooQQ45V7sXYzLoknx92PjUWCqRBvKlxH8HGejBI16MRpojAFAn8/zjaeUTJNj+e2hLv
         DnuRU6BGwn2tKEZVkj9LctlAjRxqrxjnGffgqO9sqqJkm7I5aNr9x+l53/1pWApQOK0e
         btcg==
X-Received: by 10.66.19.229 with SMTP id i5mr11498182pae.220.1361667051611;
        Sat, 23 Feb 2013 16:50:51 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:50 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-7-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216966>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-cvsimport.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 344f120..73d367c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -38,7 +38,7 @@ sub usage(;$) {
 	my $msg = shift;
 	print(STDERR "Error: $msg\n") if $msg;
 	print STDERR <<END;
-Usage: git cvsimport     # fetch/update GIT from CVS
+usage: git cvsimport     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-- 
1.8.2.rc0.263.g20d9441
