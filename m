From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 3/4] rev-parse: update documentation of --flags and --no-flags options
Date: Sun, 26 Sep 2010 02:18:34 +1000
Message-ID: <1285431515-21321-4-git-send-email-jon.seymour@gmail.com>
References: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 18:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXPt-0000Zx-AC
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717Ab0IYQPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 12:15:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63719 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0IYQPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 12:15:42 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so864227pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Vd/YcaoGSb22EO4DCsYn1YskJLR6qGlm68asKPYqt24=;
        b=dw9NT9/zgvQp7Nbmb9BueIhjkiMj69SEuUu6sKQ+kQVMVjgm7HBOFWd4p0nCr3f3+j
         g0/hBYm0KSMpf9EOOgovL0G3OrXTrknYmj4T1LMCA705LNfDdO3/hqL5JjdqoA60YLBU
         Kclt+KOuOR24Nfc/iPmBSeOcrI3/LJtgeX3uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QpNWBXqXkfDmSQD6ccBLuhsMvTt/Nb7YrZ+2Q+w3ELMA5EtcGktqR+o46BVPQx7mKk
         BkBIdIbTHFQ+toIDRvOM2Q+EMqfMM+VFnSD5HtjDFgzbKGDD86w/7cmOcFI9O4O3D+e4
         5ElAvehEQJ3n4IAksuq3PsFo+g/K/thFkYiT0=
Received: by 10.114.126.3 with SMTP id y3mr5457413wac.74.1285431341782;
        Sat, 25 Sep 2010 09:15:41 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id c24sm6056766wam.7.2010.09.25.09.15.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 09:15:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.g73371.dirty
In-Reply-To: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157162>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 341ca90..f5e6637 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -49,10 +49,20 @@ OPTIONS
 	'git rev-list' command.
 
 --flags::
-	Do not output non-flag parameters.
+	Do not output non-flag parameters which are not also revisions.
+	+
+	If specified, this option causes 'git rev-parse' to stop
+	interpreting remaining arguments as options for its own
+	consumption. As such, this option should be specified
+	after all other options that 'git rev-parse' is expected
+	to interpret.
 
 --no-flags::
 	Do not output flag parameters.
+	+
+	If both `--flags` and `--no-flags` are specified, the first
+	option specified wins and the other option is treated like
+	a non-option argument.
 
 --default <arg>::
 	If there is no parameter given by the user, use `<arg>`
-- 
1.7.3.4.g73371.dirty
