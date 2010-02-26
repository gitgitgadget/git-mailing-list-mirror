From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 1/4] grep docs: pluralize "Example" section
Date: Thu, 25 Feb 2010 22:40:10 -0500
Message-ID: <1267155613-22134-2-git-send-email-lodatom@gmail.com>
References: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 04:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkr0e-0000l8-Jx
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935117Ab0BZDg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:36:56 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:3872 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935056Ab0BZDgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:36:55 -0500
Received: by qw-out-2122.google.com with SMTP id 8so171545qwh.37
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3mHvhE0CsQ0IEufh9fTZbt2zuu+m9fOx2GuNflET2PM=;
        b=n+5CHDRJOVoSxh566abtN/m5m2wniiBXfGZ6IioyN8vdDNSgj93bUWBjMoYw0WpjFO
         zmB/raP+Ls0/nKoxB+99E5EQ5w18i2bQTYHJTZIQ8t/fqcg4cvx/vb8nSw8/CiSZN660
         Y0UQC73M5coOMgBHtVxGzk9ew+fVXhcjmC7rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H6O8lG7uKpvATyeRtt8uyxMOaaoXhrXhXd6of23WxPt0QqKf2O3rvJYa2GisNqi5VL
         d0FOQ5qUgS7uCPcrp12RBdjAXsX2z7Ff9GCx/b8svF5jUtKIxkE+dpEQTougRAgxFhjo
         r39RoK/PFPJEAtUtqTzhbTYCdZ1x97/wNZ+5I=
Received: by 10.229.222.143 with SMTP id ig15mr147900qcb.51.1267155414109;
        Thu, 25 Feb 2010 19:36:54 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1593622qyk.6.2010.02.25.19.36.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 19:36:53 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141094>

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c44724d..ae663b0 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -174,8 +174,8 @@ OPTIONS
 	If given, limit the search to paths matching at least one pattern.
 	Both leading paths match and glob(7) patterns are supported.
 
-Example
--------
+Examples
+--------
 
 git grep 'time_t' -- '*.[ch]'::
 	Looks for `time_t` in all tracked .c and .h files in the working
-- 
1.7.0
