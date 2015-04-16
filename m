From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 0/5] demonstrate add -p and stash -p failures
Date: Thu, 16 Apr 2015 09:02:26 +0200
Message-ID: <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Tanky Woo <wtq1990@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 09:03:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YidpX-0004EB-6u
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 09:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbbDPHDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 03:03:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41538 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756870AbbDPHDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 03:03:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72Zop013103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 09:02:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72aor021215;
	Thu, 16 Apr 2015 09:02:36 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yidoq-0005Bq-Bg; Thu, 16 Apr 2015 09:02:36 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 16 Apr 2015 09:02:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3G72Zop013103
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429772559.15214@0DtsrLvfkDa6A5n34oOWDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267257>

Change since v2: simplify the code (for consistancy, I also changed
the code I copy/pasted from in a separate patch).

Still out of Git time budget though :-(.

Matthieu Moy (5):
  t3701-add-interactive: simplify code
  add -p: demonstrate failure when running 'edit' after a split
  t3904-stash-patch: fix test description
  t3904-stash-patch: factor PERL prereq at the top of the file
  stash -p: demonstrate failure of split with mixed y/n

 t/t3701-add-interactive.sh | 27 +++++++++++++++++++++++----
 t/t3904-stash-patch.sh     | 43 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.4.0.rc1.42.g9642cc6
