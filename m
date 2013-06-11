From: Wieland Hoffmann <themineo@gmail.com>
Subject: [PATCH] pre-push.sample: Make the script executable
Date: Tue, 11 Jun 2013 14:14:56 +0200
Message-ID: <1370952896-27315-1-git-send-email-themineo@gmail.com>
Cc: Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 14:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmNUS-0001Vn-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 14:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab3FKMPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 08:15:52 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:46848 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab3FKMPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 08:15:52 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so3507620bkh.11
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cRWeB8n86xmyb8FN3Xz6XU3mK2pm/m5WLxBexMjbTKA=;
        b=E7zn+SxGKSgBOkI+5HiQm7AtdoaSwVafIw9Aa8L2eq6Kg4FXcdVs/oj2h7kP+2hpnJ
         l6GFHz2nbGrsrxG4HGuxeTPiGG3Ato2v8Xr0C+r9h0EygkDjEniWjiV/3rqhasMo5Atj
         I5qSGhta3C3Cl6O3NL35ooJWcPTpnJJ67e0Az2A2MbZQ4BVeNanGXAlw4jjEYyIKjs7c
         OAR1saRcWZl9l/6yi2cjPXhDGi87cyuDXspDQupfEbUYgpII5pprHVDjs7hAPmaLydJI
         gRIkZD88L9Q3EX5rKZWcGnlt1qSqPoHr8kHwjGrvNBVELxunJ5Wk3WIt/AJ8C3qhF1KJ
         3jUA==
X-Received: by 10.205.39.201 with SMTP id tn9mr2302989bkb.79.1370952950603;
        Tue, 11 Jun 2013 05:15:50 -0700 (PDT)
Received: from slartibartfass.fem.tu-ilmenau.de (q150.fem.tu-ilmenau.de. [141.24.46.150])
        by mx.google.com with ESMTPSA id j8sm5589031bky.17.2013.06.11.05.15.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 05:15:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227430>

githooks(5) says that "[...]the .sample files are executable by default"
which was not true.

Signed-off-by: Wieland Hoffmann <themineo@gmail.com>
---
 templates/hooks--pre-push.sample | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 templates/hooks--pre-push.sample

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
old mode 100644
new mode 100755
-- 
1.8.3
