From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/3] git-gui (Windows): Adapt to new execdir 'libexec/git-core'
Date: Sun, 27 Jul 2008 18:49:40 +0200
Message-ID: <1217177383-25272-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 18:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN9TA-0003zM-VG
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 18:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317AbYG0Qu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYG0QuZ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 12:50:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:37023 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756479AbYG0QuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 12:50:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6RGniNJ022148;
	Sun, 27 Jul 2008 18:49:53 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6RGnhW0014519;
	Sun, 27 Jul 2008 18:49:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90346>

After moving the dashed programs, including git-gui, to execdir
'libexec/git-core', we have problems running git-gui from
msysgit.

The following patch series solves the problems.  I am not sure
however if it is the less intrusive solution.  Maybe the series
needs further discussion before applying it.  Personally, I think
the patches are good enough.

Note that you also need the branch 'spr/installer' in msysgit to
build an installer.

 [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
 [PATCH 2/3] git-gui (Windows): Switch to relative discovery of oguilib
 [PATCH 3/3] git-gui (Windows): Change wrapper to execdir 'libexec/git-core'
