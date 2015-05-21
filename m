From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/2] fix post-rewrite hook with 'git rebase -i --exec'
Date: Thu, 21 May 2015 20:13:00 +0200
Message-ID: <1432231982-31314-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 21 20:13:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUyE-0004OZ-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbbEUSNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:13:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53040 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbbEUSNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:13:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4LIDBPk013549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 May 2015 20:13:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4LIDEmU011277;
	Thu, 21 May 2015 20:13:14 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YvUy1-0008Ek-Rb; Thu, 21 May 2015 20:13:13 +0200
X-Mailer: git-send-email 2.4.1.171.g060e6ae.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 21 May 2015 20:13:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4LIDBPk013549
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1432836793.61179@fOCRF0KbpFZ/A9SAX3B2+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269633>

Matthieu Moy (2):
  rebase -i: demonstrate incorrect behavior of post-rewrite hook with
    exec
  rebase -i: fix post-rewrite hook with failed exec command

 git-rebase--interactive.sh   | 10 +++++-----
 t/t5407-post-rewrite-hook.sh | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.4.1.171.g060e6ae.dirty
