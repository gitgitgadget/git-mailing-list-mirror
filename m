From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] api-parse-options.txt: use 'func' instead of 'funct'
Date: Sat, 16 May 2009 02:24:44 -0700
Message-ID: <1242465886-31769-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 11:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5G8X-00060P-Vd
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 11:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbZEPJYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 05:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbZEPJYt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 05:24:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:12413 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbZEPJYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 05:24:48 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1274601rvb.1
        for <git@vger.kernel.org>; Sat, 16 May 2009 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=HkzFRsG12W16sgaU2S1KEHOWz/G3qAUc3JpG4jp0r7c=;
        b=AdCd/ePb0hFpIbPxqpx/CU+x0ncyz2iNn5FM7GS12LJQWhBYGsRjPm2DFtRkMAS++F
         ZQnkvkH1wJ1GlYmHn6IuxSdhrGpgbd4/A6L3BvnlyIZNPiZ/vwj5IM9ruTYBnyzBtJze
         Z6FAQx/K+oCPvIyOD5StyeNbfxyYX1aNwDScU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jwayenhd26shKPVUJ/sf+vHhVwyvmTC8IM8DIhMxF9d181dENXNIUUsBOIqNGdpYku
         pHTKsmI6g3Auhq/crZNGykY0S5EgxVzIlTfLJX4vi8IpRy42PC2vvGihM3Js56Ohseg2
         790sHYG9k3YjrCmL8gHl/NfDEJsY+qNL/oZvI=
Received: by 10.141.162.5 with SMTP id p5mr1683523rvo.193.1242465889954;
        Sat, 16 May 2009 02:24:49 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k41sm6555034rvb.17.2009.05.16.02.24.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 02:24:49 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 16 May 2009 02:24:46 -0700
X-Mailer: git-send-email 1.6.3.1.9.g95405b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119346>


Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/technical/api-parse-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index e66ca9f..e30c602 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -198,7 +198,7 @@ The function must be defined in this form:
 
 The callback mechanism is as follows:
 
-* Inside `funct`, the only interesting member of the structure
+* Inside `func`, the only interesting member of the structure
   given by `opt` is the void pointer `opt->value`.
   `\*opt->value` will be the value that is saved into `var`, if you
   use `OPT_CALLBACK()`.
-- 
1.6.3.1.9.g95405b
