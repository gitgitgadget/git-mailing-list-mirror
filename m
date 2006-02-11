From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: Only call git-rerere if $GIT_DIR/rr-cache exists
Date: Sat, 11 Feb 2006 13:16:42 -0800
Message-ID: <7vaccxlhol.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602111602270.26560@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Feb 11 22:16:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F826q-0003Fh-3A
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 22:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWBKVQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 16:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWBKVQo
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 16:16:44 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36602 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964797AbWBKVQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 16:16:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211211333.RTYK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 16:13:33 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602111602270.26560@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 11 Feb 2006 16:03:04 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15964>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This makes an error go away if you do not have Digest.pm installed, but
> do not intend to make use of git-rerere anyway.

Ah, I did not realize that dependency.  Thanks.
I think there is at least one more place it does it.
