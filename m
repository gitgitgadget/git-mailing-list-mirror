From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/4] git-clone.txt: reword description of progress behaviour
Date: Sat, 26 Dec 2009 01:12:04 +0800
Message-ID: <1261761126-5784-3-git-send-email-rctay89@gmail.com>
References: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
 <1261761126-5784-2-git-send-email-rctay89@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 18:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NODid-0002ZR-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 18:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515AbZLYRMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 12:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756476AbZLYRMc
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 12:12:32 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34685 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbZLYRMb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 12:12:31 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so9018585ywh.4
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YsnEkvcVuJWcfiJ3oq5R+lPHdrBuetZyXd4wXHHZT1I=;
        b=SjlctmA3H2tu3lWws7zgAeq8ljD+GAkoAXzipv831gGE+lShmoH0K8uZHMiuR4tlWF
         Ato5HU6dUC5+514qwNCZjDqTLUlRBitNPq+BU1OzzUZIxFf+QFXk5AKAATywUqpiHTdY
         i0/eBXWreAWYy+/sSauJOqpJZMNZ5wzX6ie5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KaK6xpuvUR6W2mKlH4xU2heg7kD5s9h1rRR2UnxKW65xafETL9A/3jycOshOXD/WuS
         ld0V2BTnbsPHg3qZUhUayLIAJAuv+kI7X3TsTIO5PtRaH2rMr1zDWMnHUvEQ+ad2kts2
         F3qx9oyBbQG8c8xrfa7EMkR/grPfktf4Rsu18=
Received: by 10.91.51.23 with SMTP id d23mr4077650agk.94.1261761150786;
        Fri, 25 Dec 2009 09:12:30 -0800 (PST)
Received: from localhost.localdomain (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4629570gxk.2.2009.12.25.09.12.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Dec 2009 09:12:30 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1261761126-5784-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135678>

Mention progress reporting behaviour in the descriptions for -q/
--quiet and -v/--verbose options, in the style of git-pack-objects.txt.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-clone.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f298fdd..e722e6c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -96,13 +96,16 @@ objects from the source repository into a pack in the cloned repository.
 
 --quiet::
 -q::
-	Operate quietly.  This flag is also passed to the `rsync'
+	Operate quietly.  Progress is not reported to the standard
+	error stream. This flag is also passed to the `rsync'
 	command when given.
 
 --verbose::
 -v::
-	Display the progress bar, even in case the standard error is not
-	a terminal.
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
 
 --no-checkout::
 -n::
-- 
1.6.6.278.g3f5f
