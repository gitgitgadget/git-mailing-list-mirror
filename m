From: Benjamin Bergman <ben@benbergman.ca>
Subject: [PATCH] Documentation/git-checkout: Move `--detach` flag in synopsis
 to correct command
Date: Tue, 10 Sep 2013 21:37:54 -0500
Message-ID: <CA+DWcQah8Uy41oZXGhP-i+H7JAU_bOWPVt3i79fDnW==FeTJGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 04:38:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJaK5-0004bX-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 04:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3IKCiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 22:38:25 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:53176 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab3IKCiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 22:38:25 -0400
Received: by mail-vc0-f179.google.com with SMTP id ht10so5577898vcb.38
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 19:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=fc1GkJbNBUb2R2dnbSokU+QC0ObJKQy9WFkhdbMPIG4=;
        b=DAKtgjb7ANuXpEWA4D1GDoCZp3WZIs2DpSwisxY7CTEBnRjW5HqgldV224YOw3dSJW
         wyz03VEC368KQ+ap4FZyp1WDsHT5VAAMWJYfOKie97/T1Njd+XtnZz5cduDaRRM6aAcN
         CAtXjZNuT9JDIN3lnK8X0l0Op2c4S8Dz8LaTJ/P5BhcPx1cum8i/hvOiVGXf1ziGoIW8
         5u/JpLRUnM17xuF8+cyIlC5Oppo+4f1vbZKehK99fIxwLGHg2xTSXD8jfdhiXdqe7Ish
         7V68QRl7TfIgfX5anhUHQxegIBe/fRDO5Zpx0CATqEMY1JrXuRejy/N5wQeNKTsk6dvl
         lPlw==
X-Gm-Message-State: ALoCoQkAa/2IBnCZlHzJ/62sD49QTVIPPLOCscTuxs88XcLXGSp7bdNdf/jrhGT0pMlHxYWf1JlA
X-Received: by 10.58.208.130 with SMTP id me2mr25908950vec.13.1378867104237;
 Tue, 10 Sep 2013 19:38:24 -0700 (PDT)
Received: by 10.220.156.208 with HTTP; Tue, 10 Sep 2013 19:37:54 -0700 (PDT)
X-Originating-IP: [50.72.201.196]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234519>

>From a33659535cb0eac92bed42d5e494dbb8f5d9ab20 Mon Sep 17 00:00:00 2001
From: Benjamin Bergman <ben@benbergman.ca>
Date: Tue, 10 Sep 2013 16:00:29 -0500
Subject: [PATCH] Documentation/git-checkout: Move `--detach` flag in synopsis
 to correct command

Detailed description of `--detach` states that it is default for
`<commit>` but needs to be specified for `<branch>`. The old man page
synopsis showed the reverse.
---
 Documentation/git-checkout.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca118ac..dee95e8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,8 +8,8 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
+'git checkout' [-q] [-f] [-m] [--detach] [<branch>]
+'git checkout' [-q] [-f] [-m] [<commit>]
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>]
[<tree-ish>] [--] <paths>...
 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
-- 
1.8.3.4
