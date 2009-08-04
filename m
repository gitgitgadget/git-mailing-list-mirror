From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH] send-email: remove debug trace
Date: Tue,  4 Aug 2009 21:57:34 +0000
Message-ID: <1249423054-3416-1-git-send-email-kusmabite@gmail.com>
Cc: madcoder@debian.org, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 23:59:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYS27-0008Jo-HP
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088AbZHDV5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933085AbZHDV5d
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:57:33 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:48924 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932893AbZHDV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:57:32 -0400
Received: by yxe5 with SMTP id 5so3388327yxe.33
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ln0BUEkyAtfdAlImp6idh2KiZkx91LzDL+JS6fkAmDA=;
        b=aK9kF7pm/iZqjsQYendzn57iv2zfhFqoI3vdW6auy6z0QuFTP311CHX/oy/+l9ikBH
         qucSceL4LRXIllueGIaMv5vVxxpnzYdTm98ata6F0EsPIpLQpoRfvCCar6Q41KSo2kXr
         ajtxmG8JcvyQl58Nl9Z5iPYh62fezv7Xrgt8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mk1yBfGjggMMTdKwLHFOE50Yuu+QhE1VEbSIWGEjKuG8v210BFQ+82bcMRD6PVR1Xz
         MzY962xFAqXWE5s+N7O3hissGbzkQME2LA3s+RsvH4vtv/BadOUPWLy6suJpE0/4tG/b
         Mk9bFCPGKrVSd2XvVbvgLFRwEHbsvMrb/Mo5E=
Received: by 10.90.89.18 with SMTP id m18mr1683964agb.64.1249423052686;
        Tue, 04 Aug 2009 14:57:32 -0700 (PDT)
Received: from localhost (bs1.mccno.com [208.114.192.20])
        by mx.google.com with ESMTPS id 1sm14476262agb.8.2009.08.04.14.57.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 14:57:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124821>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

This isn't really a big deal, the print just annoyed me slightly.

 git-send-email.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d508f83..0700d80 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -450,7 +450,6 @@ sub check_file_rev_conflict($) {
 	try {
 		$repo->command('rev-parse', '--verify', '--quiet', $f);
 		if (defined($format_patch)) {
-			print "foo\n";
 			return $format_patch;
 		}
 		die(<<EOF);
-- 
1.6.4
