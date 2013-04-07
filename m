From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/6] send-email: configuration improvements
Date: Sun,  7 Apr 2013 12:46:18 -0500
Message-ID: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 19:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtgt-00030a-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934150Ab3DGRre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:47:34 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:50960 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934140Ab3DGRrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:47:33 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so5533919oag.36
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=dIHh5tDuWNDZ+e786f3yF63BBUBhK9CZn0qNoLp8ux0=;
        b=WVR3lY76QLWdVp1tgYQIn/g2TJsZ3TZmHVXGxDceHkHc1qDiG3XTgB38sBehIHETXf
         AduPwrJejPDIBybYUDpIjpA5AebIauu4pE6z1c4/2rlPO+hOa8QYfIQRuX3FrOGFRcOi
         b+yYvFFau69T+mHblQ5Bj7+qKfQMBy3EEYwMuUJNeK3X41mG+3sxxjPJEgK4OD43cr/u
         9AujLxKED86DjTcjWtShXmDcjv6vhMzimHrYQvbTx7Qwd9C/qvEujyWvOJyFLcc52u6o
         RnZ4UfBOiEUdAiyuwHVwnpTUC67w3k3MKpMSD/gocve+1OszxOKhqJHwc/HSwweaE8rU
         yg+Q==
X-Received: by 10.60.65.233 with SMTP id a9mr13490611oet.67.1365356853136;
        Sun, 07 Apr 2013 10:47:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n1sm20669705obc.10.2013.04.07.10.47.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 10:47:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220339>

Hi,

Some comments have been addressed, tests have been added, and a bug fixed.
Also, after the reshuffling of code, cleanup possibilities are realized.

Felipe Contreras (6):
  send-email: make annotate configurable
  format-patch: improve head calculation for cover-letter
  format-patch: refactor branch name calculation
  log: update to OPT_BOOL
  format-patch: add format.cover-letter configuration
  format-patch: trivial cleanups

 Documentation/config.txt           |   6 ++
 Documentation/git-format-patch.txt |   5 +-
 Documentation/git-send-email.txt   |   5 +-
 builtin/log.c                      | 166 +++++++++++++++++++------------------
 git-send-email.perl                |   7 +-
 t/t4014-format-patch.sh            |  33 ++++++++
 6 files changed, 134 insertions(+), 88 deletions(-)

-- 
1.8.2
