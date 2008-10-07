From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 0/6] Menu accelerators for Gitk
Date: Tue,  7 Oct 2008 23:56:43 +0200
Message-ID: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org
To: speace@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 07 23:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnKaT-00033q-FE
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 23:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbYJGV6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbYJGV6H
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:58:07 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:45981 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbYJGV6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:58:06 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 26C5B37F7B; Tue,  7 Oct 2008 23:58:05 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id DB69E37ECC; Tue,  7 Oct 2008 23:58:04 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 87FA437E46;
	Tue,  7 Oct 2008 23:58:04 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97746>

I finally got tired of pressing Alt and some letter to activate menus in Gitk. 
For example in "any" program you can press Alt-F to have the File menu drop 
down and then select the underscored character to select the wanted menu.

This series makes it possible. Friends of TCL may think my solution is too
hack-ish. It doesn't fix all warts but that is the subject of later patches
as it looks like it requires other patches.

Git gui has the same problem, but again, subject to another series.

-- robin
