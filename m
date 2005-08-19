From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: FYI: My experiences with cygwin & git
Date: Fri, 19 Aug 2005 17:23:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508191720230.25163@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 19 17:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E68iV-0000b3-II
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 17:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVHSPXe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 11:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVHSPXe
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 11:23:34 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45782 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751144AbVHSPXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 11:23:33 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 4BA8C13B51B
	for <git@vger.kernel.org>; Fri, 19 Aug 2005 17:23:32 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2B2A8B09FC
	for <git@vger.kernel.org>; Fri, 19 Aug 2005 17:23:32 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 111A2B09E5
	for <git@vger.kernel.org>; Fri, 19 Aug 2005 17:23:32 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id EDDAA13B51B
	for <git@vger.kernel.org>; Fri, 19 Aug 2005 17:23:31 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I tried to compile & run git on cygwin. Two showstoppers:

	- cygwin does not support IPv6 (yet). Therefore, it does
	  not have getaddrinfo() and friends. (minor showstopper)

	- fork() and mmap() together have problems. This manifests
	  itself in "git-diff-tree -p" not working. (showbomber)

No big problem for me, I only tested cygwin out of curiosity.

Ciao,
Dscho
