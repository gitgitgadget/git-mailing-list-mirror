From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: git pull regression?
Date: Tue, 4 Nov 2008 23:27:49 +0100
Message-ID: <20081104222749.GA9296@localhost.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 23:47:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxUgn-0001Qv-NK
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 23:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbYKDWqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbYKDWqh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 17:46:37 -0500
Received: from ox1.aei.mpg.de ([194.94.224.6]:46517 "EHLO ox1.aei.mpg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbYKDWqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 17:46:36 -0500
X-Greylist: delayed 1152 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Nov 2008 17:46:35 EST
Received: from localhost.aei.mpg.de (unknown [172.18.254.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ox1.aei.mpg.de (Postfix) with ESMTP id 5AE948806C9EE
	for <git@vger.kernel.org>; Tue,  4 Nov 2008 23:27:22 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100110>

Hi,

I tested git v1.6.0.3 today and noticed that git pull is
behaving strangely, compared to what I was used to with
v1.5.6.3

It no longer tells me "Already up-to-date." when it used
to, now it simply says nothing.

And when I pulled Linus tree for the kernel this morning 
it downloaded the new commits but git didn't show the 
diffstat.

Furthermore, it kept saying to me 
"Your branch is behind 'origin/master' by 31 commits, 
and can be fast-forwarded"
and git log was not showing the new commits.

At first I thought I had made some mistake with my repo,
but I searched the mailing list and there was a similar
case which was "fixed" after using 'git status' followed
by another 'git pull'. But in my case it did not help.

So I went back to v1.5.6.3 and everything was back
to normal.

After that I made some tests, and v1.6.0 was good
and v1.6.0.1 was bad, but I didn't bisect it
further.

It looks like a regression to me. I can finish
the bisection if people in the list say that
I am not making a mistake somewhere :-)
