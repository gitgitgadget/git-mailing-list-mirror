From: Greg KH <greg@kroah.com>
Subject: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 02:22:54 -0700
Message-ID: <20070823092254.GA5976@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 23 11:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO90E-0004y0-NJ
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758311AbXHWJ3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758213AbXHWJ3F
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:29:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55124 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623AbXHWJ3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 05:29:02 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IO8zt-0000wL-74; Thu, 23 Aug 2007 10:29:01 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56483>

Hi,

I wanted to see if I could start using stgit instead of quilt, so I
tried to import my current set of kernel patches.

After giving up on the "import a series" option, I just created a mbox
of all of them using quilt and tried to import that.  Unfortunately that
didn't work either:
	$ stg import -M ~/linux/patches/mbox
	Checking for changes in the working directory ... done
	Importing patch "add-my-version-to-the-kernel" ... done
	Importing patch "stupid-patch-for-my-laptop-whi" ... done
	Importing patch "gregs-test-driver-core-sysfs-s" ... done
	Importing patch "detect-atomic-counter-underflo" ... done
	Warning: Message does not contain any diff
	stg import: No diff found inside the patch

I'm using the .13 version if that matters.

The mbox contains 177 kernel patches against Linus's current tree
(2.6.23-rc3-git5), and is available at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/misc/gregkh-stgit-import-mbox.gz
if anyone wants to test it out and see what I was doing wrong.

Any hints?

Oh, I do have some suggestions as to the naming of the patch from a mail
file, as limiting this to a small number of characters like stgit
currently does will not work out for a lot of my patches, but I'll wait
until I can actually import the thing before I look into that :)

thanks,

greg k-h
