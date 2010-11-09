From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] Documentation/git-pull: clarify configuration
Date: Tue,  9 Nov 2010 21:56:47 +0100
Message-ID: <1289336209-28222-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 10 03:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG0sm-0004Md-Ez
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 03:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab0KJC5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 21:57:39 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49053 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab0KJC5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 21:57:38 -0500
Received: by qyk5 with SMTP id 5so30778qyk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 18:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EWFGVEjB9B+eqUWrEGFZgQcqumRkXQHI+5HnB0eim4o=;
        b=QBifdD6EzdOnxGmUPEgxSIAnX1pxeAxKN4ZU6AitgMbRUXzvEWhBtfOVFDImQqCaA4
         xnpAdPp71YixIa0GWYgXFnhXwPvyHjDPSbP8NqU+jffMtBgHW6m/pSL6eACa2UFwawB7
         oFF7HmVBljkB2T1F7R82Aqhep/qg3QPqC1nCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z0hhIrVmKjZCHUvNoOJlsiFdhUoYYK7Up7dtACxbw+ZJ3gfEztDsoF8BA4McLt7kqK
         /gdiDsz/iCr0NvEiXxKPXu6C00H//w51xXhPx3q377ZahddZC3hINT32kQ8Xgy5hW759
         HULX4iKq/vB/qQ82MudBExCRa37U1Gu6lKzg8=
Received: by 10.229.185.1 with SMTP id cm1mr7198022qcb.29.1289357855077;
        Tue, 09 Nov 2010 18:57:35 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s28sm154827qcp.33.2010.11.09.18.57.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 18:57:34 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161124>

The sentence about 'branch.<name>.rebase' refers to the first sentence
in the paragraph. Clarify by moving it right after that sentence.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 Documentation/git-pull.txt |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c50f7dc..e9c0393 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -92,12 +92,11 @@ include::merge-options.txt[]
 :git-pull: 1
 
 --rebase::
-	Instead of a merge, perform a rebase after fetching.  If
-	there is a remote ref for the upstream branch, and this branch
-	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes. To make this the default
-	for branch `<name>`, set configuration `branch.<name>.rebase`
-	to `true`.
+	Instead of a merge, perform a rebase after fetching. To make this
+	the default for branch `<name>`, set configuration
+	`branch.<name>.rebase` to `true`. If there is a remote ref for the
+	upstream branch, and this branch was rebased since last fetched, the
+	rebase uses that information to avoid rebasing non-local changes.
 +
 [NOTE]
 This is a potentially _dangerous_ mode of operation.
-- 
1.7.3.2.167.ga361b
