From: Nicolas Pitre <nico@cam.org>
Subject: reflog for HEAD (detached or between branches)
Date: Fri, 26 Jan 2007 17:25:13 -0500
Message-ID: <11698503133039-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZVX-0003v0-0M
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbXAZWZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbXAZWZP
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:25:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60394 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbXAZWZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:25:14 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00IL0YA1BO40@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:25:13 -0500 (EST)
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37886>


This is the implementation for the idea I proposed for the support of
reflog with detached head.  In fact with this serie HEAD has a reflog
of its own which may or may not contain the same log entries found in
reflogs of individual branches.

Nicolas
