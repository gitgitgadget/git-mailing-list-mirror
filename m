From: Daniel White <daniel@whitehouse.id.au>
Subject: [StGit] Debian packaging update
Date: Mon, 18 Aug 2008 20:10:36 +1000
Message-ID: <20080818201036.7c2c00f8@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Karl =?UTF-8?B?SGFzc2Vsc3Ryw7Zt?=" <kha@treskal.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 12:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV2OU-0001Iy-6q
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 12:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbYHRKyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 06:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYHRKyV
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 06:54:21 -0400
Received: from smtpgw02.myhostguy.com ([216.10.240.230]:2464 "EHLO
	smtpgw02.myhostguy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbYHRKyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 06:54:20 -0400
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw02.myhostguy.com with SMTP;
   Mon, 18 Aug 2008 03:53:50 -0700
Received: from ppp118-208-3-144.lns1.bne1.internode.on.net [118.208.3.144] by mx252n.mysite4now.com with SMTP;
   Mon, 18 Aug 2008 03:53:35 -0700
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92694>

I've just pushed some patches up to put the debian packaging in line
with the other changes to the build system.

Most importantly, the documentation now gets included in the package.

--

The following changes since commit
42857cbe036ba5917eacc9dbb5644d395f638ed9: Samuel Tardieu (1):
        Do not mess-up with commit message formatting when sending email

are available in the git repository at:

  git://repo.or.cz/stgit/dwhite.git debian

Daniel White (2):
      debian/rules should be producing architecture independent packages
      debian/rules: take advantage of new build targets

 debian/rules |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

-- 
Daniel White
