From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH 0/2] Explain newbies the "commit before pull" flow
Date: Fri, 20 Nov 2009 16:59:25 +0100
Message-ID: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 17:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBVx5-0000pb-6o
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 17:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbZKTQDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 11:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbZKTQDC
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 11:03:02 -0500
Received: from imag.imag.fr ([129.88.30.1]:41322 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281AbZKTQDB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 11:03:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAKFxXwh006333
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Nov 2009 16:59:33 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBVtV-0001MY-CX; Fri, 20 Nov 2009 16:59:33 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBVtV-0003KL-9g; Fri, 20 Nov 2009 16:59:33 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 20 Nov 2009 16:59:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133354>

A colleague of mine asked me "why do I need to commit before I can
pull", and I was about to send a link to the user manual, when I
noticed I couldn't find any explanation about that there.

This little patch serie propose a few more sentence in the user
manual, and a little more verbose error message for those who don't
read the docs.

I'm not sure the wording is the best we can do. Native-speakers and
Git gurus are welcome to improve it ;-).

Matthieu Moy (2):
  merge-recursive: point the user to commit when file would be
    overwritten.
  user-manual: Document that "git merge" doesn't like uncommited
    changes.

 Documentation/user-manual.txt |   14 +++++++++++---
 merge-recursive.c             |    6 ++++--
 2 files changed, 15 insertions(+), 5 deletions(-)
