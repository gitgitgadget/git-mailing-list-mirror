From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: what is "rebase"?
Date: 19 Nov 2005 17:58:14 -0800
Message-ID: <86psow6pxl.fsf@blue.stonehenge.com>
References: <86fyps8bl1.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0511200214280.11653@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 02:58:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdeTH-0003sG-PK
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 02:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVKTB6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 20:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVKTB6U
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 20:58:20 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:59036 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751138AbVKTB6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 20:58:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 63DBE8F340;
	Sat, 19 Nov 2005 17:58:15 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20333-07-2; Sat, 19 Nov 2005 17:58:14 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id CB5018F341; Sat, 19 Nov 2005 17:58:14 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.12.14.11; tzolkin = 2 Chuen; haab = 9 Ceh
In-Reply-To: <Pine.LNX.4.63.0511200214280.11653@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12363>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> How about the definition in Documentation/glossary.txt?

>> rebase::
>> To clean a branch by starting from the head of the main line of
>> development ("master"), and reapply the (possibly cherry-picked)
>> changes from that branch.

Well, I got what I wanted... someone pointing me to a simple explanation.
However, I'm still lost.  When would I do this, and what will the
effect be?

Is this what I would use if I want to discard history except for
major milestones?  Like if I had:

        A - edit - edit - edit - B - edit - edit - edit - C

and I wanted to really just retain:

        A - B - C

Or is this just to make it look like:

        C

Still not sure what "cherry-pick" is either. And that's *not*
in the glossary. :)

I'm just worried about my archive getting bigger and bigger and
having lots of junk in it that I can't get rid of.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
