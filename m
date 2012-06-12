From: Max Horn <max@quendi.de>
Subject: [PATCH] fast-export: report SHA-1 instead of gibberish when marks
Date: Tue, 12 Jun 2012 15:45:15 +0200
Message-ID: <1339508716-51880-1-git-send-email-max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 16:10:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeRnW-0002uX-Tb
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab2FLOKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:10:11 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:55646 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751517Ab2FLOKK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 10:10:10 -0400
X-Greylist: delayed 1431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jun 2012 10:10:10 EDT
Received: from hilbert.math.nat.tu-bs.de ([134.169.53.151] helo=kaitain.math.nat.tu-bs.de); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1SeRQA-00079M-7K; Tue, 12 Jun 2012 15:46:12 +0200
X-Mailer: git-send-email 1.7.10.4
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1339510210;6c195381;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199786>


This patch should be a fairly obvious bug fix. Just yesterday I run into
it, when testing some buggy code that lead to this error message being
triggered; the results was lots of unreadable binary gibberish
filling my terminal.

While I did not author this commit, I asked its author for (and received)
permission to submit it here. Hopefully this can be included in mainline git
(this would ease work on git-remote-hg a bit ;).
