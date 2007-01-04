From: Eric Wong <normalperson@yhbt.net>
Subject: [0/2 PATCH] FastCGI and nginx support for gitweb
Date: Wed,  3 Jan 2007 23:48:31 -0800
Message-ID: <11678969111362-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 08:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2NL2-0007a7-EO
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 08:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbXADHsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 02:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbXADHsd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 02:48:33 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60290 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932316AbXADHsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 02:48:33 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 840DC7DC094;
	Wed,  3 Jan 2007 23:48:31 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 03 Jan 2007 23:48:31 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gcafca-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35920>

I was looking at nginx for another project and got sidetracked
into writing instaweb support for it; so I ended up writing a
simple FCGI wrapper for gitweb as well.

---
 .gitignore              |    1 +
 Makefile                |   11 ++++++-
 git-instaweb.sh         |   72 ++++++++++++++++++++++++++++++++++++++++++++++-
 gitweb/gitweb-fcgi.perl |   51 +++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl      |    1 +
 5 files changed, 134 insertions(+), 2 deletions(-)

-- 
Eric Wong
