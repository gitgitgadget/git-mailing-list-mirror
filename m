From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation: reword rebase summary
Date: Tue,  1 Mar 2016 14:49:58 -0800
Message-ID: <1456872598-32571-1-git-send-email-sbeller@google.com>
Cc: pdewulf@lyra-network.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 23:50:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aat7L-0005wh-6D
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 23:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbcCAWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 17:50:05 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36849 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbcCAWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 17:50:04 -0500
Received: by mail-pa0-f54.google.com with SMTP id yy13so119928106pab.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rWwFrtsSfoVG+CHUPp6xwJBVKFWsntgrwOSIiSVFSvU=;
        b=dTFVGvH52j/IrXE4IMALIFW2otuGJ2y26ybqaNwT5ZeNyhNyrkb9dhWTqZl7czP9cn
         bPz4win1nwPCDw9zu+hpI3QsV7kauYQpOpWPOtbmEtP0bg+wzEEHRwXiAqREgze1R1y3
         eVBuvSBFAb7HwPBJxt1blwXOxHUuP7NxmUV8jLcxImfgXIlEWM421utyVb5QjxAQ72U1
         QPV7WxMI5sBqmzg5I9bPuObmE7NFAUm/6vTpPyVCnRabUO8lB2oCu0hANXi/fgE1NbQm
         2sz0dJ6dW9s+DpTc8x+jueTv0km5ROTpAz7IcNmyCAFEl0jAF/2v+A54MgdAE5SmMytF
         bFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rWwFrtsSfoVG+CHUPp6xwJBVKFWsntgrwOSIiSVFSvU=;
        b=F9NyymMCkCZOcC+CDeK2AhttOAu7uNZdj0kHIHrB75KGxBxjDwssPNe0OQBcJZAXRb
         pwnQdC12izsWKgwA+PULNfPkp4D/n+UKGGAFx8ZTGwVkFe3eHTf3hC2cf/S2KnivU/Uh
         hvRU1SEsIrfEg7KQUI75Pv85W1I0lU2qwC1jkFL9Y3hB/S5cWEcJIoz6T2/CBW1dv66C
         1H+zZFELKyMGvAJoAJeF5m15CiiubGUApYXpHgibwsLZXhTvywW3arJ8PeNoBNVePD9N
         l++GxhSb94mWZvxIDTtpR/FbBUBoIo/Q9DO83YE8ErWfAQhpk7HSw3YZ3MgWBIO6e+uu
         l+bA==
X-Gm-Message-State: AD7BkJIWogVmjSxpARSkE15X8avUxJF7jbSDEiOYxTlUdy5cyfTZlYnH/j0dAnGDb1NqvrIP
X-Received: by 10.66.147.103 with SMTP id tj7mr34142155pab.72.1456872603257;
        Tue, 01 Mar 2016 14:50:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:81bf:e731:7a4d:b983])
        by smtp.gmail.com with ESMTPSA id vy6sm47895810pac.38.2016.03.01.14.50.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 14:50:02 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288074>

The wording is introduced in c3f0baaca (Documentation: sync git.txt
command list and manual page title, 2007-01-18), but rebase has evolved
since then, capture the modern usage by being more generic about the
rebase command in the summary.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Inspired by
 https://medium.freecodecamp.com/git-rebase-and-the-golden-rule-explained-70715eccc372
 (I tried to cc the author, but I am not sure if I got the right email address)
 
 Thanks,
 Stefan

 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6cca8bb..6ed610a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -3,7 +3,7 @@ git-rebase(1)
 
 NAME
 ----
-git-rebase - Forward-port local commits to the updated upstream head
+git-rebase - Reapply commits on top of another base tip
 
 SYNOPSIS
 --------
-- 
2.8.0.rc0
