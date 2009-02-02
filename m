From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH git-gui v2 0/2] Teach git-gui to use --primer.
Date: Mon,  2 Feb 2009 11:31:59 -0800
Message-ID: <1233603121-1430-1-git-send-email-keith@cs.ucla.edu>
Cc: git@vger.kernel.org
To: Shawn O Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 02 20:33:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU4Y3-0008Fs-Af
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 20:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbZBBTcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 14:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbZBBTcG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 14:32:06 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:38782 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbZBBTcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 14:32:06 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n12JW1wS001462;
	Mon, 2 Feb 2009 11:32:01 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n12JW1vl001461;
	Mon, 2 Feb 2009 11:32:01 -0800
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108111>

The next two patches teach git-gui to take advantage of the new diff.primer
feature from my other patch.  This enhancement includes menu-driven white
space ignore settings.  To see this patch in action: apply the diff.primer
patch to git.git, apply this patch to git-gui.git, fire up git-gui, modify a
file, then right-click on the diff panel and look for the new "White Space"
sub-menu.

Keith Cascio (2):
 Teach git-gui to use --primer.
 Hooks for new config variable "diff.primer".

 git-gui.sh     |   51 ++++++++++++++++++++++++++++++++++++++++++
 lib/diff.tcl   |    9 ++++++-
 lib/option.tcl |   57 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 110 insertions(+), 7 deletions(-)
