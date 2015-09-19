From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 0/3] Clarify the documentation of options with optional arguments
Date: Sat, 19 Sep 2015 09:47:47 +0200
Message-ID: <1442648870-22511-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Alastair McGowan-Douglas <altreus@altre.us>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 19 09:48:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdCsn-0008NY-1P
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 09:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbbISHsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2015 03:48:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47728 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbbISHsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2015 03:48:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8J7lq5F004109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 19 Sep 2015 09:47:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8J7lqdO023785;
	Sat, 19 Sep 2015 09:47:52 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZdCsC-0005vM-D8; Sat, 19 Sep 2015 09:47:52 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 19 Sep 2015 09:47:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8J7lq5F004109
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443253673.54769@ir6+R5K3tcrfHdNqV3o+nQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278235>

Changes since v2:

* Typo in commit message

* key-id -> keyid in more places. Not so important, but we had cases
  where SYNOPSYS was saying key-id and the full doc keyid, let's make
  it more uniform (and more grep-able).

* Document what --sign-commit and --open-in-pager do when the optional
  argument is not specified.

Matthieu Moy (3):
  Documentation: use 'keyid' consistently, not 'key-id'
  Documentation/grep: fix documentation of -O
  Documentation: explain optional arguments better

 Documentation/git-am.txt          |  4 +++-
 Documentation/git-cherry-pick.txt | 10 ++++++----
 Documentation/git-commit-tree.txt |  4 +++-
 Documentation/git-commit.txt      |  6 ++++--
 Documentation/git-grep.txt        |  9 ++++++---
 Documentation/git-merge.txt       |  6 ++++--
 Documentation/git-rebase.txt      |  4 +++-
 Documentation/git-revert.txt      | 10 ++++++----
 Documentation/git-status.txt      |  5 +++--
 Documentation/git-tag.txt         | 18 +++++++++---------
 10 files changed, 47 insertions(+), 29 deletions(-)

-- 
2.5.0.402.g8854c44
