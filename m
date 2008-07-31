From: Daniel White <daniel@whitehouse.id.au>
Subject: [StGit RFC] Pull request for build/install work
Date: Thu, 31 Jul 2008 16:29:16 +1000
Message-ID: <20080731162916.14ffc9fd@whitehouse.id.au>
References: <20080724202031.55dec8e8@whitehouse.id.au>
	<b0943d9e0807251446w1e9ed73erfa7c1638191d88a@mail.gmail.com>
	<20080727162750.25b7cdf3@whitehouse.id.au>
	<b0943d9e0807270121x43b0a454g1042c0cfe650f2c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 09:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSDZ-0003y3-Ct
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYGaHDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 03:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbYGaHDl
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:03:41 -0400
Received: from smtpgw03.myhostguy.com ([216.10.240.249]:4604 "EHLO
	smtpgw03.myhostguy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbYGaHDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 03:03:40 -0400
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw03.myhostguy.com with SMTP;
   Thu, 31 Jul 2008 00:03:32 -0700
Received: from ppp121-45-215-118.lns2.bne1.internode.on.net [121.45.215.118] by mx252n.mysite4now.com with SMTP;
   Thu, 31 Jul 2008 00:03:03 -0700
In-Reply-To: <b0943d9e0807270121x43b0a454g1042c0cfe650f2c1@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90900>

Changes are on my experimental branch
at git://repo.or.cz/stgit/dwhite.git.

Fixed some old cruft causing problems when building/installing the
documentation and added new targets for streamlining the process.  The
end result being fairly similar to Git's install process.

Daniel White (7):
      Fix Makefile to correctly pass prefix option
      Remove variables regarding section 7 man pages
      Fix default install location for manpages
      Add install-doc target to makefile
      Add install-html target to makefile
      Remove installation of documentation from setup.py
      Updated INSTALL with documentation of Makefile

 Documentation/Makefile |   25 ++++++++++++-------------
 INSTALL                |   15 ++++++++++-----
 Makefile               |   12 +++++++++---
 setup.py               |    2 +-
 4 files changed, 32 insertions(+), 22 deletions(-)

-- 
Daniel White
