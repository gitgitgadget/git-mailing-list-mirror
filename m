From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] gitweb: Replace wrongly added tabs with spaces
Date: Mon, 11 May 2009 19:37:28 +0200
Message-ID: <20090511173632.15152.80943.stgit@localhost.localdomain>
References: <20090511173025.15152.94215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 19:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ZRY-00055I-MR
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 19:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbZEKRh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 13:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbZEKRh3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 13:37:29 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47481 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZEKRh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 13:37:28 -0400
Received: by fxm2 with SMTP id 2so2847604fxm.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=3hSRD0JGgSm5e/oMnVsaXOZM19gTb5m4TfKkuoSf9cg=;
        b=YpOzB532wf41oq/sl3CmLcf3R0+/9e3x+TMwglRN02m46mz8XxhlTZ7QLdSh31NfIt
         8J3OTwY4d1vKoZVXpN/RuCSC7NG+yhLtAd2R4N5dLGx+31WCcGBgRXsZmNvvLr/fJjrh
         3/R0WdqIsAU7Je82O+mjo2qNZC39o1IuQpVFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=BTKvMHLa5hrgdn7BbC8pKCSslhRRaNThV82NIPChLP0/Li+0Hf2c42JQC9wWfsRSR3
         ShIgczhQZusi1ZnhVVBMJ4eqEHwEbTmUN8M6F9FOB+vSG0GwhxC2EV3oC061yLuoGpW+
         VabB5OBF2f5U9s57YSegUmWimBstA7fTWvnJs=
Received: by 10.86.70.20 with SMTP id s20mr6812399fga.1.1242063448178;
        Mon, 11 May 2009 10:37:28 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id 4sm4867225fge.28.2009.05.11.10.37.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 10:37:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BHbSFO016673;
	Mon, 11 May 2009 19:37:28 +0200
In-Reply-To: <20090511173025.15152.94215.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118813>

In two places there was hard tab character instead of space.
Fix this.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I have not searched who was responsible for that typo...

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8c51f3e..beb79ee 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3990,7 +3990,7 @@ sub fill_project_list_info {
 			    ($pname !~ /\/$/) &&
 			    (-d "$projectroot/$pname")) {
 				$pr->{'forks'} = "-d $projectroot/$pname";
-			}	else {
+			} else {
 				$pr->{'forks'} = 0;
 			}
 		}
@@ -6282,7 +6282,7 @@ XML
 	# end of feed
 	if ($format eq 'rss') {
 		print "</channel>\n</rss>\n";
-	}	elsif ($format eq 'atom') {
+	} elsif ($format eq 'atom') {
 		print "</feed>\n";
 	}
 }
