From: Wayne Davison <wayne@opencoder.net>
Subject: git-branch silently ignores --track on local branches
Date: Sat, 10 Nov 2007 09:45:57 -0800
Message-ID: <20071110174557.GC1036@blorf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 18:56:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IquYs-0006jy-Hm
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 18:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXKJRzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 12:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXKJRzn
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 12:55:43 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:50447 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbXKJRzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 12:55:42 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2007 12:55:42 EST
Received: by dot.blorf.net (Postfix, from userid 1000)
	id 4011E98F; Sat, 10 Nov 2007 09:45:57 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64362>

I used to be able to create a branch that tracked master (or another
local branch) by using "git branch --track new-branch" from that
checked-out branch.  However, this functionality was apparently
removed and now the --track option is silently ignored for local
branches.  I'd love to have this functionality restored.  Is there
a problem with local branches being supported when explicitly
requested?

..wayne..
