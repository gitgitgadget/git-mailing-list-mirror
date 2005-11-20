From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Get rid of .git/branches/ and .git/remotes/?
Date: Sun, 20 Nov 2005 18:00:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Nov 20 18:02:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdsZ7-0003gq-Ti
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 18:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKTRAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 12:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVKTRAy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 12:00:54 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:35244 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750748AbVKTRAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 12:00:54 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2644113F73D
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 18:00:53 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 0E93B9F394
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 18:00:53 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id EF7899F381
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 18:00:52 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id CA3D913F73D
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 18:00:52 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12386>

Hi,

I just had a crazy idea. Since we have a framework in place to read/write 
.git/config, I thought that maybe it would be a nice thing to move the 
information which is in .git/branches or .git/remotes into the config.

Advantages:

- it would be easy to copy your private configuration by copying just one 
  file,

- it would be easy to add a switch to git-fetch/git-pull to actually
  store/update the URL and head mapping under a certain nick,

- we could get rid of some parsing code, and

- it would arguably be more consistent.

Disadvantage:

- I know, I know, yet another change to the location of this 
  information...

- (very lame) you could not find out which nicks you have stored with "ls"

Comments?

Ciao,
Dscho

P.S.: I did not yet say anything about .git/info/, did I?
