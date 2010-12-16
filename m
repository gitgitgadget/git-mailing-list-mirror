From: "Vasyl'" <vvavrychuk@gmail.com>
Subject: [PATCH] trace.c: mark file-local function static
Date: Fri, 17 Dec 2010 00:38:42 +0200
Message-ID: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 23:46:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMaV-00044M-Mc
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab0LPWqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:46:11 -0500
Received: from mail-bw0-f42.google.com ([209.85.214.42]:51043 "EHLO
	mail-bw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab0LPWqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:46:08 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2010 17:46:07 EST
Received: by bwz13 with SMTP id 13so246014bwz.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=9ydHvRDfqTJT4RexDavErfAj0gEXGkD4p3MqFnavWgs=;
        b=d2K0jQyharEZPucVA+k/SNE4yFwz7tKIA8gk4wnbqZUFOH8KXz/Da8ClZy4HaAwYGc
         BHa0HJE27UO9NEqv7Mf0tCjEl+O9+WSzCJvYPursAb5eFSS3bgJaElo7GgSwQ25p0jwR
         LFlReLeilsOsaUexGcvtfO2ESFnoQvB4GJrQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iQY9tJz/5Rw2BrC2jFnrfU8hWqkxZ/0G4S309m0W8ePCPo5JTHgZPCS8EdenTOClkm
         oS/oOVdxEpDk0W/Gteo0t1U7w/3IAaDnWnTJ6qhO+G08oqwx45eOfYh8U8WpooQet2Iv
         bP8KvQp5TAVFwH4PKXO1fx3Ujk4H21bA2WKnY=
Received: by 10.204.14.3 with SMTP id e3mr4700bka.202.1292539122435; Thu, 16
 Dec 2010 14:38:42 -0800 (PST)
Received: by 10.204.113.3 with HTTP; Thu, 16 Dec 2010 14:38:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163836>

Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
---
 trace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/trace.c b/trace.c
index 1e560cb..62586fa 100644
--- a/trace.c
+++ b/trace.c
@@ -25,7 +25,7 @@
 #include "cache.h"
 #include "quote.h"

-void do_nothing(size_t unused)
+static void do_nothing(size_t unused)
 {
 }

-- 
1.7.1
