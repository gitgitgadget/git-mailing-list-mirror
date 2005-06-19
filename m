From: Sven Verdoolaege <skimo@kotnet.org>
Subject: cloning a complete repository with cogito
Date: Sun, 19 Jun 2005 17:42:50 +0200
Message-ID: <20050619154249.GB5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: Sven Verdoolaege <skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 17:48:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk21f-0000CC-FJ
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 17:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVFSPxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 11:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVFSPxj
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 11:53:39 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:54948 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261851AbVFSPxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 11:53:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 821FC137B75
	for <git@vger.kernel.org>; Sun, 19 Jun 2005 17:53:33 +0200 (CEST)
Received: from lepidus.kulnet.kuleuven.ac.be (lepidus.kulnet.kuleuven.ac.be [134.58.240.72])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id CD8C4137AF8
	for <git@vger.kernel.org>; Sun, 19 Jun 2005 17:53:31 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by lepidus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 94F2738007E
	for <git@vger.kernel.org>; Sun, 19 Jun 2005 17:53:31 +0200 (CEST)
Received: (qmail 19446 invoked by uid 500); 19 Jun 2005 15:42:50 -0000
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

How can I clone a complete repository with cogito ?

cg-clone will only pull in everything from the master branch.
Then it pulls in the objects pointed to by tags, which
may live on other brachnes, resulting in a repository
that is not git-fsck-clean.

I'd like to be able to clone the whole thing or even
particular branches, different from master.

Think of a repository converted from cvs.

skimo
