From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git-repack -a -d produces unusable packs with 1.4.0
Date: Sun, 25 Jun 2006 13:35:22 +0200
Message-ID: <20060625113522.GC19210@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 25 13:35:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuStj-0007CG-Ii
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWFYLfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWFYLfY
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:35:24 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63982 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932376AbWFYLfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:35:24 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id B10FF30DFF; Sun, 25 Jun 2006 13:35:22 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11-2006-06-13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22615>

Hello everyone,
what on earth is going wrong here (this is with 1.4.0):

        (node01) [~] git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
        Checking files out...)
        100% (19830/19830) done
        (node01) [~] cd linux-2.6/
        (node01) [~/linux-2.6] git repack -a -d
        Generating pack...
        Done counting 263175 objects.
        Deltifying 263175 objects.
        100% (263175/263175) done
        Writing 263175 objects.
        100% (263175/263175) done
        Total 263175, written 263175 (delta 206825), reused 262943 (delta 206593)
        Pack pack-ce49d2efd5af06ed6093049050b5ba41da8b683f created.
        mv: overwrite `.git/objects/pack/pack-ce49d2efd5af06ed6093049050b5ba41da8b683f.pack', overriding mode 0444? y
        mv: overwrite `.git/objects/pack/pack-ce49d2efd5af06ed6093049050b5ba41da8b683f.idx', overriding mode 0444? y
        fatal: packfile .git/objects/pack/pack-ce49d2efd5af06ed6093049050b5ba41da8b683f.pack does not match index.
        (node01) [~/linux-2.6] git repack -a -d
        Generating pack...
        fatal: expected sha1, got garbage:
        fatal: packfile .git/objects/pack/pack-ce49d2efd5af06ed6093049050b5ba41da8b683f.pack does not match index.

Oh and are there localized git mirrors like for example
git.de.kernel.org or is the git protocoll only available from the
primary site?

        Thomas
