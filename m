From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] Makefile: mkdir $(bindir)
Date: Thu,  7 Aug 2008 18:39:15 +0200
Message-ID: <1218127155-32192-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 07 18:40:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR8XJ-0004b0-JX
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 18:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYHGQjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 12:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYHGQjX
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 12:39:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:3737 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYHGQjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 12:39:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so225470nfc.21
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hcUYDKU7r89h7wtoNJ9XsjZCvzBHOYeS3ZRA7k4WFyU=;
        b=KUk2oeLIOMMN9PC20R32o6AYM+zDy80AvxD2VNUJ7UcoqSoydo/V4UsobLY4JD2o3g
         SbzaNjW1TXQj1vE5M/JyItIzPXn5SFi94b/M8A1w37+dwFU85KPcCD490T0HaqkQp+Mw
         hfKC2o9Tua9TZ7tI+vLwMMFcNnF5fd+eL+RQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nXtbxT0Xs7TRzbTv/WgPKpMTwl0nO4ugkUnmE+c6vg2Z5A1JhFqXro4JgV5xF6sBvT
         /hxeTY2QRPs+8Oll0R81VYabC8nfqTZlBb+dTCZPnN0SrahCrruwckflwjGENa9YXJgk
         BR2RUXFgCG2k9I8OwGhBjlDl2dk/XTQlaX7tg=
Received: by 10.103.229.12 with SMTP id g12mr2420083mur.6.1218127161225;
        Thu, 07 Aug 2008 09:39:21 -0700 (PDT)
Received: from localhost ( [91.15.79.52])
        by mx.google.com with ESMTPS id e10sm10471742muf.3.2008.08.07.09.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Aug 2008 09:39:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91591>

Mkdir $(bindir) in install target.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 238d07d..2e162ce 100644
--- a/Makefile
+++ b/Makefile
@@ -29,6 +29,7 @@ $(help_out): README
 	./create-help.sh `echo $@ | sed -e 's/tg-//' -e 's/\.txt//'`
 
 install:: all
+	install -d -m 755 "$(bindir)"
 	install tg "$(bindir)"
 	install -d -m 755 "$(cmddir)"
 	install $(commands_out) "$(cmddir)"
-- 
tg: (e311d15..) t/mkdir-bindir (depends on: master)
