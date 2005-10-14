From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: 14 Oct 2005 03:58:27 -0700
Message-ID: <864q7kqsa4.fsf@blue.stonehenge.com>
References: <867jciz18w.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 14 13:00:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQNGv-0000zF-8E
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 12:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVJNK6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 06:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVJNK6m
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 06:58:42 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:45487 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750714AbVJNK6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 06:58:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id BE1C58F752
	for <git@vger.kernel.org>; Fri, 14 Oct 2005 03:58:28 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28815-01-10 for <git@vger.kernel.org>;
 Fri, 14 Oct 2005 03:58:28 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 24DB78F75B; Fri, 14 Oct 2005 03:58:28 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.12.15; tzolkin = 5 Men; haab = 13 Yax
In-Reply-To: <867jciz18w.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10106>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> I updated git to d06b689a933f6d2130f8afdf1ac0ddb83eeb59ab,
Randal> then compiled and installed.

Randal> When I went to "git-pull" on my cogito archive (which I had edited
Randal> to use HTTP instead of RSYNC), I got into trouble.  Unfortunately,
Randal> I changed it to rsync to force cogito into a sane state before
Randal> I realized that this would be a good bug report. :)

Randal> This is perhaps just a heads-up that the recent git-pull might be
Randal> broken with respect to http updates.

Even after updating git this morning, git-pull still seems to be broken
with respect to http://www.kernel.org/.
Is http pulling broken for good now?  Or is someone looking at this?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
