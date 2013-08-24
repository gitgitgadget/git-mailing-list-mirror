From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 07/13] Improve description in "How to merge"
Date: Sat, 24 Aug 2013 09:30:28 +0200 (CEST)
Message-ID: <8609038.1091034.1377329428557.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:30:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8Ir-0001xG-Ln
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262Ab3HXHaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:30:30 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:60157 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab3HXHa3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:30:29 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 953FAE3B95;
	Sat, 24 Aug 2013 09:30:28 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 8CAB811202B;
	Sat, 24 Aug 2013 09:30:28 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 8934CA9CFA;
	Sat, 24 Aug 2013 09:30:28 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 8934CA9CFA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329428; bh=O32BYJ2A63rlV4gl4as0hGByy0/jMUn/kaIKBgVv6sM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=qEGjgjIPzVhnxw4VsbGDulGmF5Xxa+cPWTnUk8nuCtbZxqj4Y6AvuLsdBTvzUtFiv
	 hO4l0p2bnAFyicoaJ2yOwYvgcZtBCVYWsHWA12hwotGXQ2rGrMGbP8VznjB0mIefzy
	 uzPx5U/afhsDx9/QQOrTvHrZ15Gee881W/y7BjqU=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:30:28 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232874>


Describe the conflict resolution in terms of the
commands the user is supposed to use.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ccbddc7..0656191 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1251,10 +1251,8 @@ Automatic merge failed; fix conflicts and then commit the result.
 -------------------------------------------------
 
 Conflict markers are left in the problematic files, and after
-you resolve the conflicts manually, you can update the index
-with the contents and run Git commit, as you normally would when
-creating a new file.
-
+you have resolved the conflicts manually, you can `git add` the
+new contents and do a `git commit` in the end.
 If you examine the resulting commit using gitk, you will see that it
 has two parents, one pointing to the top of the current branch, and
 one to the top of the other branch.
-- 
1.8.3.msysgit.0


---
Thomas
