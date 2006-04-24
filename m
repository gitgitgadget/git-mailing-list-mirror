From: Junio C Hamano <junkio@cox.net>
Subject: Feeding some xmms2 gitweb enhancements back?
Date: Mon, 24 Apr 2006 02:01:15 -0700
Message-ID: <7v1wvn8i04.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@suse.de>
X-From: git-owner@vger.kernel.org Mon Apr 24 11:01:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXwwa-00084Q-9t
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 11:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDXJBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 05:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDXJBR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 05:01:17 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33707 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932098AbWDXJBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 05:01:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424090116.CPWI24392.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Apr 2006 05:01:16 -0400
To: Sham Chukoury <eleusis@xmms.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19092>

I was browsing 

	http://git.xmms.se/?p=gitweb-xmms2.git;a=shortlog

and noticed there are some nice enhancements and clean-ups that
the official gitweb distribution could probably use.  I wonder
if it is a possibility for you to feed the following to Kay for
upstream inclusion after cleaning up?

 * Navbar refactoring
 * Move CSS out of gitweb.cgi
 * Make CSS readable

   I found these quite nice, from the pain last time I tried to
   touch gitweb X-<.  I suspect it wouldn't be a straight
   cherry-pick, though...

 * Add support for code highlighting in blob view
 * Highlight more file types

   Perhaps.

 * Add category support via $GIT_DIR/category for project
 * Show project tree git url on summary page
 * Add committags support

   Perhaps.  This depends on the site organization and the
   tracking system used.

 * Snapshot links support

   Running this on kernel.org might be a bit heavyweight and
   sysadmins may not like it, but I like this.
