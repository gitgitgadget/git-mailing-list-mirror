From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/4] Add a method to set config variables
Date: Thu, 17 Nov 2005 22:51:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511172250090.18285@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Nov 17 22:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrfV-0004EG-OQ
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVKQVvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbVKQVvn
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:51:43 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28347 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751504AbVKQVvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:51:42 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD54C13FB7C; Thu, 17 Nov 2005 22:51:41 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9F3199F342; Thu, 17 Nov 2005 22:51:41 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 782859F33B; Thu, 17 Nov 2005 22:51:41 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 62A8E13FB7C; Thu, 17 Nov 2005 22:51:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12160>

Hi,

sorry, just realized that I forgot the sequence numbers, but I am in a 
hurry. git_config_set() needs to be there before git-config-set can be 
there, and only then the test case can be executed. The documentation only 
makes sense once the command is there.

I'll be back in about 2 hours,
Dscho
