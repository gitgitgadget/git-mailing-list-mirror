From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] unset CDPATH in git-clone
Date: Mon, 05 Sep 2005 12:37:58 -0700
Message-ID: <7v3boj486h.fsf@assigned-by-dhcp.cox.net>
References: <20050901152441.GA8694@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 21:39:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECMn9-0001AH-VQ
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 21:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVIETiD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 15:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVIETiB
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 15:38:01 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14023 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932416AbVIETiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 15:38:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905193800.JLLI17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 15:38:00 -0400
To: Carl Baldwin <cnb@fc.hp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8113>

Carl Baldwin <cnb@fc.hp.com> writes:

> The function get_repo_base seems to break with this CDPATH.

Sorry, your message somehow slipped my filtering.  Thanks for
the analysis.  Of course, CDPATH would break it.

Is there any good reason why somebody would want to have CDPATH
in his environment, inherited to be used by any shell scripts,
as opposed to have it as a plain shell variable that is set only
in interactive shells?  I do not think of any.
