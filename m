From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git versus CVS (versus bk)
Date: 31 Oct 2005 18:34:57 -0800
Message-ID: <86r7a1drji.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	<Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	<Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	<20051031195010.GM11488@ca-server1.us.oracle.com>
	<46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com>
	<86hdaxf6wq.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510311822080.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 03:36:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWlzQ-0007Mh-9k
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 03:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVKACfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 21:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVKACfE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 21:35:04 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:8345 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932557AbVKACfD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 21:35:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 6EE648F804;
	Mon, 31 Oct 2005 18:34:58 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 05541-02; Mon, 31 Oct 2005 18:34:57 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C8AA38F805; Mon, 31 Oct 2005 18:34:57 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.12.13.12; tzolkin = 9 Eb; haab = 10 Zac
In-Reply-To: <Pine.LNX.4.64.0510311822080.27915@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10920>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> Start a new branch before the sequence you want to clean
Linus> up. Then, move the cleaned-up history to that branch, and
Linus> eventually you can just delete the old one.

So if I toss something in git/refs, the objects pointed to by that are
eventually reclaimed?  Do I need to git-fsck-objects to do that?  Or
is there some cg command to do the whole thing?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
