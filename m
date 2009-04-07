From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 2/6] send-email: --smtp-server-port should take an integer
Date: Tue,  7 Apr 2009 16:25:18 -0500
Message-ID: <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 23:28:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrIpu-0002qz-MM
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760060AbZDGVZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759583AbZDGVZu
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:25:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:61365 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbZDGVZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 17:25:49 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2931737rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cL5p2zgEV/4Bi1F8HfzT46N4dNQOug3jcpT7M/kJiuI=;
        b=IsxSaNYORJHSrfGn0TTnAHh0kSCAXDfWbZkoe+gBCjr/7JvSPAAGY8ikXVYraF6kqm
         07FJIWmomITvsuhvMWzgYZf9nwvMizDoA2WKaBrB2gOJ2HBObmBNf0m/cLJ/AT8WPaRL
         MJq6oJoOnUQfXTY4e8sGyOdkAM5KJWB96z9mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bIUWNOlqdDQRcfxwzqQA1DfXdP7lN/fEKzgbFMf4eAbdmEJyx4MHSN7nl2PiodbuEd
         +ePgkooma+m9e5uElAHhpckrM1Mr8bZKLKjhMPkshzVrHCZIhNjGFnwFzi214jpYPd/X
         HnOzTpwmm05FzaZaLHf3gi31nTfHXofXphMw0=
Received: by 10.114.37.1 with SMTP id k1mr290233wak.172.1239139549063;
        Tue, 07 Apr 2009 14:25:49 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-21.mpls.qwest.net [97.116.125.21])
        by mx.google.com with ESMTPS id j39sm7381340waf.28.2009.04.07.14.25.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 14:25:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.448.g61445.dirty
In-Reply-To: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115990>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 273c8c7..63d6063 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -251,7 +251,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "delay=i" => \$delay,
 		    "smtp-server=s" => \$smtp_server,
-		    "smtp-server-port=s" => \$smtp_server_port,
+		    "smtp-server-port=i" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
-- 
1.6.2.2.448.g61445.dirty
