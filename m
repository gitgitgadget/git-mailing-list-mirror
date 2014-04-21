From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] remote-helpers: graduate
Date: Mon, 21 Apr 2014 15:37:10 -0500
Message-ID: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 22:47:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcL7t-0000kk-5R
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbaDUUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:47:38 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:36015 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbaDUUrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:47:36 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so3992892yha.16
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=U3CnZQ1Xu5wco+0Drkl2trrISOWnVpZJv3FBtyeoXH8=;
        b=eiPEujw1o5HQLPKnzbaxyLWPNfwrQJrFNUPPpy+HXPiVmKigAtkviTZFWis57qMFOX
         J5FsHI8duXBu1m2HONnj9bxCdLz6IAQw9XP8mcKXe2hOMOd6bqCrldorCtJoblp07v6R
         MdUUM240Wj2uZdzbAsFuWDT2+loK0jG3GOW7Ac30+JvxA28d6l3H1jL8iEdc8JdXQvC0
         5Akc85nVwmrE2HFTgUFuSRdpIQYpGInBEc+If/toRXjpsfEwfcswuA8Zb2itSrJq5Ls2
         IN1V7qkgsZc3uPwe18UporFOFN3wy5JbfODTHtP4wTlUF1CO586rcE9NcjG9FeO2qev6
         0T0Q==
X-Received: by 10.236.116.131 with SMTP id g3mr5363701yhh.110.1398113255766;
        Mon, 21 Apr 2014 13:47:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f62sm72942990yhq.6.2014.04.21.13.47.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 13:47:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246633>

There doesn't seem to be any reason to keep these remote-helpers in the contrib
area.


Felipe Contreras (3):
  remote-helpers: squelch python import exceptions
  remote-helpers: move out of contrib
  remote-helpers: move tests out of contrib

 .gitignore                                                 |  2 ++
 Makefile                                                   |  2 ++
 contrib/remote-helpers/Makefile                            | 14 --------------
 contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py |  0
 contrib/remote-helpers/git-remote-hg => git-remote-hg.py   |  0
 contrib/remote-helpers/test-hg.sh => t/t5810-remote-hg.sh  |  5 ++---
 .../test-hg-bidi.sh => t/t5811-remote-hg-bidi.sh           |  5 ++---
 .../test-hg-hg-git.sh => t/t5812-remote-hg-hg-git.sh       |  7 +++----
 .../remote-helpers/test-bzr.sh => t/t5820-remote-bzr.sh    |  5 ++---
 9 files changed, 13 insertions(+), 27 deletions(-)
 delete mode 100644 contrib/remote-helpers/Makefile
 rename contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py (100%)
 rename contrib/remote-helpers/git-remote-hg => git-remote-hg.py (100%)
 rename contrib/remote-helpers/test-hg.sh => t/t5810-remote-hg.sh (99%)
 rename contrib/remote-helpers/test-hg-bidi.sh => t/t5811-remote-hg-bidi.sh (97%)
 rename contrib/remote-helpers/test-hg-hg-git.sh => t/t5812-remote-hg-hg-git.sh (98%)
 rename contrib/remote-helpers/test-bzr.sh => t/t5820-remote-bzr.sh (98%)

-- 
1.9.2+fc1.1.g5c924db
