From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/8] remote-helper: fixes
Date: Tue, 29 Apr 2014 04:04:27 -0500
Message-ID: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48E-00088l-I7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbaD2JPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:12 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:57256 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbaD2JPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:10 -0400
Received: by mail-oa0-f51.google.com with SMTP id l6so868397oag.38
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iCttzdCYWVYmnMO73UMm3z2FCbayx0+OUq9MeskSNk0=;
        b=C/UIeVDMIqM5grIfmj6tdVCsbjNnOzXkmKHpLhMWYrrI9W6mAxGHrhVEd9YNPg9PJs
         p69a02is2oL3O7hlLQ92kOx3GEWfC2zHuKPmnsEx0gxc0Eku86YoWh4tT252TGLcfW9N
         XWq4+rb2PyLJurc0aYMMm9OdGzlCJEIQn2WyBNh8RBCB0QQQE3jCaInh7LxfyFrL+yGW
         Zvh5PK4Dzg0YK84iji6hWy4k70Jql/ed+JbQIEkgF8PSim6lvM7JegRLoQwAdmaWL55/
         +MyRtkJ9boE4hGogTWXl2LJxd2K4VeGk6++DFaUYzcg+JWTcBvOmH1h1HJRYRqyf7sOd
         xVZA==
X-Received: by 10.60.144.200 with SMTP id so8mr26531060oeb.31.1398762910308;
        Tue, 29 Apr 2014 02:15:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w4sm1418569oem.8.2014.04.29.02.15.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247546>

A few trivial updates, a few important fixes.


Daniel Liew (1):
  git-remote-hg: use internal clone's hgrc

Felipe Contreras (7):
  remote-hg: fix parsing of custom committer
  remote-hg: update to 'public' phase when pushing
  remote-{hg,bzr}: store marks only on success
  remote-hg: properly detect missing contexts
  t: remote-hg: split into setup test
  remote-hg: make sure we omit multiple heads
  remote-hg: trivial cleanups

 git-remote-bzr.py    |  8 +++---
 git-remote-hg.py     | 72 ++++++++++++++++++++++++++++++++++++++++++----------
 t/t5810-remote-hg.sh | 65 +++++++----------------------------------------
 3 files changed, 70 insertions(+), 75 deletions(-)

-- 
1.9.2+fc1.3.gade8541
