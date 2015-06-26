From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v10 0/7] bisect terms
Date: Fri, 26 Jun 2015 18:58:09 +0200
Message-ID: <1435337896-20709-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 26 18:58:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Wxe-0003q3-SM
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbbFZQ6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:58:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42866 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbbFZQ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:58:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGwRQ4008986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 18:58:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGwTel013781;
	Fri, 26 Jun 2015 18:58:29 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z8WxQ-0005Yj-QS; Fri, 26 Jun 2015 18:58:28 +0200
X-Mailer: git-send-email 2.4.4.414.g318df7a.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2015 18:58:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QGwRQ4008986
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435942709.58673@7/TTCkBKbFSF9lQkrH8n+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272792>

This version include Michael Haggerty's improvement to the doc. The
general ones are at the beginning of the series, and the
terms-specific ones are squashed into the appropriate commits.

I added more tests to "git bisect terms", and there are a few code
improvement.

Antoine Delaite (5):
  bisect: correction of typo
  bisect: replace hardcoded "bad|good" by variables
  bisect: simplify the addition of new bisect terms
  bisect: add the terms old/new
  bisect: allow any terms set by user

Matthieu Moy (1):
  Documentation/bisect: move getting help section to the end

Michael Haggerty (1):
  Documentation/bisect: revise overall content

 Documentation/git-bisect.txt | 225 +++++++++++++++++++++++++++++++------------
 bisect.c                     |  94 ++++++++++++++----
 git-bisect.sh                | 210 ++++++++++++++++++++++++++++++++--------
 revision.c                   |  20 +++-
 t/t6030-bisect-porcelain.sh  | 119 ++++++++++++++++++++++-
 5 files changed, 544 insertions(+), 124 deletions(-)

-- 
2.4.4.414.g318df7a.dirty
