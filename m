From: jaysoffian+git@gmail.com
Subject: [PATCH] git-web--browse: fix misplaced quote in init_browser_path()
Date: Mon, 11 Feb 2008 10:57:34 -0500
Message-ID: <1202745454-10038-1-git-send-email-jaysoffian+git@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 16:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOb3g-0002XC-GB
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 16:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902AbYBKP5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 10:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757882AbYBKP5n
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 10:57:43 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:33002 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757832AbYBKP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 10:57:41 -0500
Received: by an-out-0708.google.com with SMTP id d31so1153650and.103
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 07:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:sender;
        bh=yjthP1OqNaBnsOCu2DVh7uPtA2ALqbP8tgrs5xIKYB4=;
        b=gflI9X2aGh4M/vLWyK9mSu5yOD8MSu7h0ubxJSJXk+TE7RMuLhRtnEWXpg1t4Df4q2MlqY27ApboNhYm2AQDARxCnjv6/ypgHF6O/UGkBKPzlCZGZcbq6HfKncn6exiF7NctFNY+xVj+O4RnJVLs1H5XVHeqyv0C3uCLR65P7Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=kv8symICj8v7BM9mjTArs7HlDR301vyIuxv6c6Ny9ygoPWUnIQDhQwGxoXVZzoXFqa19XLHREmycOYMksByMsUZAGKAwwwjDJae2conCYRrKNewThy5WtPUMp5EuecJO8JqCLX1X4LnBAC9FVpBd4eY7oMeX+BUd8dUYwh1+NZw=
Received: by 10.100.153.6 with SMTP id a6mr290720ane.18.1202745458443;
        Mon, 11 Feb 2008 07:57:38 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c30sm32415009ana.11.2008.02.11.07.57.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 07:57:37 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1230.gf7885
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73544>

git "config browser.$1.path" should be git config "browser.$1.path"

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-web--browse.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 5179709..282dd41 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -34,7 +34,7 @@ valid_tool() {
 }
 
 init_browser_path() {
-	browser_path=$(git "config browser.$1.path")
+	browser_path=$(git config "browser.$1.path")
 	test -z "$browser_path" && browser_path="$1"
 }
 
-- 
1.5.4.1.1230.gf7885
