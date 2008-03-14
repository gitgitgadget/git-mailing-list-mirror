From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 0/4] Don't require to be in the repository if we don't need to
Date: Fri, 14 Mar 2008 18:29:26 +0100
Message-ID: <1205515770-3424-1-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDjS-00033R-M3
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbYCNR3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbYCNR3f
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:29:35 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:55101 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbYCNR3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:29:34 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDit-0003YK-LQ; Fri, 14 Mar 2008 18:29:39 +0100
Received: from host-82-135-33-74.customer.m-online.net ([82.135.33.74] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDii-000842-Tm; Fri, 14 Mar 2008 18:29:29 +0100
Received: from djpig by dirac.djpig.de with local (Exim 4.69)
	(envelope-from <frank@lichtenheld.de>)
	id 1JaDik-00013B-Hn; Fri, 14 Mar 2008 18:29:30 +0100
X-Mailer: git-send-email 1.5.4.4.555.g697b7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77258>

Here a small patch series that was based on a user request who wants to be able
to call git send-email from outside of any repository.

I've done some basic testing but more would of course be welcome.
Probably no 1.5.5 material anyway.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
