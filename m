From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/3] rebase -i: drop, missing commits and static checks
Date: Tue, 30 Jun 2015 11:19:18 +0200
Message-ID: <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr, sunshine@sunshineco.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 11:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9rqj-00056W-8C
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 11:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbbF3J3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 05:29:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35170 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbbF3J26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 05:28:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9SnBU023791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 11:28:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9SoRk018302;
	Tue, 30 Jun 2015 11:28:50 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9rqU-0000VF-M1; Tue, 30 Jun 2015 11:28:50 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 30 Jun 2015 11:28:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5U9SnBU023791
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436261331.0018@xWeAX50WSCatbgizb/1hFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273036>

Hi,

Here are a few fixes to squash into the commits of the series. Other
than that, the series looks good to me.

Junio: do you prefer a reroll or do you want to apply locally?

Matthieu Moy (3):
  fixup! git rebase -i: add static check for commands and SHA-1
  fixup! git rebase -i: warn about removed commits
  fixup! git rebase -i: warn about removed commits

 git-rebase--interactive.sh    | 32 +++++++++++++++++++++-----------
 t/t3404-rebase-interactive.sh |  4 ++--
 2 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.5.0.rc0.10.g7792c2a
