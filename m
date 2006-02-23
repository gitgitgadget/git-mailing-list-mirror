From: ebiederm@xmission.com (Eric W. Biederman)
Subject: FYI: git-am allows creation of empty commits.
Date: Thu, 23 Feb 2006 08:33:50 -0700
Message-ID: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 23 16:35:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCIUf-0007yY-Kf
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 16:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWBWPez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 10:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWBWPez
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 10:34:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40854 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751351AbWBWPez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 10:34:55 -0500
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k1NFXpsX013112;
	Thu, 23 Feb 2006 08:33:51 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k1NFXpkw013111;
	Thu, 23 Feb 2006 08:33:51 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16651>


Currently I am using: git version 1.2.2.g709a.

I have been rebasing and refactoring a number of patchsets using git.

Frequently because of prior edits I will git a patch that does not
apply at all.  So all I get is the creation of the .dotest directory.
The automatic merge logic does not kick in, so I have to manually
call patch -p1 and resolve the differences but hand.  There everything
is expected and fine.  Although it might have been nice to have one
of those failed merge indicators in the index.

After fixing it up and doing all of my edits I occasionally forget
the git-update-index step, before calling git-am --resolved.  This
proceeds along it's merry way and creates an empty commit.

Is this the expected correct behavior or should git-am complain about
a situation like that?

Eric
