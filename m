From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Regression: Multi-head syntax
Date: Thu, 13 Oct 2005 22:28:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510132225120.1028@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 13 22:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ9hE-0004aS-2g
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 22:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVJMU2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVJMU2z
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 16:28:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63428 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932498AbVJMU2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 16:28:54 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 724FA13F00E
	for <git@vger.kernel.org>; Thu, 13 Oct 2005 22:28:51 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 597F09ED26
	for <git@vger.kernel.org>; Thu, 13 Oct 2005 22:28:51 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 499609ECC3
	for <git@vger.kernel.org>; Thu, 13 Oct 2005 22:28:51 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1E1A013F00E
	for <git@vger.kernel.org>; Thu, 13 Oct 2005 22:28:51 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10088>

Hi,

with 221e743c.. [git-fetch --tags: deal with tags with spaces in them.] my 
usual git-fetch no longer works. My .git/remotes/junio used to look like 
this:

-- snip --
URL: rsync://rsync.kernel.org/pub/scm/git/git.git
Pull: master:junio todo:todo +pu:pu
-- snap --

but this makes a new head "junio todo:todo +pu:pu". Now I have to write 
the remote like this to work correctly:

-- snip --
URL: rsync://rsync.kernel.org/pub/scm/git/git.git
Pull: master:junio
Pull: todo:todo
Pull: +pu:pu
-- snap --

Is this intended?

Ciao,
Dscho
