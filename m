From: pggrd <git@paggard.com>
Subject: Managing several threads of the same project in GIT
Date: Fri, 26 Dec 2008 11:20:57 +0000 (UTC)
Message-ID: <loom.20081226T110416-269@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 12:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGApr-0005dj-AF
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 12:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYLZLZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 06:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbYLZLZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 06:25:09 -0500
Received: from main.gmane.org ([80.91.229.2]:54679 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685AbYLZLZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 06:25:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LGAoQ-0004PM-EK
	for git@vger.kernel.org; Fri, 26 Dec 2008 11:25:02 +0000
Received: from 136.182.2.25 ([136.182.2.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 11:25:02 +0000
Received: from git by 136.182.2.25 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 11:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 136.182.2.25 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103933>

Hello,

I've been studying GIT for some time already, but still have not figured out if
it can be used for the scenario like this:

for example:

I have a project, which divides to threads aiming to different clients
most of the code in the project is shared between the threads
in certain files there are different code parts to meet client requirements 
but even those files share the rest of the code

What I need to be able to do is:
- to get code for any thread I like at any time
- to be able to develop each thread separately
- to be able to merge certain changes from one thread to another, at the same
time without loosing the changes specific to the thread, and keep track of merge
history

With GIT strategy to treat content as a single unity - if you will try to merge
branches - everything will be merged thus overwriting the changes that need to
stay. But in the example above, if I make a change in the shared code in one
thread, I need to be able to populate this change to all the threads, but this
change only.

so - is this possible in GIT and if yes - what kind of strategy should be used?

thanks 
