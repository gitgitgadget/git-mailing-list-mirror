From: Thomas Koch <thomas@koch.ro>
Subject: git fuse
Date: Thu, 19 Dec 2013 22:15:00 +0100
Message-ID: <201312192215.01103.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 22:32:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtlCR-0002yI-8l
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 22:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab3LSVcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 16:32:02 -0500
Received: from koch.ro ([88.198.2.104]:38185 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756566Ab3LSVcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 16:32:01 -0500
X-Greylist: delayed 1014 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2013 16:32:01 EST
Received: from 112-248.2-85.cust.bluewin.ch ([85.2.248.112] helo=x121eofhwr1202.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1Vtkvy-0000WV-5Z
	for git@vger.kernel.org; Thu, 19 Dec 2013 22:15:06 +0100
User-Agent: KMail/1.13.7 (Linux/3.11-0.bpo.2-amd64; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239549>

Hi,

I'm thinking about using Git for web application deployment and thought that I 
wouldn't even need to checkout a worktree if I could access the bare git repo 
via fuse.

What would be the performance impact? Once the files are in the filesystem cache 
it shouldn't matter anymore, how fast the git fuse layer is, should it?

Do you know any active and stable git-fuse project? 

a) https://github.com/davesque/gitfuse
Python, last  commit 1 year ago

b) https://github.com/mfontani/git-fuse-perl
Perl, last commit 3 years ago

c) 
http://www.seas.upenn.edu/~cse400/CSE400_2008_2009/websites/grant/project.html
http://repo.or.cz/w/figfs.git
thesis, OCaml, last touched in 2009

d) https://github.com/rossbiro/GitFS
Python, recent but declared pre-alpha

e) https://github.com/patrickhaller/git-fs
C, last commit 2 years ago

f) https://github.com/wereHamster/gitfs
https://blog.caurea.org/2009/07/22/having-fun-with-gitfs.html
C, last commit 2 years ago

Regards,

Thomas Koch2
