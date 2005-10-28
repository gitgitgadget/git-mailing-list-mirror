From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/8] fetch-pack/upload-pack enhancements
Date: Fri, 28 Oct 2005 04:45:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280442470.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:47:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKFW-0000GO-PY
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVJ1Cpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVJ1Cpn
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:45:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28623 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965061AbVJ1Cpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:45:43 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 305F713EBD7; Fri, 28 Oct 2005 04:45:42 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0E8E6B4EDD; Fri, 28 Oct 2005 04:45:42 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B6E3FB0D34; Fri, 28 Oct 2005 04:45:41 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9540E13EBD7; Fri, 28 Oct 2005 04:45:41 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10742>


This time, I not only tested things more thoroughly, but included two 
tests enabling you to verify yourself that it's less buggy this time. (I 
actually have a more extensive test which I used, but it is just too big 
for occasional regression testing).

The most important change is probably "Make maximal use of the remote 
refs" which is based on Junio's proposal, and actually makes a big, big 
difference.

Nevertheless, I would like to see the multi_ack extension go into master, 
since it is Just The Right Thing (famous last Capitalized words).

A few of these patches depend on others:

1 - 2 - 3 - 4
  \
6 - 8
  \
    7

5

Thank you for your time & Ciao,
Dscho
