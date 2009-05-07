From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: I want "fast forward my workdir to upstream if it's safe"
Date: Thu, 07 May 2009 14:40:00 -0700
Message-ID: <86prekfv7z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 00:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Brd-0007QK-8d
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 00:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbZEGWOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbZEGWOj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 18:14:39 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:2157 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZEGWOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 18:14:38 -0400
X-Greylist: delayed 2078 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2009 18:14:38 EDT
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id AAB371DE4BD; Thu,  7 May 2009 14:40:00 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.5.16; tzolkin = 6 Cib; haab = 14 Uo
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118529>


For the past few years, within any given 12 hour period, at least
one person on #git would come up with the use case with which I'm
really familiar (having needed it many times myself):

  I have a workdir tracking a remote.
  I may or may not have made local edits... I can't remember.
  I may or may not have made local commits... I can't remember.
  But the upstream might now have changed... please update me *safely*.

Seriously, this comes up, a lot.  Typically, from a cron job updater,
but often just "what can I do to make sure I'm up to date".

So, what I need is a command, likely an option to "git merge" that says "do
everything that a git merge would do except abort if it would have been a
merge commit".  In other words, abort if the workdir is dirty or is not a
fast-forward update to the upstream.  Bonus if it exits non-zero if
something went wrong.

Please don't tell me "use these three commands in this script".
I want a *command* I can tell people in #git.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
