From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: rsync update appears broken now
Date: 20 Oct 2005 05:47:42 -0700
Message-ID: <86vezs9wy9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 20 14:49:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESZpw-0007Ly-D9
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 14:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVJTMr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 08:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVJTMr5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 08:47:57 -0400
Received: from [209.223.236.162] ([209.223.236.162]:12716 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932096AbVJTMr5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 08:47:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 60BC38F9C6
	for <git@vger.kernel.org>; Thu, 20 Oct 2005 05:47:43 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11147-02-24 for <git@vger.kernel.org>;
 Thu, 20 Oct 2005 05:47:42 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E91768FA39; Thu, 20 Oct 2005 05:47:42 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.13.1; tzolkin = 11 Imix; haab = 19 Yax
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10358>


Doing my daily git-pull now broke in this way (using yesterday's git version):

sent 1196 bytes  received 155984 bytes  4555.94 bytes/sec
total size is 4511741  speedup is 28.70
* committish: 6e1c6c103c522d01829f3a63992a023ff031e851
  branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
* refs/heads/origin: does not fast forward to branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git;
  not updating.
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Trying simple merge.
Simple merge failed, trying Automatic merge.
Auto-merging fetch-pack.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in fetch-pack.c.
fatal: merge program failed
Automatic merge failed; fix up by hand


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
