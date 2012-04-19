From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH 0/3] push.default upcomming change
Date: Fri, 20 Apr 2012 00:57:11 +0200
Message-ID: <1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqaa27bgon.fsf@bauges.imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 20 01:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL0lX-0002mX-OH
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 01:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab2DSX1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 19:27:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44765 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314Ab2DSX1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 19:27:49 -0400
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Apr 2012 19:27:48 EDT
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3JMp2Bh023916
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 00:51:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SL0Hu-0001ly-Hr; Fri, 20 Apr 2012 00:57:18 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SL0Hu-0005Ew-EK; Fri, 20 Apr 2012 00:57:18 +0200
X-Mailer: git-send-email 1.7.10.140.g8c333
In-Reply-To: <vpqaa27bgon.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Apr 2012 00:51:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3JMp2Bh023916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335480666.567@UAKTBJKXSjybKm/J4Ltl9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195973>

So, here's my first re-roll of Peff's patch. I've included the warning
change in the same patch serie because topics are related and to avoid
conflicts.

Compared to Peff's version, I've added testcases, but the 'simple'
mode still lacks doc (I will do soon).

Clemens Buchacher (1):
  t5570: use explicit push refspec

Matthieu Moy (2):
  push: introduce new push.default mode "simple"
  push: start warning upcoming default change for push.default

 builtin/push.c        |   72 +++++++++++++++++++++++++++++++++++++++++++++++--
 cache.h               |    4 ++-
 config.c              |    4 ++-
 environment.c         |    2 +-
 t/t5516-fetch-push.sh |   33 +++++++++++++++++++++++
 t/t5570-git-daemon.sh |   30 ++++++++++-----------
 6 files changed, 124 insertions(+), 21 deletions(-)

-- 
1.7.10.140.g8c333
