From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git
Date: 21 Mar 2006 18:18:04 -0800
Message-ID: <86y7z3mdcz.fsf@blue.stonehenge.com>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 03:18:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLsvS-00051h-MV
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 03:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWCVCSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 21:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCVCSK
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 21:18:10 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:46520 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751884AbWCVCSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 21:18:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id DD5798F359;
	Tue, 21 Mar 2006 18:18:04 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 32226-02-12; Tue, 21 Mar 2006 18:18:04 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 550E88F398; Tue, 21 Mar 2006 18:18:04 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.2.13; tzolkin = 7 Ben; haab = 11 Cumku
In-Reply-To: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17796>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio>  - cvsimport post-import checkout fix.

Junio>    Earlier we had a workaround to deal with people who import
Junio>    into the current branch by not checking out.  After
Junio>    incrementally importing from the same CVS repository again,
Junio>    however, the code did update the branch head.  This made the
Junio>    working tree and the index stale and was causing more
Junio>    confusion than it avoided.

Junio>    This fix is to make re-importing act more like git-pull, not
Junio>    git-fetch.  So if you run an incremental import into the
Junio>    current branch, it tries to fast-forward the working tree and
Junio>    index (your current branch head, index and working tree had
Junio>    better be pristine with respect to the CVS repository for
Junio>    this, but that is already an requirement for a tracking
Junio>    branch anyway) when your current branch is the tracking
Junio>    branch, or merge the imported result into your current branch
Junio>    if you are using a separate tracking branch.

Junio>    I've done some testing on this myself, but am waiting for
Junio>    independent confirmations from cvsimport users.  Merlyn?

I'm waiting for that CVS tree to change again.  It changes every
4-5 days.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
