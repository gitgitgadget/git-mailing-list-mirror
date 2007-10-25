From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 07:32:36 -0700
Message-ID: <86oden6z97.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 16:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il3lS-00055s-Vv
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 16:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760819AbXJYOci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 10:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbXJYOci
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 10:32:38 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:45158 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760767AbXJYOch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 10:32:37 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 84B451DE350; Thu, 25 Oct 2007 07:32:36 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.13.16; tzolkin = 5 Cib; haab = 4 Zac
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62321>


I have echo "ref: refs/remotes/origin/master" >.git/refs/heads/upstream
so that my daily update script can go:

   git-fetch
   if [ repo is on master, and is not dirty ];
      git-merge upstream
   fi

Yesterday that worked.

Today I get a rash of:

  fatal: Couldn't find remote ref refs/remotes/origin/master

from my git-fetch.

Is git-fetch broken, or am I?  And if it's me, how do I do what I
want instead?

And when are we gonna get "fast forward only" for git-merge?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
