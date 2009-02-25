From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] trace: Fixed a minor typo in an error message.
Date: Tue, 24 Feb 2009 20:22:20 -0500
Message-ID: <20090225012220.GA10881@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 02:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc8V8-0005FS-4J
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 02:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbZBYBW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 20:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbZBYBW0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 20:22:26 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:10253 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZBYBWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 20:22:25 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2293924qwi.37
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 17:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=kMIGvQgb8J/CdJIN6jG8f51AXbc3HCKitAHyupGyCpc=;
        b=A1TUSaoe20G/GoIpOIkGu9dKrkUWPK3MFuiQ0PbvS71uz+kYzDUeqqQ5dubHdwab10
         DmhWxJfBk3951ldVaqmtT3UKEQVOHdAz3ZkA/hm5B/C1PdJmJ7dLf0k/jwyaJUuJU4NR
         UqzlGHVkcLCPqsL5C7vETTO8YnOwU/9ekxguo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=Vm8GsvkxqqWbthNiwiGe57FLL8dwEyxiOibuvy3C05Mru9Ey8bO82KtwlEgI9CBjzQ
         p4R+mqSyItIQa8+HEU7hQbebZykgBjVOOypTZOHCykcySpFyUplWD2Utu74owKHyTYNp
         fLqQWPsOOxWSqkpupWXLSbthecLn+Nl3Lvl5g=
Received: by 10.224.67.142 with SMTP id r14mr465888qai.285.1235524943171;
        Tue, 24 Feb 2009 17:22:23 -0800 (PST)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 5sm1050986qwg.44.2009.02.24.17.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 17:22:22 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111366>


Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 trace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/trace.c b/trace.c
index 4713f91..4229ae1 100644
--- a/trace.c
+++ b/trace.c
@@ -50,7 +50,7 @@ static int get_trace_fd(int *need_close)
 		return fd;
 	}
 
-	fprintf(stderr, "What does '%s' for GIT_TRACE means ?\n", trace);
+	fprintf(stderr, "What does '%s' for GIT_TRACE mean?\n", trace);
 	fprintf(stderr, "If you want to trace into a file, "
 		"then please set GIT_TRACE to an absolute pathname "
 		"(starting with /).\n");
-- 
1.5.4.3
