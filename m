From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 0/2] Remove "push.default unset" warning
Date: Thu, 25 Feb 2016 10:21:58 +0100
Message-ID: <1456392120-16298-1-git-send-email-Matthieu.Moy@imag.fr>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
Cc: git@vger.kernel.org, peff@peff.net, philipoakley@iee.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 10:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYs7w-0005Gy-3R
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 10:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760199AbcBYJWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 04:22:20 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36954 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760115AbcBYJWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 04:22:15 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P9M1ga021026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 10:22:01 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P9M2e7011904;
	Thu, 25 Feb 2016 10:22:02 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 10:22:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P9M1ga021026
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456996924.34306@h0B4we6N/fBKdV1SPvs+bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287353>

Junio and Peff both lean towards removing the message completely, and
I think I'm convinced. We would have to do this in the future anyway.

While we're there, improve the manual for git push as suggested by
Philip Oakley.

Matthieu Moy (2):
  push: remove "push.default is unset" warning message
  Documentation/git-push: document that 'simple' is the default

 Documentation/git-push.txt |  7 +++++++
 builtin/push.c             | 34 ----------------------------------
 2 files changed, 7 insertions(+), 34 deletions(-)

-- 
2.7.2.334.g35ed2ae.dirty
