From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] Trivial cleanups and fixes
Date: Fri, 30 Aug 2013 16:56:44 -0500
Message-ID: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 00:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWl3-0006oz-Om
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab3H3WB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:01:29 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:61630 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3H3WB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:01:28 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so2944445oag.21
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RI2j9Cvl4xv6PZLseAgb4unuCLy7jk0uXeEd7IeJKpc=;
        b=iia3Ur0vsJSiruZu/qDZuNpS2PhZK6Zs953Cxu1mACDTVAx+Iv2a8HUtFN+XcoaTyZ
         kAtIgTmiqcTeSl407DTxIh++sMRTn0dFYQ4ZtRRRL850yb3W7lunaCDLCdnGwYCb7YO4
         2iv8kjW4XQTGsMpQEpRwsJRm4eEN5V18i50oh352SLCokSIbARsLEMKyYm9Ky03l3+3V
         htXnLq1eRxmqPzZB0FKRLHJwPXmWs7MKR9KYZFL6i1VKtad7GlZQyP/7MWkRjJe5Eckn
         XErlfQ1OEr58v5BhNelmqhvjS7ICTrCRMFEVc99Fqz7aPionvuXVjoIbzF10WK7WRe7O
         fdtQ==
X-Received: by 10.60.40.67 with SMTP id v3mr8688381oek.16.1377900088418;
        Fri, 30 Aug 2013 15:01:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm86430obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 15:01:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233472>

Felipe Contreras (6):
  reset: trivial refactoring
  branch: trivial style fix
  rebase: trivial style fixes
  reset: trivial style cleanup
  add: trivial style cleanup
  pull: trivial cleanup

 branch.c        |  2 +-
 builtin/add.c   | 10 +++++-----
 builtin/reset.c | 11 ++++-------
 git-pull.sh     |  3 +--
 git-rebase.sh   |  4 ++--
 5 files changed, 13 insertions(+), 17 deletions(-)

-- 
1.8.4-fc
