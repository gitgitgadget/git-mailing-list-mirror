From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2]: amendment
Date: Thu, 8 Jun 2006 17:22:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081719400.27335@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jun 08 17:23:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoMLQ-0005zo-7S
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 17:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWFHPWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWFHPWp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 11:22:45 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60895 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964871AbWFHPWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 11:22:44 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 0CD121CE9;
	Thu,  8 Jun 2006 17:22:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 015AC1CE5;
	Thu,  8 Jun 2006 17:22:44 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DAF181959;
	Thu,  8 Jun 2006 17:22:43 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: junkio@cox.net, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21494>

Hi,

I completely forgot that with a global config, it makes sense to have 
aliases even if we are not in a git repository.

So, in git.c, handle_alias() the "if (nongit)" makes no sense any longer. 
If I have to revise the patch anyway, I will include the change, but if 
you decide to take it, please change that.

Ciao,
Dscho

P.S.: There might be other users (such as git-peek-remote) who want that 
change, too.
