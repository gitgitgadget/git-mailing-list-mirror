From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: author/commit counts
Date: 22 Dec 2006 20:37:00 -0800
Message-ID: <86vek3p6s3.fsf@blue.stonehenge.com>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 05:37:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxydE-0008Et-10
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 05:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWLWEhF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 23:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWLWEhF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 23:37:05 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:29660 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbWLWEhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 23:37:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 5F41C9005B;
	Fri, 22 Dec 2006 20:37:01 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23743-01-4; Fri, 22 Dec 2006 20:37:00 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D49E590065; Fri, 22 Dec 2006 20:37:00 -0800 (PST)
To: Randy Dunlap <rdunlap@xenotime.net>
x-mayan-date: Long count = 12.19.13.16.9; tzolkin = 10 Muluc; haab = 2 Kankin
In-Reply-To: <20061222181030.d733deb3.rdunlap@xenotime.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35260>

>>>>> "Randy" == Randy Dunlap <rdunlap@xenotime.net> writes:

Randy> example:
Randy> git log v2.6.19.. | authorcount -m | less

Randy> # this is just the ones with >= 50 Author: lines

Randy> Al Viro : 213
Randy> Linus Torvalds : 94
Randy> Jiri Slaby : 90
Randy> Josef Sipek : 79
Randy> Gerrit Renker : 77
Randy> Adrian Bunk : 67
Randy> Andrew Morton : 59
Randy> Tejun Heo : 52
Randy> Mariusz Kozlowski : 52
Randy> Paul Mundt : 51
Randy> Ralf Baechle : 50
Randy> ---

With

  git-log --pretty=short v2.6.19.. |  git-shortlog -n -s | head -10

and no additional tools, I get:

    Al Viro: 213
    Linus Torvalds: 94
    Jiri Slaby: 90
    Josef Sipek: 79
    Gerrit Renker: 77
    Adrian Bunk: 67
    Andrew Morton: 59
    Tejun Heo: 52
    Mariusz Kozlowski: 52
    Paul Mundt: 51

Looky there.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
