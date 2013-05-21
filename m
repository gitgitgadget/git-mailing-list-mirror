From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Tue, 21 May 2013 23:53:17 +0530
Message-ID: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 21 20:25:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UerFG-0008Lm-IS
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab3EUSZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:25:04 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44262 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab3EUSZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:25:03 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so886764pbc.12
        for <git@vger.kernel.org>; Tue, 21 May 2013 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=VR3LzfZz3o+kI8RDsBwrTtXhfME7GhC7YbsI17KVadk=;
        b=QOJI6LFwUiEHj8QzdIc/yqggzWaNM0gssOnENr88BoweH0hUS25p5oZlSagMeEYxNI
         lmLNhi899tklhLz2UYzVxst3BrgayOIHTGdgPp6qNf+kuTdrUbEJ1ipkDCCUx54wtTMh
         dY9DRJjgTdCWQbJmSCfvtCfoi16e6WMaX7P4R/oRwm4z6UbMwpa+yYxENn0POhRbL4As
         ywN34WDBSRS9S1l+PL2UebAfFC6K79CYTaNmKCZPGq7Ta5v8oFoLaY1qCgh8jTnpmBiv
         7grwua9H9iH8KyO6KvCmcUN5jfl/YRT4Qh9seQNm1OQalVjwFSd6SXhUZDX1dIFGv8SB
         /X+g==
X-Received: by 10.68.26.7 with SMTP id h7mr3977889pbg.187.1369160702307;
        Tue, 21 May 2013 11:25:02 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.100])
        by mx.google.com with ESMTPSA id l4sm3680889pbo.6.2013.05.21.11.25.00
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 11:25:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.7.gc1ff30b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225060>

There's still a lot to think about.

[3/3] is the big itch: [1/2] and [2/2] are just setup patches.

Ramkumar Ramachandra (3):
  push: factor out the detached HEAD error message
  push: fail early with detached HEAD and current
  push: don't push the volatile HEAD with current

 builtin/push.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
1.8.3.rc3.7.gc1ff30b
