From: Karl Chen <quarl@cs.berkeley.edu>
Subject: git-branch --print-current
Date: Thu, 01 Jan 2009 19:28:12 -0800
Message-ID: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 04:39:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIasf-0001R0-D2
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 04:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbZABDiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 22:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbZABDiG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 22:38:06 -0500
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:44502 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbZABDiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 22:38:05 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jan 2009 22:38:05 EST
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 82C1E48C4D; Thu,  1 Jan 2009 19:28:12 -0800 (PST)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104357>


How about an option to git-branch that just prints the name of the
current branch for scripts' sake?  To replace:

    git branch --no-color 2>/dev/null | perl -ne '/^[*] (.*)/ && print $1'
