From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 08/14] gitweb: add 'remotes' action as a synonym for git_heads()
Date: Fri, 31 Aug 2007 13:18:39 +0200
Message-ID: <11885591283893-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
 <11885591201440-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4Yr-0002jD-2p
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbXHaLUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXHaLUy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:20:54 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:32010 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbXHaLUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:20:32 -0400
Received: by hu-out-0506.google.com with SMTP id 19so593548hue
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:20:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IPwpHYOa3eXL1ak+nPJRRzFIaRGCSPfl86gSD8EhWOevuyeCpmkr+LlFFig3JInU0iV8jdBIV/ATrvkqhDKKdZYOmj12TX+WEk8TlSRubAJQAL/56VzHQibD90TCBHedvyN3OFXQEw9u7iNxDWzduHEZ1WEJdIy8knUDKawKM+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UfOJEEGSxn6KxF72oBwltg8carqhF+AKSi0nqtbq/eI8ZWqW7c98cMl58E6wJVIShW+GiCe8upGxagYqECsrnHVRL9qCN7fHPt2JtAHnrBpJiGNPW6a0sVo0/dNp14tlQIxRsGcbwsP5V7N1p2Z2kA/bjDU67QAamEgaiYB1p0k=
Received: by 10.78.83.15 with SMTP id g15mr1152099hub.1188559231473;
        Fri, 31 Aug 2007 04:20:31 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id k10sm1274319nfh.2007.08.31.04.20.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:20:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <11885591201440-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57156>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dc9727e..6dfb2f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -562,6 +562,7 @@ my %actions = (
 	"commit" => \&git_commit,
 	"forks" => \&git_forks,
 	"heads" => \&git_heads,
+	"remotes" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
 	"rss" => \&git_rss,
-- 
1.5.2.5
