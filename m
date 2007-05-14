From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Some misc Documentation patches
Date: Mon, 14 May 2007 16:44:50 +0200
Message-ID: <1179153893715-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 16:45:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnbnP-0005Np-QW
	for gcvg-git@gmane.org; Mon, 14 May 2007 16:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbXENOo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 10:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbXENOo6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 10:44:58 -0400
Received: from mail.lenk.info ([217.160.134.107]:1976 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbXENOo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 10:44:56 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hnblw-0001wv-4D; Mon, 14 May 2007 16:43:36 +0200
Received: from p54b0d0fd.dip.t-dialin.net ([84.176.208.253] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HnbnB-0000hW-Ny; Mon, 14 May 2007 16:44:53 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HnbnB-0005k4-Lr; Mon, 14 May 2007 16:44:53 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47244>

The result of me playing around with git format-patch and git-am.

builtin-log.c: Fix typo in comment
Found while searching for the omnious --mbox option

Documentation: format-patch has no --mbox option
Replace --mbox with --stdout. Probably needs some more
thought to really improve the documentation

git-am: Clean up the asciidoc documentation
Fixing some things that annoyed me while reading the man page
and some things that I found while fixing the former.
If I should split that in more than one patch, please say so.

 Documentation/git-am.txt        |   38 ++++++++++++++++++++------------------
 Documentation/git-applymbox.txt |    2 +-
 Documentation/git-mailinfo.txt  |    3 +--
 builtin-log.c                   |    3 +--
 4 files changed, 23 insertions(+), 23 deletions(-)
