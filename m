From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] gitk: handle --full-diff corectly
Date: Thu, 25 Oct 2012 19:23:19 +0200
Message-ID: <1351185801-18543-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Paul Mackerras <paulus@samba.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 19:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRR9j-0004Jx-0G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 19:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992461Ab2JYRXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 13:23:31 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36516 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946120Ab2JYRXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 13:23:30 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1890910wib.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=l52RMPJV0Pr7o92XgP+IjYEauBbTH/4YYYu5XdnDogY=;
        b=myhPU45LEWnGGowKKAjp3NqF5WCVjDE4oFZQZLCkJYWRDv4pyj9xOU3Hsqzo+X5c98
         Et9YBZ/iOxQmNpbkmqjzDkUnH44p47ZdtRSuL2eq7F3SEgzEB4mBRPsBbeUGFZruyRh6
         RvVSyHKzKB+1hGhKMsbe9ELzf8wt28Vsm//q9RkQj3In7/yggYE4nLBmEkFxIhoCqZwR
         7qIujL82B4h4E3sq5844DCLC8KHvXJP0z/rGmI2i1D6K9ZbqWeE+9/ffoo7OKlO1P1Ou
         m2rOF3IUX+oq4aHKetsGjmzp0hgFoJGJ7XCt2uOPNnUOnoXO/1e1SBCBqdXkNXfLgEDc
         t8eA==
Received: by 10.180.91.71 with SMTP id cc7mr15380029wib.2.1351185809598;
        Thu, 25 Oct 2012 10:23:29 -0700 (PDT)
Received: from localhost (ip-109-43-0-94.web.vodafone.de. [109.43.0.94])
        by mx.google.com with ESMTPS id ei1sm12283078wid.7.2012.10.25.10.23.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 10:23:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208411>

Basically $SUBJECT. See details in the 2nd patch.

Felipe Contreras (2):
  gitk: simplify file filtering
  gitk: handle --full-diff correctly

 gitk-git/gitk | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

-- 
1.8.0
