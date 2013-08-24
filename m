From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 03/13] Use current output for "git repack"
Date: Sat, 24 Aug 2013 09:26:40 +0200 (CEST)
Message-ID: <1172777180.1090921.1377329200690.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:26:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8FC-00049p-OQ
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab3HXH0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:26:43 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:56420 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755188Ab3HXH0m (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:26:42 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id BA7181975F6;
	Sat, 24 Aug 2013 09:26:40 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id B2A473F83D7;
	Sat, 24 Aug 2013 09:26:40 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id AD95A35A3A2;
	Sat, 24 Aug 2013 09:26:40 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net AD95A35A3A2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329200; bh=5AhekoY+xFsb7H/EmvEF8zwB5lE2SpFRd79vAVc4Nb0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Q4P30t7uqrMQiZKlO3zWL27u5K9P5saRGP+6Sk8P4dR+uWWtRhIrVef31knLxLcRw
	 afUXv5n9LjS4/fsDthE8cRKnM9qHitvPFDinLAF2D7SfdRmGAmyMIxKl3wK31Ly9lV
	 7vMMO6MtoUjItJlfaLMSuJPRko19glxf0kgbF6pM=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:26:40 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232870>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index cb30929..b450980 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3203,14 +3203,11 @@ To put the loose objects into a pack, just run git repack:
 
 ------------------------------------------------
 $ git repack
-Generating pack...
-Done counting 6020 objects.
-Deltifying 6020 objects.
- 100% (6020/6020) done
-Writing 6020 objects.
- 100% (6020/6020) done
-Total 6020, written 6020 (delta 4070), reused 0 (delta 0)
-Pack pack-3e54ad29d5b2e05838c75df582c65257b8d08e1c created.
+Counting objects: 6020, done.
+Delta compression using up to 4 threads.
+Compressing objects: 100% (6020/6020), done.
+Writing objects: 100% (6020/6020), done.
+Total 6020 (delta 4070), reused 0 (delta 0)
 ------------------------------------------------
 
 You can then run
-- 
1.8.3.msysgit.0


---
Thomas
