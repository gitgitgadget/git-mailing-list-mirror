From: Andy Whitcroft <apw@shadowen.org>
Subject: git fetch -- double fetch
Date: Sat, 6 Oct 2007 19:57:59 +0100
Message-ID: <20071006185759.GE28610@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 20:58:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeEqx-0001Eo-02
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 20:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765031AbXJFS6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 14:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762883AbXJFS6F
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 14:58:05 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:3116 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765033AbXJFS6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 14:58:04 -0400
Received: from 85-210-7-254.dsl.pipex.com ([85.210.7.254] helo=localhost.localdomain)
	by hellhawk.shadowen.org with esmtpa (Exim 4.50)
	id 1IeEqf-0002K9-0P
	for git@vger.kernel.org; Sat, 06 Oct 2007 19:58:01 +0100
Received: from localhost ([127.0.0.1] helo=pinky)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IeEqd-0000if-BO
	for git@vger.kernel.org; Sat, 06 Oct 2007 19:57:59 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: none
X-SPF-Guess: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60154>

I have recently been seeing repeated fetching of some branches.  I feel
this has happened in at least three of my repos on three distinct
projects:

apw@pinky$ git fetch origin
remote: Generating pack...
remote: Done counting 5 objects.
remote: Deltifying 5 objects...
remote:  100% (5/5) done
Unpacking 5 objects...
remote: Total 5 (delta 0), reused 0 (delta 0)
 100% (5/5) done
* refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
  old..new: ce046f0..41c9dde
* refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
  old..new: ce046f0..41c9dde
error: Ref refs/remotes/origin/master is at 41c9dde2e63f35cd7c64b0a52c3650f246999ffd but expected ce046f04172a2a216092936302ab2cb4da64b69e
apw@pinky$

This is with a 'next' a couple of days old:

apw@pinky$ git --version
git version 1.5.3.3.1145.g46930-dirty
apw@pinky$

Will be upgrading to the latest next, will let you know if I see it again.

-apw
