From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-gui (Win): make starting via "Git GUI Here" on
 .git/ possible
Date: Wed, 1 Apr 2009 01:55:39 +0200
Message-ID: <200904010155.39957.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Shawn O. Pearce <spearce@spearce.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Apr 01 01:57:12 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LonpP-00083D-Mf
	for gcvm-msysgit@m.gmane.org; Wed, 01 Apr 2009 01:57:11 +0200
Received: by yx-out-2122.google.com with SMTP id 22so1000730yxm.63
        for <gcvm-msysgit@m.gmane.org>; Tue, 31 Mar 2009 16:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:reply-to:to:subject:date:user-agent:cc:jabber-id
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:x-sender:x-provags-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=wp+vSKsAaRpmUOzNmG6fwW9uSIXFrMGJOptVEfMhuvU=;
        b=HoXusxBmLX3Xxv5gqkO1dj+HjeOcuvZPLyOqrqRH6s8OkgLQiMkx8cNg9SWJRMJi/J
         jjPMnj/xUGFMHTni4V71/XI818Y5A13NsSBPQ1QShJUvjDkdjaXxCJKV4DbBF3Y6Ex2N
         kXMi4VwXqYCnKix9aL8mtRobXnCUSUbNab3qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :reply-to:to:subject:date:user-agent:cc:jabber-id:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:x-provags-id:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=7Ar5XznDZCD7vc0d486CqQ9Rhn5j7e5F7P4Ay7ntCgnOtAyWZNywcMXtq5Tt0ZcApL
         nliFtvZEo3HMgYODxhb55QkDXO5CAcEBvLGLBdDiMokhRl9y1nKFWO4gJeotaYnMP1OV
         rpP0u50MsybXA9MdZZiIZjWCEJ9AsNuc+6fx0=
Received: by 10.100.138.10 with SMTP id l10mr97165and.13.1238543736137;
        Tue, 31 Mar 2009 16:55:36 -0700 (PDT)
Received: by 10.177.145.19 with SMTP id x19gr4583yqn.0;
	Tue, 31 Mar 2009 16:55:36 -0700 (PDT)
X-Sender: markus.heidelberg@web.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.92.14 with SMTP id p14mr594372agb.29.1238543735273; Tue, 31 Mar 2009 16:55:35 -0700 (PDT)
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221]) by gmr-mx.google.com with ESMTP id 14si702944gxk.7.2009.03.31.16.55.35; Tue, 31 Mar 2009 16:55:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.221 as permitted sender) client-ip=217.72.192.221;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.221 as permitted sender) smtp.mail=markus.heidelberg@web.de
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215]) by fmmailgate01.web.de (Postfix) with ESMTP id BB13DFF3C3CB; Wed,  1 Apr 2009 01:55:34 +0200 (CEST)
Received: from [89.59.106.150] (helo=.) by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #277) id 1Lonnq-0001cb-00; Wed, 01 Apr 2009 01:55:34 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+BU1vtnRuk3FGoqhHEg7DH1vLzqzX+UG5crP89 JqAGy4HHKR8w9/ErOHOD1TFkaxIPdxuD/DcMc/ikS5v4r6R5HH js9GpYLm8AH32uBrR++g==
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115331>


This works around git-gui's error message

    Cannot use funny .git directory: .

when started from the .git/ directory, which is useful in repositories
without any directories for the right click.

Now git-gui can be started via Windows Explorer shell extension (Git GUI
Here) from the .git/ directory.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 windows/git-gui.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/windows/git-gui.sh b/windows/git-gui.sh
index 53c3a94..66bbb2f 100644
--- a/windows/git-gui.sh
+++ b/windows/git-gui.sh
@@ -3,7 +3,12 @@
 exec wish "$0" -- "$@"
 
 if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
-	cd [lindex $argv 1]
+	set workdir [lindex $argv 1]
+	cd $workdir
+	if {[lindex [file split $workdir] end] eq {.git}} {
+		# Workaround for Explorer right click "Git GUI Here" on .git/
+		cd ..
+	}
 	set argv [lrange $argv 2 end]
 	incr argc -2
 }
-- 
1.6.2.1.428.g41b20c
