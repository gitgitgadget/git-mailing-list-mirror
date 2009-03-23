From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: started a cvsps testsuite Was: Re: [PATCH v3 0/2] cvsimport: add
	test illustrating a bug in cvsps
Date: Mon, 23 Mar 2009 19:11:10 +0100
Message-ID: <20090323181110.GB26678@macbook.lan>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org> <49C22166.3000807@drmicha.warpmail.net> <49C47DF7.9000601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <git-list@hvoigt.net>, ydirson@altern.org,
	git@vger.kernel.org, CVSps@dm.cobite.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 23 19:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llodk-0006d6-Sm
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 19:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbZCWSLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760701AbZCWSLR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 14:11:17 -0400
Received: from darksea.de ([83.133.111.250]:56989 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760693AbZCWSLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 14:11:16 -0400
Received: (qmail 30555 invoked from network); 23 Mar 2009 19:11:00 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2009 19:11:00 +0100
Content-Disposition: inline
In-Reply-To: <49C47DF7.9000601@alum.mit.edu>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114340>

Hallo,

I just started a very simple but hopefully effective testsuite to
collect all the issues we found with cvsps. Because I haven't heard
anything from Yann who where the last one to collect some patches I
forked his master and started from there. 

    http://repo.or.cz/w/cvsps-hv.git

The testsuite is on the pu branch so I can first get some feedback
before I will merge it to master.

Maybe Michael can add his tests as well. You should just need to
construct the expected cvsps output. I choose a similar naming
to the one from git. The suite is very simple:

for each test tXXXX-name should be a correspondingly named CVS module in
t/cvsroot and a directory t/tXXXX-name. In this directory a file named
'expect' contains the expected output of cvsps. If the test is known to
fail also an empty file: 'known_to_fail' is added to the test directory.
Thats it.

Hopefully we can collect some more specifics about the situations where
cvsps fails and most importantly the amount of coding needed for fixing.
From there on it should be easier to decide which route to follow for
a robust inbuild git cvsimport.  

cheers Heiko
