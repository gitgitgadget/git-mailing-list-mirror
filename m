From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Funny accidents with two servers
Date: Fri, 27 Jan 2006 00:45:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601270037050.585@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jan 27 00:46:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2GoT-0001Oz-H0
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 00:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWAZXp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 18:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWAZXp4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 18:45:56 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40363 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964825AbWAZXp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 18:45:56 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id BB37814662A
	for <git@vger.kernel.org>; Fri, 27 Jan 2006 00:45:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id ADEE59A1
	for <git@vger.kernel.org>; Fri, 27 Jan 2006 00:45:53 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7D62914662A
	for <git@vger.kernel.org>; Fri, 27 Jan 2006 00:45:53 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15172>

Hi,

I usually pull master, todo and pu from git.kernel.org. Evidently, one of 
the two servers behind that address lags behind a lot. So, half of the 
time I get the message "* refs/heads/junio: does not fast forward to 
branch 'master' of junio;".

The real fun starts when I do it again, and the other server is picked. No 
matter what, I get all objects of "pu" which are not in "master", since 
the versions of "pu" on the two servers do not fast forward to the other, 
respectively.

If I would not happen to know which server has the up-to-date version of 
"master", I could not tell if the version of "pu" is up-to-date or not, 
since "pu" is rebased every so often, and therefore one the ref is 
updated, even if it is an older version of pu.

So, I played a bit with "pu" only to find out after quite a while, that it 
was not the current version after all.

Hthop,
Dscho
