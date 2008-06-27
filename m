From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 14/23] Clarify Repository#resolve() documentation
Date: Sat, 28 Jun 2008 00:06:38 +0200
Message-ID: <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM94-0001Lw-5s
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759271AbYF0WIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758629AbYF0WIB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbYF0WH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:58 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=q94Fc8ex7xQWnNlqWmkxNFJEii6gq87Np7ZMUMg3Jf4=;
        b=sMS/6M93Vq9n8/cRyc05+4wEH1d/epeuHnI00ItDwxf2fFUgG6FSKm78PDhE3PBvhV
         tJOzSxnnWZsBVZhbWEYoGDWpZwyTOXFvwSadLaXQ9TKvCyny69/Y9paD081bjCTSOzCY
         asDBTTLCzCMWPH+QzSy5OV+O91BnLbsoW20Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pgT/qhZrDtqliVfSTa8ehlyKtpW+OJU54EgEzRjJWqxGpnaeGy0vxujjzZTD/2j+Y/
         C+ha9f6TPsqBJJpcjCcsimXVv2gJmzqQFuNqWLR7Tv5vEPUxS/uZqdujI28iXe/bP+HQ
         WgB5XAza17svBlnp/YJaq6VgYenk+Zj143dD4=
Received: by 10.210.142.6 with SMTP id p6mr1601095ebd.102.1214604477211;
        Fri, 27 Jun 2008 15:07:57 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b30sm2447914ika.3.2008.06.27.15.07.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86654>

Say explicitly that this method returns null when revstr can't be
resolved.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 64f93ff..2b43b2c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -524,7 +524,7 @@ public class Repository {
 	 * </ul>
 	 *
 	 * @param revstr A git object references expression
-	 * @return an ObjectId
+	 * @return an ObjectId or null if revstr can't be resolved to any ObjectId
 	 * @throws IOException on serious errors
 	 */
 	public ObjectId resolve(final String revstr) throws IOException {
-- 
1.5.5.3
