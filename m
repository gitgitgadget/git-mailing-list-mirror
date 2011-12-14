From: nathan.panike@gmail.com
Subject: [BUG] in rev-parse
Date: Wed, 14 Dec 2011 12:49:27 -0600
Message-ID: <20111214184926.GB18335@llunet.cs.wisc.edu>
Reply-To: nathan.panike@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 19:55:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RatzP-0002UW-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 19:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab1LNSze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 13:55:34 -0500
Received: from llunet.cs.wisc.edu ([128.105.175.76]:37529 "EHLO
	llunet.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab1LNSze (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 13:55:34 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Dec 2011 13:55:34 EST
Received: from llunet.cs.wisc.edu (localhost [127.0.0.1])
	by llunet.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id pBEInR1w005579
	for <git@vger.kernel.org>; Wed, 14 Dec 2011 12:49:27 -0600
Received: (from nwp@localhost)
	by llunet.cs.wisc.edu (8.14.1/8.14.1/Submit) id pBEInRXv005578
	for git@vger.kernel.org; Wed, 14 Dec 2011 12:49:27 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187164>

In my local git.git:

$ git rev-parse 73c6b3575bc638b7096ec913bd91193707e2265d^@
57526fde5df201a99afa6d122c3266b3a1c5673a
942e6baa92846e5628752c65a22bc4957d8de4d0

$ git rev-parse --short 73c6b3575bc638b7096ec913bd91193707e2265d^@
57526fd
942e6ba
fatal: Needed a single revision

^^^ I don't believe this "fatal" message should be here

$ git version
git version 1.7.8

Nathan Panike
