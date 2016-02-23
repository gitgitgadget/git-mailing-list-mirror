From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH 0/5] Make README more pleasant to read
Date: Tue, 23 Feb 2016 18:40:24 +0100
Message-ID: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: emma.westby@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:41:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYGxt-0006Hp-47
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbcBWRlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:41:07 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46915 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbcBWRlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:41:06 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHevLT021007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:40:58 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHf0l4012837;
	Tue, 23 Feb 2016 18:41:00 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 18:40:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHevLT021007
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854060.62426@3BsvDYsigSs7WzgdOHKZHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287091>

This patch series was inspired by a discussion I had with Emma Jane
after Git Merge last year. It tries both to make the README file less
agressive and generally more pleasant to read.

To get a quick overview, compare the old one:

  https://github.com/git/git#readme

and my proposal:

  https://github.com/moy/git/tree/git-readme#readme

Matthieu Moy (5):
  README: use markdown syntax
  README.md: add hyperlinks on filenames
  README.md: move the link to git-scm.com up
  README.md: don't call git stupid in the title
  README.md: move down historical explanation about the name

 README => README.md | 54 ++++++++++++++++++++++++++++-------------------------
 t/t7001-mv.sh       |  2 +-
 2 files changed, 30 insertions(+), 26 deletions(-)
 rename README => README.md (67%)

-- 
2.7.2.334.g35ed2ae.dirty
