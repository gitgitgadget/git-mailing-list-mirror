From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/2] git-remote-mediawiki: two more fixes
Date: Tue, 17 Jul 2012 16:05:58 +0200
Message-ID: <1342533960-22123-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 17 16:07:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr8QY-0001qe-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 16:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab2GQOGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 10:06:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59822 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241Ab2GQOGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 10:06:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6HE4Bai025580
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2012 16:04:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sr8Pb-0006be-Dk; Tue, 17 Jul 2012 16:06:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sr8Pb-0006I1-A9; Tue, 17 Jul 2012 16:06:03 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Jul 2012 16:04:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6HE4Bai025580
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343138653.34485@F3eK31I4X16YfvtFGwCQ/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201604>

These patches can be added to branch mm/mediawiki-usability in pu.

For the curious: I originally had patch 2/2 in my serie, but
mistakenly discarded it during a rebase. While recovering it and
testing it, I found a typo fixed by patch 1/2.

Matthieu Moy (2):
  git-remote-mediawiki: fix incorrect test usage in test
  git-remote-mediawiki: allow page names with a ':'

 contrib/mw-to-git/git-remote-mediawiki      | 49 +++++++++++++++++++----------
 contrib/mw-to-git/t/push-pull-tests.sh      |  2 +-
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh | 20 ++++++++++++
 3 files changed, 54 insertions(+), 17 deletions(-)

-- 
1.7.11.2.258.g5ff3cdf.dirty
