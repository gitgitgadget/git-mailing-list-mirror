From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] t/gitweb-lib.sh: Use tabs for indent consistently
Date: Sun, 12 Sep 2010 11:41:05 +0200
Message-ID: <1284284466-14506-3-git-send-email-jnareb@gmail.com>
References: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 12 11:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouj4M-00078b-8b
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 11:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0ILJld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 05:41:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62592 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab0ILJla (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 05:41:30 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3684689bwz.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gDNMVaLyrFLqHHNPh7DhNHIOtySZTZ/Wmt4jl/A4nAE=;
        b=extwC0b7/nezuXC8dBi7oXKGfJ7CIkfrmRiZnIADAlq/f5ldCHLiqA8vum2agUb6pb
         ErnonD40ZZO58cMv0x0QnZdwpGNI4mctWnS8hE6ycw3Py3YXF6bvYIFSDNg2QvxWA74z
         HzOqVo0IbM1bXUKvlM9h4+Q2dzWaXNxE4/TVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SrUnMFVQ760ioxTGQDZ7xtSasoth3+yF3rE2v5NAG6ewo17qkq8DGsU06w392IRWqx
         unEXraClpOanglMKfNbFZqzVcMoC8NSWiiH5KQwhWIBIxqw7ST96M1kjLXrSGEdlMDJB
         xio/wC0lJZp+JRUsbGa2LhPgNETjPzOrPv8Mo=
Received: by 10.204.60.133 with SMTP id p5mr2135291bkh.71.1284284489299;
        Sun, 12 Sep 2010 02:41:29 -0700 (PDT)
Received: from localhost.localdomain (abvl188.neoplus.adsl.tpnet.pl [83.8.209.188])
        by mx.google.com with ESMTPS id 24sm3570708bkr.19.2010.09.12.02.41.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 02:41:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156026>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Whitespace cleanup

 t/gitweb-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 8fad236..8c490c8 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -81,8 +81,8 @@ if ! test_have_prereq PERL; then
 fi
 
 perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
-    skip_all='skipping gitweb tests, perl version is too old'
-    test_done
+	skip_all='skipping gitweb tests, perl version is too old'
+	test_done
 }
 
 gitweb_init
-- 
1.7.2.1
