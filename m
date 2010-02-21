From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/7] http-push: remove useless condition
Date: Sun, 21 Feb 2010 11:08:24 +0800
Message-ID: <1266721708-1060-4-git-send-email-rctay89@gmail.com>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:37:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2Bp-0004jO-MW
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126Ab0BUDIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:08:50 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:49688 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059Ab0BUDIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:48 -0500
Received: by qw-out-2122.google.com with SMTP id 8so262931qwh.37
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=br6rw2IYeErgoB6T3T7JXEHGSIsiM3UDP8rgEkvPqXE=;
        b=Bc4D0rNDaDf7dQ4GgOZNQ7GqNj3oG0w+cKwerr/+2Afi6HhAWcGImP1/by3Or9v1q5
         s+YbPeuMf9hZoJeFd15kgeiMQ6AAR6kpm25wdYxmFmjZbIWnYQvHOZv+Ief5uWb/Annj
         j167BCe0bixg9b5CsN9cw6Vs+e//81+yIfYW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PYuAFF5Ade3+AZS5tbsz7jwj7LCKbtSNIVyNQM6GNq8YxvU3Thlnmsyfb2wX+W21Wb
         7mCjTsxCcu9NwiiAaL1LCxpuijEFosH9LmrW7GKO5XuDKGcekBSyEjMCuXkQMynXTHGO
         RwG99cnnCKnUjvf3yVbp2d5h4FysBh4691TF0=
Received: by 10.224.0.134 with SMTP id 6mr4365281qab.80.1266721728256;
        Sat, 20 Feb 2010 19:08:48 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:47 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140582>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 432b20f..415b1ab 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1965,7 +1965,7 @@ int main(int argc, char **argv)
 		}
 
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
-			if (push_verbosely || 1)
+			if (push_verbosely)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			if (helper_status)
 				printf("ok %s up to date\n", ref->name);
-- 
1.7.0.26.gbfa16
