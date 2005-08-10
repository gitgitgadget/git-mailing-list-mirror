From: Junio C Hamano <junkio@cox.net>
Subject: GIT v0.99.4
Date: Wed, 10 Aug 2005 16:02:51 -0700
Message-ID: <7v64udqtt0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 11 01:04:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2zb6-00062R-Gs
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 01:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVHJXCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 19:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVHJXCx
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 19:02:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30866 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932591AbVHJXCw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 19:02:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050810230252.SPZW19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 10 Aug 2005 19:02:52 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thanks a lot to everybody who sent in usability enhancements and
bugfixes.

Updates since v0.99.3:

- HTTP transport can pull from a packed repository.
- RPM and Debian packages are hopefully usable out of the box.
- Read-only operations on read-only repository should work better.
- Commit and tag takes the message from the command line with -m.
- Shortlog does not show things in reverse anymore.
- Many commands now natively know SHA1 expressions (e.g. HEAD^^2).
- Push can update remote refs that have different names from local.
- Comes with the latest gitk.
- A new command "git revert"
- A bulk e-mailer (not installed by default).
- Hopefully less leaky and less buggy.
