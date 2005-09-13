From: Junio C Hamano <junkio@cox.net>
Subject: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 14:07:58 -0700
Message-ID: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 13 23:09:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFI0Z-0006V5-Lf
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVIMVIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVIMVIA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:08:00 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20915 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932353AbVIMVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 17:07:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913210759.JVNP3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 17:07:59 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8485>

I've looked at ~80 git repositories publicly available at
kernel.org and noticed only 23 are prepared to handle dumb
transports.  That probably means either most of these trees are
not pulled by people without kernel.org accounts, or public are
using rsync or cogito to pull from these trees.  I somehow find
this number very discouraging ...
