From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/8] remote-{hg,bzr}: updates
Date: Wed, 28 Aug 2013 14:23:05 -0500
Message-ID: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPR-0003PU-65
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab3H1T14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:27:56 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:52165 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab3H1T1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:27:50 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so8165822oag.26
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5aErDsqC9we9xYD6S+55TsLKaGcH2ZhDsrkDMiMyeh0=;
        b=C/9yZOsAwWg9zv/uLOAz5T6FecrS6cUENXaaoqwvRcKbIMjV1nnnJW6FafJsNWL3hP
         Hm3sCzNUx3S+kOx1F3Yi0hIKlc/o/oymYHeE2TfD0ulPQ/B8OYRvXELiMyjZ9lqTM8gX
         vd5Uh+QM1qUF9I2a18NuI6u3DS2RBW+GHS+GWSUB+pUku6qx3Htq9V7eApy2L+AXdbzF
         +mCdRrKnSkRwGN6ijgGylqg75POdHY7gbyAO41s/vpJu8PjdcrXs+IUg7A//kW5hmZPW
         2ZB7xYrXjAIIXuCWg2TcOTCLF77cVsitMIarWColmugTnUqDc/MsizR0wjp0PY8acsTu
         oBcQ==
X-Received: by 10.182.246.39 with SMTP id xt7mr7809051obc.16.1377718070179;
        Wed, 28 Aug 2013 12:27:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm28350398oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233195>

Felipe Contreras (8):
  remote-bzr: fix export of utf-8 authors
  remote-bzr: make bzr branches configurable per-repo
  remote-hg: fix test
  remote-hg: add missing &&s in the test
  remote-hg: improve basic test
  remote-helpers: trivial style fixes
  remote-helpers: cleanup more global variables
  remote-hg: support for notes

 contrib/remote-helpers/git-remote-bzr | 47 +++++++------------------
 contrib/remote-helpers/git-remote-hg  | 65 +++++++++++++++++++----------------
 contrib/remote-helpers/test-bzr.sh    | 30 ++++++++++++++++
 contrib/remote-helpers/test-hg.sh     | 10 +++---
 4 files changed, 82 insertions(+), 70 deletions(-)

-- 
1.8.4-fc
