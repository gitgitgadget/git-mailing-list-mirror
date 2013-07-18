From: Jaap Eldering <eldering@a-eskwadraat.nl>
Subject: git subtree push mangles commit message newlines
Date: Thu, 18 Jul 2013 23:22:33 +0200
Message-ID: <20130718212233.GB22040@a-eskwadraat.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 23:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvvL-0006ls-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934529Ab3GRVji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:39:38 -0400
Received: from square.phys.uu.nl ([131.211.39.72]:36199 "EHLO
	square.phys.uu.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934521Ab3GRVjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=a-eskwadraat.nl; s=alef;
	h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=Jzi/ODSaZdukzVNkVcYBYc8NRFF5GKq8hNaj/FPhqhA=;
	b=WrowjlBEt/Jvfh6Ic9I9hu3CKRnTLCVmgqZ0A9w2ZHELt08MSLFUhUo0U3taiaaNR46oLuzKFRVN8gcJK3xkKFA+vXpflSvtgutjDxt/KJx7QXj6JDlno6f3OEHKsDSku+Rk/Yges56dFQLFOOIm7zA7QWOR0EFpZmx0nP3dtbw=;
Received: from nikola.localdomain ([10.14.0.2])
	by square.phys.uu.nl with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <eldering@A-Eskwadraat.nl>)
	id 1Uzvej-0002qi-LF
	for git@vger.kernel.org; Thu, 18 Jul 2013 23:22:33 +0200
Received: from eldering by nikola.localdomain with local (Exim 4.72)
	(envelope-from <eldering@A-Eskwadraat.nl>)
	id 1Uzvej-0005z6-Gj
	for git@vger.kernel.org; Thu, 18 Jul 2013 23:22:33 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230752>

Hi all,

I recently started using git-subtree and ran into a small issue when
pushing to the subtree repository: newlines in the commit message seem
not to be preserved.

I was using git-subtree from [1], but can also reproduce this with the
version from the main git source-tree commit 634392b26275fe, and I
don't see any changes that could affect this behaviour since then.

Best,
Jaap

[1] https://github.com/helmo/git/tree/subtree-updates/contrib/subtree
