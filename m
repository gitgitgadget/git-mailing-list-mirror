From: skimo@liacs.nl
Subject: [PATCH 0/4] Add git-rewrite-commits
Date: Sun,  8 Jul 2007 18:23:23 +0200
Message-ID: <11839118073186-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 18:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ZY2-0003Nk-3g
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 18:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbXGHQXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 12:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754580AbXGHQXi
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 12:23:38 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60200 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292AbXGHQXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 12:23:37 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l68GNSho031438;
	Sun, 8 Jul 2007 18:23:33 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 30EB63C00A; Sun,  8 Jul 2007 18:23:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51891>

From: Sven Verdoolaege <skimo@kotnet.org>

This patch series adds git-rewrite-commits
and depends (for the tests in the fourth part)
on my earlier patch to allow negative matches
(or an extended patch by Johannes).

[PATCH 1/4] export get_short_sha1
[PATCH 2/4] export add_ref_decoration
[PATCH 3/4] revision: mark commits that didn't match a pattern for later use
[PATCH 4/4] Add git-rewrite-commits

The first two should be fairly uncontroversial.
The third may be considered a waste of a precious bit.
If so, any suggestions for other ways of passing on this information
are welcomed.
The fourth contains the actual git-rewrite-commits builtin.
My main motivation was that cg-admin-rewritehist doesn't
change the SHA1's in commit message and I don't like shell
programming.

skimo
