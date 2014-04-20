From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-helpers: graduate
Date: Sun, 20 Apr 2014 16:39:29 -0500
Message-ID: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 23:50:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzdL-00080P-RK
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbaDTVtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:49:53 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:38641 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaDTVtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:49:52 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so2890187ykb.36
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8Td4T1HGBO0D9ikjKoXArdsm4GUmSxYZZ9h9yJFiVio=;
        b=Ui9rchXofGpuZS/tZQmiaSLv117+Egb8EH6lEFI1Lu7GfT3C4BUX3ldn6lsQt3u947
         VGk0/R13G7r3z1XsM0q5f3ARAX+fPSsoWz74l+C88LwUMt4TYLFNujciRwp1cnWtfAfL
         /wvNrmRnfHvpYZswyguZKx2R4jKbQ6Wpz5xS9J6ILbiNYwLvDdTo5ysTSsW0BrwWcA9b
         Zta6La2WNSx2pS3wNPiWj7mJvz2mQDkop9oqs2aNHZnzMZ0AXQAFqJt2N5F13UjP1mUi
         0ROzYHCcXBf5UL+36ch+qxqlqLwT+otp4sULyB/t1VNwFP2HezXQXTBdgiVm/jVFyrml
         xJAw==
X-Received: by 10.236.156.65 with SMTP id l41mr47567795yhk.9.1398030591495;
        Sun, 20 Apr 2014 14:49:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d68sm66000930yhc.37.2014.04.20.14.49.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 14:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246589>

There doesn't seem to be any reason to keep these remote-helpers in the contrib
area.

Felipe Contreras (2):
  remote-helpers: move out of contrib
  remote-helpers: move tests out of contrib

 .gitignore                                                 |  2 ++
 Makefile                                                   |  2 ++
 contrib/remote-helpers/Makefile                            | 14 --------------
 contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py |  0
 contrib/remote-helpers/git-remote-hg => git-remote-hg.py   |  0
 t/Makefile                                                 |  8 +++++++-
 .../remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t   |  4 ++--
 .../test-hg-bidi.sh => t/remote-helpers/hg-bidi.t          |  4 ++--
 .../test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t      |  6 +++---
 contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t |  4 ++--
 10 files changed, 20 insertions(+), 24 deletions(-)
 delete mode 100644 contrib/remote-helpers/Makefile
 rename contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py (100%)
 rename contrib/remote-helpers/git-remote-hg => git-remote-hg.py (100%)
 rename contrib/remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t (98%)
 rename contrib/remote-helpers/test-hg-bidi.sh => t/remote-helpers/hg-bidi.t (97%)
 rename contrib/remote-helpers/test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t (98%)
 rename contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t (99%)

-- 
1.9.1+fc3.9.gc73078e
