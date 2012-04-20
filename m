From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/4 v2] push.default upcomming change
Date: Fri, 20 Apr 2012 16:59:00 +0200
Message-ID: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 20 16:59:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLFJC-0006rJ-IH
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 16:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057Ab2DTO73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 10:59:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34486 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355Ab2DTO71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 10:59:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3KEr5Qh032164
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 16:53:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIo-0008Mf-FA; Fri, 20 Apr 2012 16:59:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIo-0003W3-91; Fri, 20 Apr 2012 16:59:14 +0200
X-Mailer: git-send-email 1.7.10.140.g8c333
In-Reply-To: <vpqfwbye9re.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Apr 2012 16:53:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3KEr5Qh032164
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335538388.27053@0eP7PENdgCXHJhmUR0FgkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195997>

OK, so this v2 is not supposed to be a draft anymore. It has
documentation (while I was there, I added PATCH 1/4 thas tries to
document better the existing modes), and I removed the hunks that came
here after a broken merge resolution.

This is based on next, it at least requires 135dade that creates
t5528.

Clemens Buchacher (1):
  t5570: use explicit push refspec

Matthieu Moy (3):
  Documentation: explain push.default option a bit more
  push: introduce new push.default mode "simple"
  push: start warning upcoming default change for push.default

 Documentation/config.txt |   20 +++++++++++++--
 builtin/push.c           |   55 ++++++++++++++++++++++++++++++++++++++--
 cache.h                  |    1 +
 config.c                 |    4 ++-
 t/t5528-push-default.sh  |   63 +++++++++++++++++++++++++++++++++++++++++++---
 t/t5570-git-daemon.sh    |   30 +++++++++++-----------
 6 files changed, 149 insertions(+), 24 deletions(-)

-- 
1.7.10.140.g8c333
