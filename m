From: Peter Baumann <waste.manager@gmx.de>
Subject: [BUG] git-new-workdir doesn't understand packed refs
Date: Tue, 17 Apr 2007 18:17:20 +0200
Message-ID: <20070417161720.GA3930@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdqMu-0005sm-Ea
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031134AbXDQQRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031137AbXDQQRV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:17:21 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54138 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1031134AbXDQQRU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 12:17:20 -0400
Received: (qmail 2705 invoked by uid 0); 17 Apr 2007 16:17:18 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 17 Apr 2007 16:17:18 -0000
Mail-Followup-To: Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44792>

running git-gc or git-gc --prune isn't save because e.g. all the tags
are packed and .git/packed-refs isn't shared on the several workdirs.

This has caused me to lose some tags, but being lucky, I could find those in
the backup.

Greetings,
  Peter
