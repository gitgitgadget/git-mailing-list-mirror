From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk Patch 0/6]
Date: Thu,  9 Oct 2008 08:09:44 +0200
Message-ID: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Oct 09 08:13:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnolV-000419-1K
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 08:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680AbYJIGLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 02:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbYJIGLG
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 02:11:06 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:54558 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbYJIGLF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 02:11:05 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 8CFC038A33; Thu,  9 Oct 2008 08:11:02 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id EF47238A31; Thu,  9 Oct 2008 08:11:01 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 58A1637E44;
	Thu,  9 Oct 2008 08:11:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97824>

(This is a resend to include gitk maintainer Paul Mackerras)

I finally got tired of pressing Alt and some letter to activate menus in Gitk. 
For example in "any" program you can press Alt-F to have the File menu drop 
down and then select the underscored character to select the wanted menu.

This series makes it possible. Friends of TCL may think my solution is too
hack-ish. It doesn't fix all of the similary problem (mostly button) but 
that is the subject of later patches as it looks like it requires other
means.

Git gui has the same problem, but again, subject to another series. 
