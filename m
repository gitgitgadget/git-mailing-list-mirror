From: Junio C Hamano <junkio@cox.net>
Subject: What's on git.git "master" (1/2)
Date: Thu, 01 Jun 2006 02:29:24 -0700
Message-ID: <7vk681gr63.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 01 11:29:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FljUn-0005Rn-IL
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 11:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWFAJ31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 05:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWFAJ31
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 05:29:27 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24562 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750823AbWFAJ30 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 05:29:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060601092925.UXND6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Jun 2006 05:29:25 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21111>

* The 'master' branch has these since the last announcement.

(this is only the first half of "master" -- I am bisecting)

 - Misc Fixes and Enhancements

   Dennis Stosberg:
      git-clean fails on files beginning with a dash
   Dmitry V. Levin:
      execv_git_cmd: Fix stack buffer overflow.
      git_exec_path, execv_git_cmd: ignore empty environment variables
   Paul Mackerras:
      Make git-diff-tree indicate when it flushes
   Salikh Zakirov:
      Fixed Cygwin CR-munging problem in mailsplit
   Shawn Pearce:
      Allow multiple -m options to git-commit.

 - Tests and Documentation

   Eric Wong:
      t3300-funny-names: shell portability fixes
      tests: Remove heredoc usage inside quotes
      t5500-fetch-pack: remove local (bashism) usage.
      t6000lib: workaround a possible dash bug
   Horst von Brand:
      Fix some documentation typoes
   J. Bruce Fields:
      documentation: mention gitk font adjustment in tutorial
      documentation: add brief mention of cat-file to tutorial part I
      Documentation: retitle the git-core tutorial
      Documentation: fix a tutorial-2 typo
   Shawn Pearce:
      Remove unnecessary output from t3600-rm.
      Improved pack format documentation.
