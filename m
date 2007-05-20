From: skimo@liacs.nl
Subject: Partial removal of fetching from git-clone
Date: Sun, 20 May 2007 19:57:42 +0200
Message-ID: <1179683865547-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 19:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HppfX-000640-HR
	for gcvg-git@gmane.org; Sun, 20 May 2007 19:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbXETR56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756833AbXETR55
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 13:57:57 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37076 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571AbXETR5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 13:57:55 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KHvkbO007622;
	Sun, 20 May 2007 19:57:51 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 1229E7DD9F; Sun, 20 May 2007 19:57:46 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47858>

From: Sven Verdoolaege <skimo@kotnet.org>

This was needed for doing submodules in git-fetch,
but since I moved the cloning of submodules to git-checkout,
I no longer need these changes.
Still, I know Junio wants something like this, so they
could be used as a starting point for completely
removing all fetching from git-clone.

skimo
