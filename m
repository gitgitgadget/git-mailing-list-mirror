From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 0/3] cvsserver: small corrections and bring documentation up to speed
Date: Sat,  7 Apr 2007 16:52:14 +0200
Message-ID: <11759575342765-git-send-email-frank@lichtenheld.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 16:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaCJE-0006aa-7S
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965940AbXDGOyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965949AbXDGOyM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:54:12 -0400
Received: from mail.lenk.info ([217.160.134.107]:64862 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965940AbXDGOyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:54:11 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HaCJA-00033R-RD; Sat, 07 Apr 2007 16:54:28 +0200
Received: from p54b0f651.dip.t-dialin.net ([84.176.246.81] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HaCIq-0005F6-Lx; Sat, 07 Apr 2007 16:54:08 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HaCH0-00077V-Kh; Sat, 07 Apr 2007 16:52:14 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11743197614111-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43972>

This patch series consists mainly of documentation updates for the
new features I introduced in my previous series. With all these
patches applied I would consider this topic in a shape so that it
could be included in an official release. It still contains
some experimental stuff but since the user has to enable that himself
and I put a "here be dragons" in the documentation I see no problem
with that.

Proofreading of patch 3 by someone that actually speaks English would
be greatly appreciated.

 Documentation/git-cvsserver.txt |   97 +++++++++++++++++++++++++++++++++++-----
 git-cvsserver.perl              |    7 +-
 2 files changed, 91 insertions(+), 13 deletions(-)
