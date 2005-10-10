From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: openbsd version?
Date: 10 Oct 2005 13:36:01 -0700
Message-ID: <86ek6tcdou.fsf@blue.stonehenge.com>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
	<7vvf0542fs.fsf@assigned-by-dhcp.cox.net>
	<864q7pdvcn.fsf@blue.stonehenge.com>
	<7vll113yjs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 22:37:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4O8-00016R-23
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVJJUgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVJJUgM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:36:12 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:56208 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751214AbVJJUgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:36:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 24FCA8F33E;
	Mon, 10 Oct 2005 13:36:02 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 27063-03-26; Mon, 10 Oct 2005 13:36:01 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 8E1F48F33F; Mon, 10 Oct 2005 13:36:01 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.12.11; tzolkin = 1 Chuen; haab = 9 Yax
In-Reply-To: <7vll113yjs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9924>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Removing non-current branch -- you may need to do -D instead of -d. 

Junio> $ git branch -d mybranch

<sarcasm>Undocumented secret switches.  Nice.</sarcasm>  No wonder
I couldn't find it.

>> That's also a question in general... how can I remove a commit,
>> knowing that I'd never refer to it again?  Or is disk space so cheap
>> that it wouldn't make any difference anyway?

Junio> Removing from the tip of the current branch:

Junio> $ git reset HEAD^

Junio> Removing from the tip of non-current branch:

Junio> $ git update-ref mybranch mybranch^

Do these also flush any related object files?  Or do I need git-fsck still?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
