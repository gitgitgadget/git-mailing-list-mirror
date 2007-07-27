From: bdowning@lavos.net (Brian Downing)
Subject: Teach git-gui about merging around modified files?
Date: Fri, 27 Jul 2007 12:03:47 -0500
Message-ID: <20070727170347.GX21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 19:04:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IETER-0000mR-49
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 19:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860AbXG0REA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 13:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758595AbXG0RD7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 13:03:59 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:2614 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815AbXG0RD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 13:03:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9ACLCqUZKhvbzRmdsb2JhbACBTYVqiCgBAQE1AQ
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 27 Jul 2007 13:03:56 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 0355B309F31; Fri, 27 Jul 2007 12:03:47 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53934>

"git merge" will happily merge a change with modified files in the tree
as long as the merge doesn't touch any of them.  However, it appears
"git gui" won't even try if there are modified files at all.

How hard would it be to fix this, or is this an intentional choice?
I realize that commiting even untouched files before a merge is safer,
but I'm tasked with migrating some CVS users to Git, and I'd prefer
to be able to introduce the new Git workflow slowly.

(I'm happy enough with disallowing merges that actually touch modified
files, so I'm not looking for any kind of in-working-directory merge
like some others were.  I'd just like the "git merge" behavior to work
in git-gui.)

-bcd
