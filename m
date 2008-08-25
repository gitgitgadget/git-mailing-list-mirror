From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Add a reference to gitk localbranc remote/branch in
 gittutorial
Date: Mon, 25 Aug 2008 21:50:23 +0200
Message-ID: <20080825215023.11822a20@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 25 21:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXi6B-0007K6-9S
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 21:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbYHYTub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 15:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbYHYTub
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 15:50:31 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:9176 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbYHYTua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 15:50:30 -0400
Received: by yw-out-2324.google.com with SMTP id 9so130568ywe.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 12:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2SeBJABzOCX4FZemaALcptKoSlsHrJWw9tYr3Yz7yIo=;
        b=VwgvralzPoR77BiC7TRmoNSkKs96qz7SQLQCd5CE57or673PQJwDUJtnNDqzNHJ/sH
         HHn1VkDIoh5+DJxUGTctbfsYUMOW1nKEgp5M5LdSV51QwJby5FcjJkCFwt5FBNzZb4c2
         MazrLXeApc1r6Ey4GcnI+U8ZdPlEf4hNQWEs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=GuvCvV52fGAFGX0jc/pe3HPV9HrFoliRFuC8v/YRkNmc/0FH2t1H5hI98+t704GSJ5
         ukFoZFhM3M7sVZkJbRubgecw8jKOWl3rcseZhKGS3nS/DNaOGHw7HexsPOcXejpDpkA1
         lpYdck6Zzs1/qOnTgmRkUFK41giM4vTf3ssjY=
Received: by 10.103.18.19 with SMTP id v19mr3134602mui.123.1219693828094;
        Mon, 25 Aug 2008 12:50:28 -0700 (PDT)
Received: from paolo-desktop ( [87.13.81.169])
        by mx.google.com with ESMTPS id w5sm28210288mue.10.2008.08.25.12.50.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 12:50:26 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93663>

Hi all,
I think it's worth to mention that a user can issue the command:

	$gitk local remote/branch

to browse what he/she just fetched from the remote branch.

Thanks to a few guys on the #git channel!


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 Documentation/gittutorial.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 48d1454..1407973 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -326,6 +326,12 @@ alice$ git log -p ..FETCH_HEAD
 
 This operation is safe even if Alice has uncommitted local changes.
 
+Alice can also use gitk to browse that Bob did:
+
+------------------------------------------------
+alice$ gitk master origin/master
+------------------------------------------------
+
 After inspecting what Bob did, if there is nothing urgent, Alice may
 decide to continue working without pulling from Bob.  If Bob's history
 does have something Alice would immediately need, Alice may choose to
-- 
1.6.0.2.g2ebc0.dirty
