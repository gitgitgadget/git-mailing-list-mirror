From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/4] demonstrate add -p and stash -p failures.
Date: Tue, 14 Apr 2015 13:32:44 +0200
Message-ID: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7ftfkpue.fsf@anie.imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 14 13:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhz5g-0001jR-J7
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 13:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbbDNLdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 07:33:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38771 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833AbbDNLdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 07:33:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EBWpPg010991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2015 13:32:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EBWrfi010332;
	Tue, 14 Apr 2015 13:32:53 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yhz5J-0006F0-2Q; Tue, 14 Apr 2015 13:32:53 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <vpq7ftfkpue.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 14 Apr 2015 13:32:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3EBWpPg010991
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429615973.91854@CAtrgvO/+C+EK3gu7VdC7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267133>

Playing a bit with add -p and stash -p, I can confirm the bug reported
by Tanky. This series just adds failing tests, but I couldn't debug it.

I've exhausted my Git time budget for now, so if someone wants to take
over and fix the bugs, feel free to do it!

Matthieu Moy (4):
  add -p: demonstrate failure when running 'edit' after a split
  t3904-stash-patch: fix test description
  t3904-stash-patch: factor PERL prereq at the top of the file
  stash -p: demonstrate failure of split with mixed y/n

 t/t3701-add-interactive.sh | 25 +++++++++++++++++++++++++
 t/t3904-stash-patch.sh     | 46 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 7 deletions(-)

-- 
2.4.0.rc1.42.g9642cc6
