From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Missing links in documentation
Date: Mon, 12 Dec 2005 16:53:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512121650340.6435@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Dec 12 16:57:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elq0V-0001xB-4Q
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 16:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLLPxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 10:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVLLPxv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 10:53:51 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53705 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932069AbVLLPxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 10:53:50 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C0FDC13FA69; Mon, 12 Dec 2005 16:53:47 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A7BAC9DD92; Mon, 12 Dec 2005 16:53:47 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9786B9DD72; Mon, 12 Dec 2005 16:53:47 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 813F913FA69; Mon, 12 Dec 2005 16:53:47 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13522>

Hi,

just to let you know: the following files are not linked:

git-cvsexportcommit.txt
git-http-push.txt
git-pack-redundant.txt
pack-protocol.txt

Unfortunately, I don't have time to work on that, since I hunted a bug 
with t6022 for two hours, only to discover that somehow make did not pick 
up the new git-merge-recursive.py, but used the old one. And no, I cannot 
reproduce this behaviour .-(

Ciao,
Dscho
