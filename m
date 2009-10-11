From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] Trivial patches
Date: Sun, 11 Oct 2009 23:46:10 +0300
Message-ID: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 22:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5Ly-0001qp-H8
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbZJKUqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZJKUqx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:46:53 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62320 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbZJKUqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:46:52 -0400
Received: by fxm27 with SMTP id 27so8435107fxm.17
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7C2wFtBSMtamBgJEzO0kG+LycFeX3tah6vQ7r6tdq1I=;
        b=lvQ5DO03T3ZbknBFzItLUtoA8V5u1jQjNhQ3AbNDnW+GhVSH1TKrnWiiq82yaMkFyz
         LOholYwF9Y7TkJlJH/J90wksKBLgKlrI5kbH/zcZdf3NoT7qJjctU9ArMa+VmIZXGnYx
         95FNyWidfzIHvBO/asndqcaUeJT0rHwaQLTW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iFKDOW9KW6cUla4CFngBa1oKuTZF/Jv4AuUoLg/TOXS8QYqCCdsvUm3OsacwqIJQCQ
         CJFMElgBLZbC/wtuSDpK2CDVKpQZZRf9/yAHsGqelZASaTHb9e2AXtbl28P+x6QsS6+B
         dPHD2MLnYcYyoa+fi0FV1zcNxrt3p8UlBaklk=
Received: by 10.86.12.35 with SMTP id 35mr4591477fgl.20.1255293975691;
        Sun, 11 Oct 2009 13:46:15 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l12sm4287288fgb.14.2009.10.11.13.46.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:46:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.4.g31fc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129953>

These are a bunch of no-brainers. The one for bool types has been discussed and
agreed before.

Felipe Contreras (3):
  Fix a bunch of pointer declarations (codestyle)
  git config: clarify bool types
  user-manual: use 'fast-forward'

 Documentation/user-manual.txt |   14 +++++++-------
 builtin-config.c              |    4 ++--
 diff.c                        |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)
