From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 0/5] Make README more pleasant to read
Date: Thu, 25 Feb 2016 09:37:25 +0100
Message-ID: <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 09:37:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrQn-0002i2-TM
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760106AbcBYIhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:37:48 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54864 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759214AbcBYIhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:37:47 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bcSo008477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:37:38 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bdLK010488;
	Thu, 25 Feb 2016 09:37:39 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 09:37:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8bcSo008477
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456994260.10543@PKv1YutJJ6ZOvG1wj2Ajyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287339>

Minor tweaks after discussion on v1 (for those who missed it, this
series makes README render nicely on GitHub and tries to present
important information early).

The result is here:

  https://github.com/moy/git/tree/git-readme#readme

Changes since v1:

* Visible on the rendered page: resurect "the stupid content tracker"
  at the bottom ("He described the tool as "the stupid content
  tracker" and the name as (depending on your mood)") as suggested by
  Junio. I first disagreed, but that's part of the explanation why Git
  is called Git, so why not.

* Visible only in the source: change

  # title

  to

  title
  =====

  (I chose the first because it was more easy to type, but for someone
  not familiar with markdown, the second makes it more obvious that
  its' a title)

I kept the patch introducing explicit links on filenames. I do not
care deeply about it.

Matthieu Moy (5):
  README: use markdown syntax
  README.md: add hyperlinks on filenames
  README.md: move the link to git-scm.com up
  README.md: don't call git stupid in the title
  README.md: move down historical explanation about the name

 README => README.md | 56 +++++++++++++++++++++++++++++------------------------
 t/t7001-mv.sh       |  2 +-
 2 files changed, 32 insertions(+), 26 deletions(-)
 rename README => README.md (65%)

-- 
2.7.2.334.g35ed2ae.dirty
