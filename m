From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: CVS import broken?
Date: Fri, 23 Jun 2006 18:14:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 18:15:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtoJ5-00012E-Rx
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 18:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWFWQOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWFWQOu
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 12:14:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9450 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751735AbWFWQOt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 12:14:49 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7FE951471;
	Fri, 23 Jun 2006 18:14:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 7382D1470;
	Fri, 23 Jun 2006 18:14:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4A84FBF1;
	Fri, 23 Jun 2006 18:14:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22429>

Hi,

I track quite a few CVS repos with 'git-cvsimport -k -i', but recently it 
stopped working (of course, I was not reimporting, but incrementally 
tracking them). I think it is the introduction of one-index-per-branch 
policy:

> fatal: index file mmap failed (Invalid argument)
> unable to write to git-update-index:  at /.../git-cvsimport line 606, <CVS> line 277425.

It seems that git-cvsimport makes a temporary file of size 0, which cannot 
get mmap()ed, because it has size 0.

Any help appreciated,
Dscho
