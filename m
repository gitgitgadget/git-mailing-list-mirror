From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-cvsimport "you may need to merge manually"
Date: 16 Mar 2006 18:57:08 -0800
Message-ID: <86r75122yj.fsf@blue.stonehenge.com>
References: <86veud23v0.fsf@blue.stonehenge.com>
	<7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 03:57:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK59R-0007MI-Tt
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 03:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWCQC5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 21:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWCQC5P
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 21:57:15 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:58803 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750759AbWCQC5O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 21:57:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C8E028D66B;
	Thu, 16 Mar 2006 18:57:09 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 25316-02-7; Thu, 16 Mar 2006 18:57:09 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 36B8B8F76E; Thu, 16 Mar 2006 18:57:09 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.2.8; tzolkin = 2 Lamat; haab = 6 Cumku
In-Reply-To: <7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17653>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

>> Right... why didn't it commit those?  I'm having to issue "fake"
>> commits now, so I've lost the cvs-log comments that were formerly
>> very complete and cool.

Junio> I do not use cvsimport but I wonder what Commit ID 985ca7
Junio> contains.  Can you try "git show 985ca7" and see if that is the
Junio> commit you want?

To bring the tree clean, I issued "git commit -a -m 'cvs sync'", and
"git-whatchanged -p" shows the most recent commit with the diff actually
*backed out* the most recent change in CVS, and the next change down was
actually the good one.  Weird.  Do I need to start all over again?

Junio> Also, which branch are you on when you run git-cvsimport, and
Junio> which branch did the commit 985ca7 go?  I suspect it is storing
Junio> the tip commit 985ca7 to a branch that you are _not_ on
Junio> currently, but refraining from merging that to your current
Junio> branch, or something like that.

Nope.  I'm on "master", and it should be writing "master".

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
