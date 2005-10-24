From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: daemon.c broken on OpenBSD
Date: 24 Oct 2005 09:06:06 -0700
Message-ID: <86irvmzyq9.fsf@blue.stonehenge.com>
References: <867jc336f4.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 18:08:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU4q0-0006yl-Td
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 18:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVJXQGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 12:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJXQGO
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 12:06:14 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:65154 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751110AbVJXQGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 12:06:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id DE5458F80A;
	Mon, 24 Oct 2005 09:06:06 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23978-01-45; Mon, 24 Oct 2005 09:06:06 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 7FA728F8A4; Mon, 24 Oct 2005 09:06:06 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.12.13.5; tzolkin = 2 Chicchan; haab = 3 Zac
In-Reply-To: <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10545>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> We're doing our own ctype.h.

Linus> The fix is to make sure that "cache.h" is included _after_ system 
Linus> includes.

That probably won't work, because on OpenBSD, it's not a #define, but
rather a real function call.  You can't just #undef that (unless my C
is even more rusty).

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
