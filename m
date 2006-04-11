From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git log [diff-tree options]...
Date: 10 Apr 2006 17:04:15 -0700
Message-ID: <86k69xasg0.fsf@blue.stonehenge.com>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
	<Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 02:04:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT6Ml-0003rO-Ff
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 02:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWDKAER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 20:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWDKAER
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 20:04:17 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:25997 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932235AbWDKAEQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 20:04:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 355B68EA71;
	Mon, 10 Apr 2006 17:04:16 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11174-02-5; Mon, 10 Apr 2006 17:04:15 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id BA2608F344; Mon, 10 Apr 2006 17:04:15 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.3.13; tzolkin = 1 Ben; haab = 6 Pop
In-Reply-To: <Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18601>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Hi,
Johannes> On Sun, 9 Apr 2006, Linus Torvalds wrote:

>> - keep it - for historical reasons - as a internal shorthand, and just 
>> turn it into "git log --diff -cc"

Johannes> It is "git log --cc", right? And BTW, I was burnt by the difference of 
Johannes> "git-log" and "git log" this time. "git-log" does not understand "--cc". 
Johannes> Could we kill "git-log", please?

Wait.  Why is there a git log and a git-log?  Shouldn't those
be *absolutely* identical?  Or have we now finally diverged, violating
rules that were established earlier?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
