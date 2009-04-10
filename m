From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] gitweb: Update link to point to git-scm.com
Date: Thu,  9 Apr 2009 21:36:58 -0700
Message-ID: <1239338218-20105-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Apr 10 06:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls8Vl-0005iX-0A
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 06:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZDJEhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 00:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbZDJEhF
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 00:37:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:3267 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZDJEhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 00:37:03 -0400
Received: by rv-out-0506.google.com with SMTP id f9so914604rvb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 21:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=c20RS084hgD4kxzqb1BfZ7aZFbEel9W/DPGEA6tZsNE=;
        b=iYVTHZtbf5G28vgs5Qt8mANA/8njKPqm5SnT7MsiQsoCqXU2nb/AhOTSAMhL1ICJTZ
         14KzEOAwT70vmpJszksTS1psvhkkKiy3ZTSFZ08/AVgysFynqcPm/1yzB5ttC5ZOPDuN
         s2EO1A0rc/kS7X1eIq++SLJhKRqnvI6IBp+Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l7tryPQoC2NWknlqk1TS1gbromxeBjg9yzjjGTkJ/DUVNYzJaWRjhMLpEtYZPZrmvX
         Xfr/L0bMWMu4eE5eTPC9a2+k7OTfaG0uevAuznHVycdokQ8rRKZYCRKBxxHhotjrK/fi
         LqIBNDF1c07xpISctIoeVddFoFhtfGU5yHK3E=
Received: by 10.141.179.5 with SMTP id g5mr1333528rvp.264.1239338222895;
        Thu, 09 Apr 2009 21:37:02 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id f21sm2815982rvb.25.2009.04.09.21.37.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 21:37:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 09 Apr 2009 21:36:58 -0700
X-Mailer: git-send-email 1.6.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116238>

git.or.cz redirects to git-scm.com nowadays. Update the link so we can
skip the redirect.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33ef190..02b7bda 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -94,7 +94,7 @@ our $favicon = "++GITWEB_FAVICON++";
 # URI and label (title) of GIT logo link
 #our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
 #our $logo_label = "git documentation";
-our $logo_url = "http://git.or.cz/";
+our $logo_url = "http://git-scm.com/";
 our $logo_label = "git homepage";
 
 # source of projects list
-- 
1.6.2.2
