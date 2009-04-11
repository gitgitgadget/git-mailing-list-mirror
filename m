From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 04/10] send-email: --smtp-server-port should take an integer
Date: Sat, 11 Apr 2009 14:08:22 -0500
Message-ID: <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:13:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsidq-0002AN-1G
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796AbZDKTLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758740AbZDKTLx
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:11:53 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:39577 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697AbZDKTLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:11:53 -0400
Received: by an-out-0708.google.com with SMTP id d14so1368700and.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SLptlAiVNcSICJS/nwiKhK5Al7dBoBE+BunmBvOCkf4=;
        b=F6jNpQbilf5sYlXEBtZNvJ4MO2qlBxiU/z828qmvY6PzUlZI3U4NRTzXsJgX9jPVNe
         yV5BG3WkcBnNhqjZMim4y2DF7Z3WJbHyG0x/US4F2eqUqxZjBxwzE9hYeJ9Jcww2Wlcv
         Zki26v+xdEye+bWkO44vBiKpuQq4qyN4OjQjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=isvnPZmU+1Rm6UpceJS/eGK7QubmjPQ4vQCS2xY+oLqUT8l/yEb2nxid9XpfcGnu2b
         +XLzt3hwX2prHjYdtvRMDxNRkKNzYehsOogoKdA4+S7Aw8aYR6nhU0mCHOHMYnRaB0wj
         je5pMcFihozMFBbcDKwTz6T/9RaxW+HyG3os8=
Received: by 10.100.153.6 with SMTP id a6mr862726ane.12.1239477111827;
        Sat, 11 Apr 2009 12:11:51 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.11.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:11:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116313>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fb3e712..b689cc7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -253,7 +253,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
-		    "smtp-server-port=s" => \$smtp_server_port,
+		    "smtp-server-port=i" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
-- 
1.6.2.2.479.g2aec
