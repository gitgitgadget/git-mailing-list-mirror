From: Dave Jones <davej@redhat.com>
Subject: dangling commits.
Date: Sat, 20 May 2006 19:05:31 -0400
Message-ID: <20060520230531.GA27511@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 21 01:05:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhaVt-0007k7-FN
	for gcvg-git@gmane.org; Sun, 21 May 2006 01:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWETXFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 19:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWETXFe
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 19:05:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34523 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964809AbWETXFd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 19:05:33 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k4KN5WIQ015792
	for <git@vger.kernel.org>; Sat, 20 May 2006 19:05:32 -0400
Received: from nwo.kernelslacker.org (vpn83-123.boston.redhat.com [172.16.83.123])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k4KN5WfT002392
	for <git@vger.kernel.org>; Sat, 20 May 2006 19:05:32 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.6/8.13.5) with ESMTP id k4KN5VHn028716
	for <git@vger.kernel.org>; Sat, 20 May 2006 19:05:31 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.6/8.13.6/Submit) id k4KN5VHV028715
	for git@vger.kernel.org; Sat, 20 May 2006 19:05:31 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20404>

What's wrong here?

(tmp)$ mkdir git
(tmp)$ cd git
(git)$ rsync -azq rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/ .git
(git)$ git-fsck-objects --full
dangling commit fc024e5e1b92fb11d11aa3c15e9e3f92a888acb6
dangling commit be49def3dd524b241e3f14c657e740f2e4d73d39
dangling commit e659abda29b2b25db2771c3e6086f15bc74b1d06
dangling commit 0f5aaf12d411debc2958dfb029ffcf873d980f15
dangling commit 8eed8a5da8330df6901f254eab4b7056855b919c

The version of git on that box is 1.2.6-1 from Debian etch.

		Dave

-- 
http://www.codemonkey.org.uk
