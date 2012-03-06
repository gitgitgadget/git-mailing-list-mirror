From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCHv2 2/3] Documentation/git-branch: fix a typo
Date: Tue,  6 Mar 2012 10:32:44 +0100
Message-ID: <1331026365-7044-2-git-send-email-user@vincent-VirtualBox>
References: <1331023866-5658-1-git-send-email-vfr@lyx.org>
 <1331026365-7044-1-git-send-email-user@vincent-VirtualBox>
Mime-Version: 1.0
Cc: trast@inf.ethz.ch, gitster@pobox.com,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 10:34:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qmc-0007ZC-To
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 10:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758317Ab2CFJeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 04:34:01 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35114 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181Ab2CFJd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 04:33:29 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so1810023eek.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 01:33:28 -0800 (PST)
Received-SPF: pass (google.com: domain of  designates 10.213.13.72 as permitted sender) client-ip=10.213.13.72;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of  designates 10.213.13.72 as permitted sender) smtp.mail=
Received: from mr.google.com ([10.213.13.72])
        by 10.213.13.72 with SMTP id b8mr3028598eba.182.1331026408456 (num_hops = 1);
        Tue, 06 Mar 2012 01:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=hVkD9M7vNurQAnsq8vmG6CAHZMVpBVkUKxAk2UdGEZg=;
        b=MS2Fa9J7ASZ8Dgm8iebzYlJigYtEtzUjXJo6wJ3Nrx3ZEcysiRCYTZHqxhVTgP0SJC
         YJjVVRE710i7WTjmKNOGSCSj2euuAuPZ6dP1rOu9KDQ45BDoQhzvygVoL7ZNs02KcZid
         qNNauvycaELNgHDQ29Q+4XRKXXGQV/RF/W9IpkvnJPc7rSuxTzgoCtBuLFdrrUcDmvop
         XrdyS324EtwS/5KTC3viKZEXmgEJAuhvyoY5PpCE+ZA7MOJlz8JzSPUswu+FffTUwHY+
         iT43Ttxkn4iHJ8adppb7/BYYGBIQyRP+x+u1rfbHi3/sWE7FMuMQ1M/h+g5KEOfwJ+rP
         unDA==
Received: by 10.213.13.72 with SMTP id b8mr2304148eba.182.1331026408267;
        Tue, 06 Mar 2012 01:33:28 -0800 (PST)
Received: from localhost.localdomain (wlan-145-94-169-074.wlan.tudelft.nl. [145.94.169.74])
        by mx.google.com with ESMTPS id d54sm26363433eei.9.2012.03.06.01.33.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 01:33:27 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331026365-7044-1-git-send-email-user@vincent-VirtualBox>
X-Gm-Message-State: ALoCoQn8PTKEVOkUjLFBzzFUPI/OezcmkhsvNeLeI5MzovCAbRO1OlDi44fNKm7H91rvoviddRnI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192325>

From: Vincent van Ravesteijn <vfr@lyx.org>

Fix a typo by replacing 'tag' with 'branch'.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Documentation/git-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d3a923a..cfceac5 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -25,7 +25,7 @@ branches to be listed, and option `-a` shows both. This list mode is also
 activated by the `--list` option (see below).
 <pattern> restricts the output to matching branches, the pattern is a shell
 wildcard (i.e., matched using fnmatch(3)).
-Multiple patterns may be given; if any of them matches, the tag is shown.
+Multiple patterns may be given; if any of them matches, the branch is shown.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
-- 
1.7.5.4
