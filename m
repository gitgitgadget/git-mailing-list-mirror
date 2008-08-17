From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 10/31] Improve javadoc of Transport push()
Date: Sun, 17 Aug 2008 22:43:51 +0200
Message-ID: <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8O-0002uV-VC
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYHQUoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbYHQUox
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbYHQUow (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8gYPF/j9pLL5P/v4TNz+G+kPntPyMp1Ivful3jsqdbk=;
        b=jbgij9mPTXg7frV1UnjSJ0pSQYeyzdVquYyR2mq1DLloT0Av+rRpgws17/fLgsD/uH
         7jKdJV+Y9YDOnRBf7wnskKaMjbzZdu0ejZr5Ocv3BpkBZ+pZ0Qb43Wqeo01BKQGpFpWl
         LRrmEj1BfqqFVcfv588IUNkd2ou8F3IRkW8Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s6UGmH7M+BS96PGn8P8nvu/0ah06+YE1DRQKk4G5TKiyMDL2pG03hny3j5UrzESsOF
         wVR43Gd/E7NRkDN2P5xMIXoifTl0JWJdgbwzGMRmb0HktInNnDAVM8T7WH3GDO9IhVv6
         yjSmtsTri03r1kSZRD99960i+VDTchifAa9a0=
Received: by 10.103.246.1 with SMTP id y1mr3466650mur.53.1219005890923;
        Sun, 17 Aug 2008 13:44:50 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id g1sm2176351muf.8.2008.08.17.13.44.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:50 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92641>

Let's state explicitly that remote ref updates are modified during this
call.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/Transport.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index e986e48..8e42516 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -627,7 +627,7 @@ public abstract class Transport {
 	 *            collection to use the specifications from the RemoteConfig
 	 *            converted by {@link #findRemoteRefUpdatesFor(Collection)}. No
 	 *            more than 1 RemoteRefUpdate with the same remoteName is
-	 *            allowed.
+	 *            allowed. These objects are modified during this call.
 	 * @return information about results of remote refs updates, tracking refs
 	 *         updates and refs advertised by remote repository.
 	 * @throws NotSupportedException
-- 
1.5.6.3
