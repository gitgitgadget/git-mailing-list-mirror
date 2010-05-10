From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/8] merge: update comment
Date: Tue, 11 May 2010 01:17:47 +0800
Message-ID: <1273511872-4924-4-git-send-email-rctay89@gmail.com>
References: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWcy-0007lB-Ry
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab0EJRSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:22 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42956 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab0EJRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:20 -0400
Received: by mail-px0-f174.google.com with SMTP id 5so1761347pxi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fq03lgCEKGEpLc0bGqeNwmATCZIUpRmOr5JWe7xYmtc=;
        b=k79w0y2jI6Jmz/RLtsDl+wb4hNZ3wmt663Bles+NkUgR+T4sowNsaSs6tTemeFj2Ts
         ldpS+Km7qSEuuYqEVB+qlH+w561wl1W/Ia90JlwA90CS7SWMqhHtAHW9f2A1FayEOwYp
         47UL894QWf2VOGJ6TwTquPSftZTKL4fJbDHc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ByTv8GQb1Me+tBguiNJDjA6tUob19sEamrwCp6BYPcL+5gJiS0PAj9lnVtqmONdol0
         4qWllktrO/AqJVpgH/udKSUya7NOP+DiQmrdqneoQMNYKynpsRSOvZm3Bw9FdkxHWHms
         40stKZ5hHxe5qemlEYy6BkUVudhFlxwaxNel8=
Received: by 10.114.250.6 with SMTP id x6mr3406819wah.33.1273511899809;
        Mon, 10 May 2010 10:18:19 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146833>

ce9d823 (merge: do not add standard message when message is given with
-m option) changed the behaviour of the code that the comment addressed,
but the comment was not similarly updated.

Fix this.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 37d414b..c2691e8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -990,7 +990,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		/*
 		 * All the rest are the commits being merged;
 		 * prepare the standard merge summary message to
-		 * be appended to the given message.  If remote
+		 * used as the merge message.  If remote
 		 * is invalid we will die later in the common
 		 * codepath so we discard the error in this
 		 * loop.
-- 
1.7.1.189.g07419
