From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: openbsd version?
Date: 10 Oct 2005 12:29:12 -0700
Message-ID: <864q7pdvcn.fsf@blue.stonehenge.com>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
	<7vvf0542fs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 21:29:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP3Kv-0005ig-EA
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 21:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVJJT3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVJJT3W
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 15:29:22 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:29584 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751123AbVJJT3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 15:29:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id BC5428F3A2;
	Mon, 10 Oct 2005 12:29:13 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 15207-01-18; Mon, 10 Oct 2005 12:29:12 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E937D8F3A6; Mon, 10 Oct 2005 12:29:12 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.12.11; tzolkin = 1 Chuen; haab = 9 Yax
In-Reply-To: <7vvf0542fs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9915>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Linus Torvalds <torvalds@osdl.org> writes:
>> Either do
>> 
>> make NO_STRCASESTR=1 ..
>> 
>> or add that explicitly to the makefile in the OpenBSD rules and send Junio 
>> a tested patch ;)

Junio> Thanks; this has been resolved underwater.

And yes, I made my first patch with git today!  But I cut-n-pasted
it and blew the leading tabs.

Related question.  I created "mybranch" to do the patch, but how
can I have my repository now forget that mybranch was ever made?
Is it sufficient to remove the branch link, and then type some "fsck"
operation?

That's also a question in general... how can I remove a commit,
knowing that I'd never refer to it again?  Or is disk space so cheap
that it wouldn't make any difference anyway?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
