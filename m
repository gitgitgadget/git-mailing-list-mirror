From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: What is "-u" supposed to mean in git-fetch?
Date: Thu, 26 Jan 2006 11:57:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601261148510.32499@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jan 26 11:57:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F24op-0004JU-Jx
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 11:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWAZK5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 05:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWAZK5b
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 05:57:31 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53197 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932288AbWAZK5a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 05:57:30 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 44437146845; Thu, 26 Jan 2006 11:57:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 34CC79BC;
	Thu, 26 Jan 2006 11:57:27 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 127AA146845; Thu, 26 Jan 2006 11:57:27 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15156>

Hi,

96b086d6 introduced "-u" to mean "--upload-pack" taking one argument. But 
long ago, b10ac50f1 from Aug 10 already introduced "-u" to mean 
"--update-head-ok" (without argument). This broke my scripts badly.

So, what is it?

Also, in the course of researching this, I tried

	git-whatchanged git-fetch-script

because git-whatchanged does not follow renames. But that did not work, 
because there is no current file of that name! When I created a dummy file 
of that name, git-whatchanged worked real fine! I consider that behaviour 
a bug.

Ciao,
Dscho
