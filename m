From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Help people in finding the download links
Date: Tue, 16 Oct 2007 23:58:28 +0200
Message-ID: <20071016235828.380f70a3@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 23:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhuRS-0003v7-Oi
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbXJPV66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbXJPV66
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:58:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10544 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbXJPV65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:58:57 -0400
Received: by ug-out-1314.google.com with SMTP id z38so171543ugc
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=Q1JzSh3a+11Llmjo1N53kdtU1QFzcWv1e5u+v6JhAWw=;
        b=ZZ2fy+cpDs6ACzoukX36gU/M4NUFcVnypKa+ZFREydMFT8QFk6CMuGWsvZT1WSBB17oP8Z/CQXKsFqZVXaX2g9a1auizYQjSIxiWNcyMI9zZ9zIVzHcZjjrhIhc5jEaue0Zj/10ZNmD9exNqjEK44N1NOhFMfle2H6m5oHQCMuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YtNlTpLgxR5uz0pMcknD6AHvDZOiXqNE9SIjMbKQyNMe6VtGUAaWr5c5yrC58qAc1do9nFiFegJiG2MqWW9XUx+JLO//AKIKCHqskV7fHwDhcFF5OWd21SAqtQqwxuVGO6VI5vI+aq05xcf5wdMTX1+uSQbW+LIpRi4xPTwgheA=
Received: by 10.66.252.17 with SMTP id z17mr9580518ugh.1192571935595;
        Tue, 16 Oct 2007 14:58:55 -0700 (PDT)
Received: from paolo-desktop ( [82.56.4.108])
        by mx.google.com with ESMTPS id j33sm703384ugc.2007.10.16.14.58.52
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2007 14:58:54 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61262>

I believe that with the following change it's a bit easier to visualize the table including the links to the tar.bz2 and tar.gz source packages.

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 index.html |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/index.html b/index.html
index dc5189a..b061178 100644
--- a/index.html
+++ b/index.html
@@ -54,7 +54,7 @@ Junio C Hamano.</p>
 
 
 <div style="float: right"><table class="releases">
-	<tr class="odd" align="center"><td colspan="2"><!--@DATE@-->[2007-10-03]</td></tr>
+	<tr class="odd" align="center"><td colspan="2"><b>Download GIT source package</b> <!--@DATE@-->[2007-10-03]</td></tr>
 	<tr align="center"><td colspan="2">The latest stable Git release is <b><!--@VNUM@-->v1.5.3.4</b>:</td></tr>
 	<tr align="center"><td>
 		<!--@TARLINK@--><a href="http://kernel.org/pub/software/scm/git/git-1.5.3.4.tar.bz2">tar.bz2</a>
-- 
1.5.3.4.206.g58ba4
