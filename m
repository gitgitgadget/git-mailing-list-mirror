From: David Brown <git@davidb.org>
Subject: Removing old data without disturbing tree?
Date: Tue, 27 Nov 2007 11:39:55 -0800
Message-ID: <20071127193955.GA16585@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 20:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix6I6-0006bC-8y
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 20:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbXK0Tj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 14:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbXK0Tj5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 14:39:57 -0500
Received: from mail.davidb.org ([66.93.32.219]:42722 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbXK0Tj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 14:39:56 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1Ix6Hj-0004TN-Jd
	for <git@vger.kernel.org>; Tue, 27 Nov 2007 11:39:55 -0800
Mail-Followup-To: Git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66254>

An upstream tree I'm mirroring with git-p4 has decided to start checking
in large tarballs (150MB) periodically.  It's basically a prebuild version
of some firmware needed to run the rest of the software.

Git doesn't seem to have any problem with these tarballs (and is using a
lot less space than P4), but I have a feeling we might start running into
problems when things get real big.  Does anyone have experience with packs
growing beyong several GB?

Aside from that, is there an easy way to prune out the old history from a
working tree?  I'd like something like what 'git clone --depth n' would
produce, and I suppose I could do the clone and then pivot the trees.  I
mainly don't want to be rewriting history, just making parts inaccessible.

Thanks,
David Brown
