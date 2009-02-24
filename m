From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] sha1_file.c: fix typo
Date: Tue, 24 Feb 2009 23:59:05 +0200
Message-ID: <1235512745-26814-4-git-send-email-felipe.contreras@gmail.com>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
 <1235512745-26814-2-git-send-email-felipe.contreras@gmail.com>
 <1235512745-26814-3-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 23:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc5L1-0004k8-Mi
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 23:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760687AbZBXV7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760654AbZBXV7g
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:59:36 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:48790 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760340AbZBXV73 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:59:29 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so6205604bwz.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aV9RJwgYnEdJP6tjLyG4iJqh5fta4T2mUvXnm9iVKWM=;
        b=Z6mHwYlaVgo8vVwZGfktKhDtCXONjDpnmCQxczJJ5J1Zd373FYvG+v4SqxXUDZuEX6
         RLIJLzbk4ZVEW38rh9KHFic+3ASt19BcqMiO9Y1edGZSYm3bwUq6DQiUetbQ7VmUtO7a
         vFJR/m7FrurxKLMsmrcKS3JJzM3YSlMbPSCzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mzJxE+ePj9ahvJljwDBxpowcQOoCv8hWIyNXQ77KXjj4PLPE2c5q3fp5JE+3K94elK
         +dYcd5HNEWi4IwaNqdtR5YjuFAnttEHlk4k0kKYFOnJ7qElmwy4Czf4JzLc3fgPWSQss
         JWEdPJjT5Fz/HvDbswCFhqujon7M3mrcfGl2k=
Received: by 10.223.124.75 with SMTP id t11mr142396far.73.1235512767256;
        Tue, 24 Feb 2009 13:59:27 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id b17sm96754fka.24.2009.02.24.13.59.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 13:59:27 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235512745-26814-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111351>

it's != its

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5b6e0f6..032300c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -801,7 +801,7 @@ unsigned char* use_pack(struct packed_git *p,
 	if (p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
 
-	/* Since packfiles end in a hash of their content and its
+	/* Since packfiles end in a hash of their content and it's
 	 * pointless to ask for an offset into the middle of that
 	 * hash, and the in_window function above wouldn't match
 	 * don't allow an offset too close to the end of the file.
-- 
1.6.1.3
