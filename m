From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: 14 Oct 2005 09:18:40 -0700
Message-ID: <86achcoyvz.fsf@blue.stonehenge.com>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
	<7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 18:20:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQSGm-0004I7-Ug
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 18:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVJNQSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVJNQSv
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 12:18:51 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:11124 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750779AbVJNQSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 12:18:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A829F8F750;
	Fri, 14 Oct 2005 09:18:41 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00901-01-9; Fri, 14 Oct 2005 09:18:41 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 408078F785; Fri, 14 Oct 2005 09:18:41 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.12.15; tzolkin = 5 Men; haab = 13 Yax
In-Reply-To: <7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10112>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> Even after updating git this morning, git-pull still seems to be broken
>> with respect to http://www.kernel.org/.
>> Is http pulling broken for good now?  Or is someone looking at this?

Junio> Sorry, but this is not a description of your problem helpful
Junio> enough for someone who is willing to look at it, I am afraid.
Junio> http://www.kernel.org/ has 80 or so repos (I counted about a
Junio> month ago so it may probably have more by now) --- which ones?

My previous message mentioned cogito.git breaking.  This message
was triggered because git.git itself broke.

Unfortunately, git.git hasn't been updated since the last time I
worked around the problem by switching to rsync again, but when it
does, I'll capture the breakage this time.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
