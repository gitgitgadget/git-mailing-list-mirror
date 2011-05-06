From: =?UTF-8?q?Jo=C3=A3o=20Britto?= <jabcalves@gmail.com>
Subject: [PATCH] Remove duplicated "is a"
Date: Fri,  6 May 2011 01:16:17 -0300
Message-ID: <1304655377-57638-1-git-send-email-jabcalves@gmail.com>
References: <1304614634-46181-1-git-send-email-jabcalves@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jo=C3=A3o=20Britto?= <jabcalves@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 06:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QICTq-0004Nv-A7
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 06:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab1EFERZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 00:17:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39178 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1EFERY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 00:17:24 -0400
Received: by gyd10 with SMTP id 10so1022913gyd.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 21:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=lVii/HJncvyiqveRvIbj17aqD63xuRtm3iF9WyeZ7iM=;
        b=U1ateKZCP3rLAZPizImwLukg9wv0W0/+VCi8ckHGsXjsqSu0c2GqCfhJUrQ6903PFK
         xFhAmglinejBBuv/FKaeYDncskTRqNxYHR6DRgTx6sfteKWqGCDwqMmqixE5OTqSIxiP
         lJ/OwaFyfOl1ythEwRXL7wMUVeClAUcYdoi4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AySCVRa2YG2tTMRuBryM3ZhceVifBfu8R/q/S1vJhT/Mvr/R9Sk851K5U8m1N/zKNj
         kU31pE6D+u99hOgKkR1IHizmuVQj/oE8j4mwKMxYqFhX2k7HJLdtLv+wWGlDl0knNxfi
         QeRnZVCXyrBWA9XRAlW3uLTVJWp2/hIcu7nEg=
Received: by 10.236.191.229 with SMTP id g65mr4044066yhn.335.1304655443469;
        Thu, 05 May 2011 21:17:23 -0700 (PDT)
Received: from localhost.localdomain ([189.121.226.214])
        by mx.google.com with ESMTPS id 44sm1328187yhl.53.2011.05.05.21.17.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 21:17:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1304614634-46181-1-git-send-email-jabcalves@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172935>

Signed-off-by: Jo=C3=A3o Britto <jabcalves@gmail.com>
---
 Documentation/diff-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 34f0145..23b605f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -243,7 +243,7 @@ ifdef::git-log[]
 	For following files across renames while traversing history, see
 	`--follow`.
 endif::git-log[]
-	If `n` is specified, it is a is a threshold on the similarity
+	If `n` is specified, it is a threshold on the similarity
 	index (i.e. amount of addition/deletions compared to the
 	file's size). For example, `-M90%` means git should consider a
 	delete/add pair to be a rename if more than 90% of the file
--=20
1.7.5.1
