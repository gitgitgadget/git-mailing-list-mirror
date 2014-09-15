From: Ciro Santilli <ciro.santilli@gmail.com>
Subject: Subject: [PATCH] Remove duplicate list of extensions from docs.
Date: Mon, 15 Sep 2014 13:01:46 +0200
Message-ID: <CAFXrp_cgb0GDHbNtcNqfhE4PEO+bLAWMojL-CegPCGiDJsiNcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 13:01:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTU2Z-0004SA-8a
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 13:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbaIOLBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 07:01:47 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:48457 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbaIOLBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 07:01:47 -0400
Received: by mail-pd0-f174.google.com with SMTP id v10so5957743pde.33
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=eZfAeY7eu+nb2LTI05pJjGuX9aMlbIfIu8MV23w6o4w=;
        b=ZROsP9wOeaZbENa4Pp2wEMWFR2IRUmC83vNxs2oN/qqVerKzPhHVKDopKcmKoYUMM7
         gEUNBIhxrF0T7WBfXe3LreukLeWtODLpSxNcp/LJqIneB+fq7a9v3fnS0yYs5exaf6Sk
         f88NUrMb79BCadjtNvMFqWXH6WhLtM7ujDDws2brgrywMuyApZpQPR6S7bCF5jABdEge
         4DYuAVMJ5lJbJYW9Gui5GHCEIL9w/YEV+LPmNmybOarmJ5k2QOqSFPQbMIioW891V6rx
         ufjA257EsB9iUke1vFCx7QDf4qQS/ZMOjrEoyY8n82vEqbhvT7xztdUxudDM+GZUirFo
         Tapg==
X-Received: by 10.66.124.202 with SMTP id mk10mr16322187pab.1.1410778906446;
 Mon, 15 Sep 2014 04:01:46 -0700 (PDT)
Received: by 10.70.135.34 with HTTP; Mon, 15 Sep 2014 04:01:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257049>

There is now also the "Split index" extension: probably we forgot to
update this line after it was added.

We could add the "Split index" to the line, but it would be just a
matter of time before another extension is added and this becomes
outdated again.

So let's just remove it: it is already easy to get a list of
extensions by browsing the headers in the "Extensions" section.

Signed-off-by: Ciro Santilli <ciro.santilli@gmail.com>
---
 Documentation/technical/index-format.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt
b/Documentation/technical/index-format.txt
index fe6f316..59bce02 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -23,8 +23,6 @@ Git index format
      Extensions are identified by signature. Optional extensions can
      be ignored if Git does not understand them.

-     Git currently supports cached tree and resolve undo extensions.
-
      4-byte extension signature. If the first byte is 'A'..'Z' the
      extension is optional and can be ignored.

-- 
1.8.5.2
