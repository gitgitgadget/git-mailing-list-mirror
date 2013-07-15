From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 0/5] Make "git show -s" easier to discover for users
Date: Mon, 15 Jul 2013 19:05:09 +0200
Message-ID: <1373907914-8020-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vppujbwuh.fsf@alter.siamese.dyndns.org>
Cc: stefanbeller@googlemail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 19:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UymDk-0003Xn-EW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933428Ab3GORFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:05:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47184 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab3GORFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:05:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6FH5HFB009974
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 19:05:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UymD9-0003fz-Av; Mon, 15 Jul 2013 19:05:19 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UymD8-00026V-TN; Mon, 15 Jul 2013 19:05:18 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <7vppujbwuh.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 19:05:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FH5HFB009974
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374512718.32581@iW5hqa/kQYItNusnU3b2uQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230494>

This fixes the issue found by Junio where "git log --no-patch -u" was
showing the patch, but not "git log --no-patch -U8". Other patches are
unmodified.

Matthieu Moy (5):
  diff: allow --no-patch as synonym for -s
  diff: allow --patch & cie to override -s/--no-patch
  Documentation/git-show.txt: include common diff options, like
    git-log.txt
  Documentation: move description of -s, --no-patch to diff-options.txt
  Documentation/git-log.txt: capitalize section names

 Documentation/diff-options.txt     |  5 +++++
 Documentation/git-log.txt          |  8 ++++----
 Documentation/git-show.txt         |  9 +++++++++
 Documentation/rev-list-options.txt |  3 ---
 diff.c                             | 30 ++++++++++++++++++------------
 5 files changed, 36 insertions(+), 19 deletions(-)

-- 
1.8.3.1.495.g13f33cf.dirty
