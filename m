From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 0/6] Make "git show -s" easier to discover for users
Date: Tue, 16 Jul 2013 10:05:34 +0200
Message-ID: <1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20130715185843.GH14690@google.com>
Cc: jrnieder@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 16 10:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz0bl-0007KH-Up
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 10:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3GPI1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 04:27:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33670 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab3GPI1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 04:27:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6G8O9qF014766
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Jul 2013 10:24:10 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uz0YM-0001yc-Kn; Tue, 16 Jul 2013 10:24:10 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uz0YM-0008Js-9h; Tue, 16 Jul 2013 10:24:10 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <20130715185843.GH14690@google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 16 Jul 2013 10:24:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6G8O9qF014766
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374567854.5789@MZrTK00FkBIVT3XrKtavrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230549>

One real fix since v3: there was an incorrect file name in a test
(noticed by Jonathan). Now, all actual outputs are called "actual".

Other than that: extra tests, and style fixes in commit messages.

Matthieu Moy (6):
  t4000-diff-format.sh: modernize style
  diff: allow --no-patch as synonym for -s
  diff: allow --patch & cie to override -s/--no-patch
  Documentation/git-show.txt: include common diff options, like
    git-log.txt
  Documentation: move description of -s, --no-patch to diff-options.txt
  Documentation/git-log.txt: capitalize section names

 Documentation/diff-options.txt     |  5 ++++
 Documentation/git-log.txt          |  8 +++----
 Documentation/git-show.txt         |  9 +++++++
 Documentation/rev-list-options.txt |  3 ---
 diff.c                             | 30 ++++++++++++++----------
 t/t4000-diff-format.sh             | 48 +++++++++++++++++++++++++++++++-------
 6 files changed, 75 insertions(+), 28 deletions(-)

-- 
1.8.3.1.495.g13f33cf.dirty
