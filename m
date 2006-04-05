From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: How should I handle binary file with GIT
Date: 05 Apr 2006 08:37:10 -0700
Message-ID: <86wte4rq3d.fsf@blue.stonehenge.com>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
	<7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
	<Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 17:37:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRA4L-0001Qz-Kt
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 17:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWDEPhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 11:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWDEPhN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 11:37:13 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:53669 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751067AbWDEPhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 11:37:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3A9AA8D52C;
	Wed,  5 Apr 2006 08:37:11 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 15727-01-21; Wed,  5 Apr 2006 08:37:10 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C009F8F5FD; Wed,  5 Apr 2006 08:37:10 -0700 (PDT)
To: Nicolas Pitre <nico@cam.org>
x-mayan-date: Long count = 12.19.13.3.8; tzolkin = 9 Lamat; haab = 1 Pop
In-Reply-To: <Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18439>

>>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:

>> IIRC bsdiff is used by Firefox to distribute binary software updates.
>> Xdelta is generic (not optimized for binaries like bsdiff and edelta), but
>> supposedly offers worse compression (bigger diffs).

Nicolas> We already have our own delta code for pack storage.

I think the issue is related to being able to cherry-pick and merge
when binaries are involved.  I've been worried about that myself.
How well are binaries supported these days for all the operations
we're taking for granted?  When is a "diff" expected to be a real
"diff" and not just "binary files differ"?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
