From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/5] Better merge-base, alternative transport programs
Date: Sat, 23 Apr 2005 20:03:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 24 01:59:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUWO-0006NM-20
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVDXADT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDXADT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:03:19 -0400
Received: from iabervon.org ([66.92.72.58]:56326 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262191AbVDXADH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:03:07 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPUaf-00085M-00
	for git@vger.kernel.org; Sat, 23 Apr 2005 20:03:13 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series contains three patches to add functionality to the library
routines necessary for the rest of the series, a patch to change the
merge-base implementation such that it always returns one of its arguments
when possible (by way of using the date-based algorithm), and a patch to
support fetching what is needed from a repository by HTTP, and both
pushing and pulling by ssh.

 1: Add some functions for commit lists
 2: Parse tree objects completely
 3: Add some functions related to files
 4: Replace merge-base
 5: Add push and pull programs

	-Daniel
*This .sig left intentionally blank*

