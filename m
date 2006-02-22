From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 22 Feb 2006 02:45:23 -0800
Message-ID: <7v8xs3pt8c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 22 11:46:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBrVY-00035v-Cd
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 11:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWBVKpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 05:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWBVKpZ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 05:45:25 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53464 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750810AbWBVKpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 05:45:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222104415.QPGR3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 05:44:15 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16596>

Tonight's installment is a fairly huge update.  I am getting a
feeling that we should declare 1.3 real soon, once what's
cooking in the 'next' branch stabilizes.

* The 'master' branch has these since the last announcement.

 - Updates to gitview by Aneesh Kumar (contrib/)

   This is not shellquote safe, so please be careful if your
   GIT_DIR has shell metacharacters in it.

 - Various fixes and cleanups from Carl Worth, Jason Riedy and me.

 - Solaris 9+ portability bits by Paul Jakma.

 - Portability bits by Johannes Schindelin.

   "make -j" breakage was fixed.  Thanks.

 - gitk "fix find" update.  I failed to pull this one for some
   time.

 - "Assume unchanged git".

 - Reusing data from existing packs.

 - Perl 5.6 backward compatibility.

   Alex Riesen volunteered to further work on porting the
   "allegedly 5.6 compatible" constructs these patches use to
   work on ActiveState (whose 5.8 does not grok them).  We'll
   see what happens.


* The 'next' branch, in addition, has these.

 - send-pack workaround for insanely large number of refs.

 - git-cvsserver by Martyn and Martin (and The Open University UK folks).

 - Delta updates by Nicolas Pitre.

   One part out of this four patch series seems to break diff
   tests so that one sits in 'pu' for now.

 - Other bits I mentioned in the previous message:

   - "Thin pack" bandwidth reduction for "git push" and "git
     fetch".

   - git-blame by Fredrik.

   - git-annotate by Ryan, with some enhancements from Johannes
     to make it usable with git-cvsserver.

* The 'pu' branch, in addition, has these.

 - git-rm by Carl Worth and Krzysiek Pawlik.

   This is not shellquote safe, so please be careful if you
   have files with shell metacharacters in their names.

 - Delta updates by Nicolas Pitre.

 - "Bound commit" lowlevel machinery for subprojects support.
