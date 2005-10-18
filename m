From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.8e
Date: Mon, 17 Oct 2005 22:53:50 -0700
Message-ID: <7v8xwrtlox.fsf@assigned-by-dhcp.cox.net>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932387AbVJRFxx@vger.kernel.org Tue Oct 18 07:55:26 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932387AbVJRFxx@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERkQY-000475-Ri
	for glk-linux-kernel-3@gmane.org; Tue, 18 Oct 2005 07:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVJRFxx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 18 Oct 2005 01:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVJRFxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 01:53:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:13460 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932387AbVJRFxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 01:53:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018055326.ZWDG776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 01:53:26 -0400
To: git@vger.kernel.org
In-Reply-To: <7vachadnmy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 15 Oct 2005 22:41:41 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10208>

GIT 0.99.8e is available as usual at:

    RPMs and tarball: www.kernel.org:/pub/software/scm/git/
    Debs and tarball: www.kernel.org:/pub/software/scm/git/debian/

The "master" branch has updated "git-diff-*" commands, that deal
with pathnames with funny characters (most importantly tabs and
newlines) in a way compatible with the proposed change to GNU
patch, which was outlined in:

    http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2

When people start generating diffs with them, patches that touch
paths that have double-quotes '"' or spaces ' ' in them need to
be applied with the updated git-apply that knows how new
"git-diff-*" encodes these funny pathnames.  GIT 0.99.8e
contains the necessary backport of the git-apply changes.

This will hopefully be the last 0.99.8 maintenance release.
