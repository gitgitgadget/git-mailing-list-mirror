From: Peter Vereshagin <peter@vereshagin.org>
Subject: GitWeb in FastCGI
Date: Sun, 14 Mar 2010 15:31:21 +0400
Organization: '
Message-ID: <20100314113121.GB8323@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 12:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqmBS-0002VX-Co
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 12:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510Ab0CNLkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 07:40:22 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:56714 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757260Ab0CNLkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 07:40:22 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2010 07:40:21 EDT
Received: from localhost (allium.gnupg.org [81.169.183.122])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id AAE005A8D
	for <git@vger.kernel.org>; Sun, 14 Mar 2010 14:19:43 +0300 (MSK)
Content-Disposition: inline
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142132>

You can't take no for an answer, git!

This is to acknowledge that mod_perl isn't the only way to accelerate the GitWeb.cgi web front-end.
And, Apache's httpd itself isn't necessary to launch it that better way:
It is made possible with the latest snapshot of FCGI::Spawn multi-forked daemon, available to download at: http://gitweb.vereshagin.org/?p=FCGI-Spawn
You must patch your CGI.pm with the diff supplied in the distribution, or you may want to patch gitweb.cgi ( replace new CGI with $FCGI::Spawn::fcgi ), althogh it is necessary for POST requests only ( I have no idea where POSTs should be taken for input in GitWeb code ).
Thanks for attention.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
