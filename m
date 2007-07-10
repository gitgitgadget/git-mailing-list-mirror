From: Alex Riesen <raa.lkml@gmail.com>
Subject: git-filter-branch exits early
Date: Tue, 10 Jul 2007 22:52:02 +0200
Message-ID: <20070710205202.GA3212@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Mgt-0002Tb-Vi
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 22:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760780AbXGJUwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 16:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760945AbXGJUwI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 16:52:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40597 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760307AbXGJUwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 16:52:06 -0400
Received: from tigra.home (Fa968.f.strato-dslnet.de [195.4.169.104])
	by post.webmailer.de (mrclete mo4) (RZmta 8.3)
	with ESMTP id h00272j6AIenRy ; Tue, 10 Jul 2007 22:52:03 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 91E30277BD;
	Tue, 10 Jul 2007 22:52:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E4554C164; Tue, 10 Jul 2007 22:52:02 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmQFKE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52111>

I have a Debian system where git-filter-branch exits immediately after
"unset CDPATH" in git-sh-setup (the command exits with 1, as CDPATH is
not defined). The system still has bash-2.05a.

git-filter-branch has "set -e", which is why the script finishes
prematurely. If this is not really needed, maybe it can be removed?

I'll see if the system can be upgraded, but I suspect someone can get
a similar problem.
