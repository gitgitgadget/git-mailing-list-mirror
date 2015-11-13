From: David Greene <greened@obbligato.org>
Subject: [PATCH 0/7] contrib/subtree: Testsuite cleanup
Date: Thu, 12 Nov 2015 20:32:29 -0600
Message-ID: <1447381956-4771-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 03:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx4Au-0006zD-KD
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 03:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbbKMCdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 21:33:08 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:60443 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754452AbbKMCdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 21:33:06 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1Zx4BM-0004iE-UH; Thu, 12 Nov 2015 20:33:45 -0600
X-Mailer: git-send-email 2.6.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281224>

Sending again with a proper From: address after rebasing on latest master.

Copying the maintainers because the origin patchset didn't get any
comments and I'm unsure of how to proceed.

These are some old changes I have lying around that should get applied
to clean up git-subtree's testbase.  With these changes post-mortem
analysis is much easier and adding new tests can be done in an orderly
fashion.

I have a number of future patches and further development ideas for
git-subtree that require these changes as a prerequisite.

                        -David

 contrib/subtree/git-subtree.sh     |    2 +-
 contrib/subtree/t/Makefile         |   31 +-
 contrib/subtree/t/t7900-subtree.sh | 1366 +++++++++++++++++++++----------
 3 files changed, 956 insertions(+), 443 deletions(-)
