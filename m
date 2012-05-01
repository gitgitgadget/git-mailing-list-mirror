From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-subtree split O(N)
Date: Mon, 30 Apr 2012 20:03:42 -0700
Message-ID: <86aa1sr4a9.fsf@red.stonehenge.com>
References: <CA+EzHGfiRg+w8FsvrXEi0Yr4oVzxaZA_1JT8cmRR0YrYG7m6AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vinnie Falco <vinnie.falco@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 05:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP3Ny-0003Lg-U1
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 05:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323Ab2EADDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 23:03:46 -0400
Received: from lax-gw15.mailroute.net ([199.89.0.115]:47121 "EHLO
	gw15.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756939Ab2EADDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 23:03:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id B0EB9E362AB;
	Tue,  1 May 2012 03:03:45 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw15.lax01.mailroute.net ([199.89.0.115])
	by localhost (gw15.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id i-8e2Jn-DFuP; Tue,  1 May 2012 03:03:44 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id 7E045E362A7;
	Tue,  1 May 2012 03:03:44 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id BC2F025C3; Mon, 30 Apr 2012 20:03:42 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.5; tzolkin = 3 Chicchan; haab = 8 Uo
In-Reply-To: <CA+EzHGfiRg+w8FsvrXEi0Yr4oVzxaZA_1JT8cmRR0YrYG7m6AQ@mail.gmail.com>
	(Vinnie Falco's message of "Mon, 30 Apr 2012 18:39:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196649>

>>>>> "Vinnie" == Vinnie Falco <vinnie.falco@gmail.com> writes:

Vinnie> I'm using git-subtree split to extract changes to a directory
Vinnie> previously added with git-subtree add, in my local repository. The
Vinnie> split is going into its own branch, which I then push to the upstream.

Vinnie> The problem is that every time I split, git-subtree starts from the
Vinnie> very beginning of the commit log and works its way forward. I thought
Vinnie> that it was only supposed to do that once, and that subsequent splits
Vinnie> would start from the last commit in the destination branch (I keep the
Vinnie> split branch around).

Are you using -rejoin?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
