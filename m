From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: still unclear on setting up a repository
Date: 19 Nov 2005 17:14:47 -0800
Message-ID: <86y83k6ry0.fsf@blue.stonehenge.com>
References: <86br0g883v.fsf@blue.stonehenge.com> <437FCC60.3090100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 02:15:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EddnA-0007TN-AI
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 02:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVKTBOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 20:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVKTBOt
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 20:14:49 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:54437 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751008AbVKTBOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 20:14:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id F246C8F34F;
	Sat, 19 Nov 2005 17:14:47 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 18153-02-2; Sat, 19 Nov 2005 17:14:47 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 80F0C8F350; Sat, 19 Nov 2005 17:14:47 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
x-mayan-date: Long count = 12.19.12.14.11; tzolkin = 2 Chuen; haab = 9 Ceh
In-Reply-To: <437FCC60.3090100@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12360>

>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:

Andreas> Randal L. Schwartz wrote:
>> And then, another "go-boom" problem:
>> % cg-fetch
>> Hard links don't work - using copy
>> Fetching head...
>> cp: illegal option -- d


Andreas> I think this was resolved some weeks ago. Perhaps you could try the
Andreas> latest cogito from git://git.kernel.org/pub/scm/cogito/cogito.git ?

I'm grabbing nearly hourly.

    localhost:~/MIRROR/cogito-GIT % cg-status
    Heads:
       >master      22ff47e9b3c5fc8aa2efbc5ac8690b06b868ef6f
      R origin      22ff47e9b3c5fc8aa2efbc5ac8690b06b868ef6f

Error with this version.

Andreas> As for rsync; From the output you posted above, you were setting up
Andreas> both the repositories on your local machine. Using rsync for those
Andreas> cases would be pretty stupid.

rsync instead of cp if you really need "-d".

Andreas> On a side-note, could you please turn off your spamvertising
Andreas> auto-reply? It sends me some info about your perl-expertise and
Andreas> contact-numbers every now and then. It's getting a bit annoying.

If you email me directly, you'll get that note no more than once per
month.  Some day, I'll create a system to whitelist people that never
want to see it again.  Damn TUIT shortage. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
