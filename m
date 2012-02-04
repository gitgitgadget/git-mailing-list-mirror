From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] blame: fix output with mailmap
Date: Sat,  4 Feb 2012 21:50:21 +0200
Message-ID: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 20:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtleN-0005Zw-16
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 20:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438Ab2BDTvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 14:51:24 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34029 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754319Ab2BDTvX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 14:51:23 -0500
Received: by lagu2 with SMTP id u2so2380696lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FiyHxPNtVDr8RzZhiIfAqkSxxQdG8lvZh7zx0+9eDxk=;
        b=prFXEot2/KiF9g+GDw0UQfYuu8RttFUeTXqco1zicidtstH3r9qWP9dTDtU7G6Pkjl
         GHvhbVkvehBSGg5c21sMVUP93f9p3QxkOu0L+2Z9s/KHnOUkmzQFauDKhu6dU023Ktxo
         KnOsF1ur5aUIrqzVTKZO72JtLeBQnbdv7Wpu4=
Received: by 10.152.132.133 with SMTP id ou5mr6240274lab.46.1328385081892;
        Sat, 04 Feb 2012 11:51:21 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id c10sm4929091lbh.11.2012.02.04.11.51.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 11:51:21 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.g97f7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189896>

The fix, and the tests.

Felipe Contreras (3):
  blame: fix email output with mailmap
  t: mailmap: add 'git blame -e' tests
  t: mailmap: add simple name translation test

 builtin/blame.c    |    9 ++++++---
 t/t4203-mailmap.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

-- 
1.7.9.1.g97f7d
