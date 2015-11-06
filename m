From: David Greene <greened@obbligato.org>
Subject: (unknown)
Date: Thu,  5 Nov 2015 21:34:56 -0600
Message-ID: <1446780903-22156-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 05:21:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuYWP-0007Ic-O6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 05:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031666AbbKFEUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 23:20:54 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48875 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030793AbbKFEUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 23:20:53 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1ZuXoW-0005Zp-Ax; Thu, 05 Nov 2015 21:35:44 -0600
Subject: 
X-Mailer: git-send-email 2.6.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280958>

I'm processing some old patches I have lying around.  These clean up
git-subtree's test base and refactor the test code so that each test
is independent of the others.  This greatly aids debugging and
post-mortem analysis.

I have rebased these old patches on master, ensuring that new tests
that have been added in the interim are incorporated into the new test
code.

After using git-subtree in real projects for a couple of years and
exploring similar tools that have been developed, I'm fairly convinced
we should change some current behavor of git-subtree.  I have also run
into the need for some additional features.  I'm now in a position
where I can work on those.

This patch set is a prerequisite for that work.
