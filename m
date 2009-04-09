From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Update delta compression message to be less misleading
Date: Thu,  9 Apr 2009 10:45:39 -0500
Message-ID: <1239291939-613-1-git-send-email-dpmcgee@gmail.com>
References: <7v4owzr72g.fsf@gitster.siamese.dyndns.org>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 17:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrwUA-0002Sj-Lw
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 17:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935668AbZDIPpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 11:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935533AbZDIPpp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 11:45:45 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:46542 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935661AbZDIPpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 11:45:43 -0400
Received: by qyk16 with SMTP id 16so1411999qyk.33
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l4uviIRTyBWWwDXCOe5cwa2oXbVaEPNPyfYuPWjmbJ4=;
        b=I5CuyKY9oUGEE0yAqsMJiEmAlLeN83RW11g12ryFsWtu/wqeBh8196iO5Ba0lUMyxI
         3orvXEuDmQCwAepAIHV5ctosj8KnmuxatfMaqHfpAuvF8u88kEdeQpEaI7Mzh1DC7g9r
         3hizjopV3fBdsP4HdMnBuemdYWC+0wD9Noe6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V9swrIojV+I0nmrVaVyNLIqLLGsYfwqD3LeW2iM2jd8Ffq/BlUc95rUXk1N5fbyK/q
         d4DhFY9MjsDZHXV9sXjwCrqbObRIlSAJ60n17HNunizkaIV5hAxRYw8dlQaJdNpqPNZX
         rTtZnZtOSZEJrWvgw9vq12UBAQrLfb/4VJhTI=
Received: by 10.224.73.205 with SMTP id r13mr2973359qaj.315.1239291942277;
        Thu, 09 Apr 2009 08:45:42 -0700 (PDT)
Received: from localhost (adsl-76-193-181-72.dsl.chcgil.sbcglobal.net [76.193.181.72])
        by mx.google.com with ESMTPS id 4sm911016yxq.43.2009.04.09.08.45.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 08:45:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2
In-Reply-To: <7v4owzr72g.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116177>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin-pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9fc3b35..99181fd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1612,7 +1612,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		return;
 	}
 	if (progress > pack_to_stdout)
-		fprintf(stderr, "Delta compression using %d threads.\n",
+		fprintf(stderr, "Delta compression using up to %d threads.\n",
 				delta_search_threads);
 
 	/* Partition the work amongst work threads. */
-- 
1.6.2.2
