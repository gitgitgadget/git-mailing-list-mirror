From: Reto Glauser <linux@blinkeye.ch>
Subject: git-cvsimport: missing branches
Date: Wed, 23 Sep 2009 19:35:24 +0200
Message-ID: <4ABA5C5C.2060207@blinkeye.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>, mhagger@tigris.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 19:41:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqVqS-00059e-P1
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 19:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbZIWRlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 13:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbZIWRlU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 13:41:20 -0400
Received: from mail.blinkeye.ch ([78.46.102.7]:52134 "EHLO mail.blinkeye.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbZIWRlS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 13:41:18 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2009 13:41:17 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.blinkeye.ch (Postfix) with ESMTP id 4A8563F002;
	Wed, 23 Sep 2009 19:35:25 +0200 (CEST)
Received: from [10.10.10.2] (146-48.104-92.cust.bluewin.ch [92.104.48.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.blinkeye.ch (Postfix) with ESMTPSA id 048423F004;
	Wed, 23 Sep 2009 19:35:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128986>

Hello

I need to use CVS with a history of about 20 years (someway back it was 
converted from SCCS to CVS). I have to stay in sync with the CVS 
repository to import changes from co-workers and to eventually commit 
changes back. I do have access to the RCS ',v' files.

So, git-cvsimport is exactly what I was looking for. Except, if I do a 
git-cvsimport I have a couple of branches missing, and I don't know why.

I see the branch names from cvsps in the output, but somehow 
git-cvsimport skips them anyway. I tried to add a branch manually which 
got mit a couple of years of history back, but then it stops anyway.

I used cvs2git from http://cvs2svn.tigris.org which shows me these 
missing branches.

So, my questions are:

- Is the problem in cvsps or git-cvsimport or in the CVS history?
- Can I use the cvs2git import as a starting point and later use 
git-cvsimport for incrementally update the git repository?
- Can I somehow compare the result of git-cvsimport and cvs2git to see 
differences?
- Is there any other feasible workflow to stay in sync with a CVS 
repository with a large history while still using git behind the scene?

Any pointers appreciated.

Regards,
Reto
