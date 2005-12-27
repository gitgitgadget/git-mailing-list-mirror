From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.0.5
Date: Tue, 27 Dec 2005 00:47:14 -0800
Message-ID: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 27 09:47:27 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErAUO-0002Vr-26
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 09:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVL0IrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 03:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVL0IrS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 03:47:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58320 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932267AbVL0IrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 03:47:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051227084622.TFSL20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 03:46:22 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14070>

This is a minor bugfix release.  There is one real fix by
Johannes that would help people who manage symlinks with git.

Starting from this one I won't be touching debian/ directory,
nor supplying pre-built Debian binaries anymore.
The official maintainer seems to be reasonably quick to package
up things.  The packaging procedure used there seems to be quite
different from what I have, so I'd like to avoid potential
confusion and reduce work by the official maintainer and myself.

Also I've enhanced the post-update hook of git.git repository to
automatically prepare preformatted documentation, which I'll
cover in a separate message.
