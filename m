From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] Fix typo.
Date: Wed, 21 Jan 2009 20:09:25 +0200
Message-ID: <1232561365-5919-2-git-send-email-felipe.contreras@gmail.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 19:11:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPhXg-000764-Iq
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 19:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbZAUSJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 13:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758958AbZAUSJf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 13:09:35 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:59858 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760082AbZAUSJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 13:09:31 -0500
Received: by fk-out-0910.google.com with SMTP id f33so305889fkf.5
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UUIw1CzWx0KCvCGAu5FE84nqIrkJP88Sf3hZ1rpRbWI=;
        b=G8D1zNxOKq8vQ3CQBMuSlJwaASvstszA45saWXJ0vCZcQMNi0MCsJZbR+QfcF+W505
         pYzvjGocr5rMwljl+hg3SoY3dERN1CXxLXyDhH5HMg+UX6DDhSgM1fpzijyvi/9AnCJS
         p0SNNXu1fHqEq4xYDraeYY2eOCWRKrqYxjhY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bc6es+8BksB7hxqi5Q38/W1q1Q64/tlgmmUm8SRVzWxnH5vT/ufbVSaU2EVJzzoXim
         +AZ4w3d0SWOiT52KADvF4M+GKTfbi9gEpCkTWS3IDSv42axHnDuLJsFFdbYjURtW5h51
         i423klT+XOYZk5c5LUpkM10ZiWvt7XLUBQ9A0=
Received: by 10.223.107.135 with SMTP id b7mr2005063fap.30.1232561370223;
        Wed, 21 Jan 2009 10:09:30 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 13sm8522725fks.27.2009.01.21.10.09.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 10:09:29 -0800 (PST)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106635>

"its pointless" is wrong, should be "it is pointless" so "it's
pointless".

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f08493f..69fef9f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -800,7 +800,7 @@ unsigned char* use_pack(struct packed_git *p,
 	if (p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
 
-	/* Since packfiles end in a hash of their content and its
+	/* Since packfiles end in a hash of their content and it's
 	 * pointless to ask for an offset into the middle of that
 	 * hash, and the in_window function above wouldn't match
 	 * don't allow an offset too close to the end of the file.
-- 
1.6.1
