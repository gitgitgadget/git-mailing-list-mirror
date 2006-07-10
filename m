From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-log to go forward instead of reverse?
Date: 10 Jul 2006 13:16:49 -0700
Message-ID: <8664i5nrke.fsf@blue.stonehenge.com>
References: <86bqrxpai1.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
	<863bd9p9en.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
	<86mzbhntxu.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101304210.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 22:17:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G02Ba-00015o-Fc
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWGJUQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbWGJUQv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:16:51 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:41480 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1422801AbWGJUQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 16:16:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 8E4758F315;
	Mon, 10 Jul 2006 13:16:50 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 13821-01-96; Mon, 10 Jul 2006 13:16:50 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 16F0B8F3FA; Mon, 10 Jul 2006 13:16:50 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <Pine.LNX.4.64.0607101304210.5623@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23646>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> And if you didn't know about "git shortlog" already, I personally actually 
Linus> find it easier to read

Linus> 	git log --no-merges ORIG_HEAD.. | git shortlog

Linus> which orders things by author instead.  It also reverses the log
Linus> messages as it does so, so each author will have the one-liners sorted
Linus> oldest to newest the way you wanted to (so you do _not_ want to pass
Linus> --reverse to that git-shortlog invocation).

See -- I *knew* there was a shorter way.

Looks like I owe you lunch.  (Again? :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
