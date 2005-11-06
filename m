From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git tonight
Date: Sun, 06 Nov 2005 02:00:28 -0800
Message-ID: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 06 11:01:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYhKM-00022a-Ng
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 11:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVKFKAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 05:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKFKAc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 05:00:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58094 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751236AbVKFKAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 05:00:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106095942.TEKD776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 04:59:42 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11202>

Here are the things merged to "master" so far:

 - The first part of the http-push over DAV; git-push frontend
   is not aware of it yet; interested people please try it out
   with git-http-push and send thanks-it-works messages to Nick.

 - Overriding CFLAGS from make command line did not quite work
   if you were on a platform that needed to acquire platform
   specific defines from the Makefile.  Hopefully this has been
   fixed.

 - My attempt to split the Debian binary package into multiple
   ones.

 - Some documentation fixes.

 - A fix to format-patch.

In the proposed updates branch:

 - svnimport fixes from Yaacov; svnimport users please either
   Ack or report regression.

 - 'git binary directory' changes, started by Linus.  I am
   running with gitdir != bindir configuration on my machine and
   it seems to work, but I'd want wider audience to test this.
   Note that the Debian binary packages have not been adjusted
   for this change yet.

 - A 'git clone' change to fully populate remotes/origin; this
   is more or less an RFC item; likes?  dislikes?

 - A change to git-push to allow push-over-http-DAV.  I'd like
   to push this part out after I hear success stories from
   people on the first half.

I plan to do a 0.99.9e Sunday night with the tip of "master"
(wherever it will be by that time).
