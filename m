From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 3/5] Removed unused variables prev and next.
Date: Thu, 27 Nov 2008 21:10:23 +0000
Message-ID: <492F0CBF.3010202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5o9c-0004dt-JC
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbYK0VKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbYK0VKa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:10:30 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:23072 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbYK0VK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:10:27 -0500
Received: by ey-out-2122.google.com with SMTP id 6so505839eyi.37
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 13:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=zsFUsvzdicoxBTlQbpzBkWVxcmr2RdKTUElqAZ6GJjk=;
        b=jpqm/waBFQgODo2zKVni66tX1trtHzT2Clw8uBf2ywEhQT0l0CWowUkVc/Bz6OWdXy
         hMVzNqCP52cZ3+1UBU/BLP7THLaeeNjuCkbe+NmchzDETPmkAjVZi3De6vhK7kqmtKA1
         9sxVZmSlJBxtjxViDWc6TvnEhPhdfSlgaQ+lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=hxXQOkVhlBkwQfe/GXUVNEyqOh90yYqWc03qvneDgu5LQ+fGOl532Wv7YSfRr4VX6F
         gcpBewFQEsSMXwj92aYjrFXpeQnKq5TH7vk96l5AYsf9d0Y88WJ9Mh4HdKEPxWnu7XEv
         wVkVeMYNVhZUYnL/D4HvvGzzbhcMB1TR60RCY=
Received: by 10.210.16.17 with SMTP id 17mr7931384ebp.148.1227820226768;
        Thu, 27 Nov 2008 13:10:26 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id t12sm258249gvd.1.2008.11.27.13.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 13:10:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101827>



---
  git-add--interactive.perl |    4 +---
  1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b530597..0d51cb2 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -878,7 +878,7 @@ sub patch_update_file {
  	$ix = 0;

  	while (1) {
-		my ($prev, $next, $commands, $undecided, $i);
+		my ($commands, $undecided, $i);
  		$commands = 'ynad';

  		if ($num <= $ix) {
@@ -886,7 +886,6 @@ sub patch_update_file {
  		}
  		for ($i = 0; $i < $ix; $i++) {
  			if (!defined $hunk[$i]{USE}) {
-				$prev = 1;
  				$commands .= 'k';
  				last;
  			}
@@ -896,7 +895,6 @@ sub patch_update_file {
  		}
  		for ($i = $ix + 1; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
-				$next = 1;
  				$commands .= 'j';
  				last;
  			}
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
