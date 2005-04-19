From: Greg KH <gregkh@suse.de>
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Mon, 18 Apr 2005 21:39:38 -0700
Message-ID: <20050419043938.GA23724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Tue Apr 19 06:36:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNkT6-0001GB-DC
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 06:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDSEkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 00:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDSEkI
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 00:40:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:8920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261319AbVDSEkC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 00:40:02 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3J4dxi24428;
	Mon, 18 Apr 2005 21:39:59 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNkWQ-6BU-00; Mon, 18 Apr 2005 21:39:38 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alright, let's try some small i2c and w1 patches...

Could you merge with:
	kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

It contains 4 small patches, 2 i2c and 2 w1 bugfixes, diffstat is
below, I'll figure out how to send the individual patches later.

thanks,

greg k-h

 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/via686a.c |    7 ++-----
 drivers/w1/w1.c             |    9 +++++----
 drivers/w1/w1_smem.c        |    4 ++--
 4 files changed, 10 insertions(+), 12 deletions(-)
     
