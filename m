From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/2] Git-MediaWiki
Date: Thu,  1 Sep 2011 18:54:54 +0200
Message-ID: <1314896096-17544-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq39ggomtu.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 01 18:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAY2-0005p5-5h
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab1IAQzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:55:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34327 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab1IAQzN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:55:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p81GsGci005071
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 18:54:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1QzAXd-00039t-0W; Thu, 01 Sep 2011 18:55:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1QzAXc-0004Zi-Ve; Thu, 01 Sep 2011 18:55:00 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <vpq39ggomtu.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Sep 2011 18:54:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81GsGci005071
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1315500860.49826@U+F7bcKRAYeb4ASC0Sa6hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180545>

First patch is just a resend of v6 with style improvements (Junio's
remark, and whitespace fixes). The second patch is new, it can be
squashed into the first if needed, but I've left it appart since I
think "what to do with metadata on push?" is one of the crucial
questions to be answered when writting remote-helpers, so it may
(hopefully) lead to fruitfull discussions.

Jeremie Nikaes (1):
  Add a remote helper to interact with mediawiki (fetch & push)

Matthieu Moy (1):
  git-remote-mediawiki: allow push to set MediaWiki metadata

 contrib/mw-to-git/git-remote-mediawiki     |  787 ++++++++++++++++++++++++++++
 contrib/mw-to-git/git-remote-mediawiki.txt |    7 +
 2 files changed, 794 insertions(+), 0 deletions(-)
 create mode 100755 contrib/mw-to-git/git-remote-mediawiki
 create mode 100644 contrib/mw-to-git/git-remote-mediawiki.txt

-- 
1.7.7.rc0.75.g56f27
