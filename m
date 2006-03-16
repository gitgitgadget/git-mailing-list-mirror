From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] blame: Rename detection (take 2)
Date: Wed, 15 Mar 2006 16:31:55 -0800
Message-ID: <7vzmjrdybo.fsf@assigned-by-dhcp.cox.net>
References: <20060310092135.24015.26510.stgit@c165>
	<20060310092141.24015.42482.stgit@c165>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 01:32:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJgPl-0004FF-5a
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 01:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWCPAb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 19:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWCPAb5
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 19:31:57 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26280 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932626AbWCPAb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 19:31:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060316003030.RZF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Mar 2006 19:30:30 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17626>

Very nice.  It even works with that "insanely fast rename
detector" by Linus ;-)

An example, from an early part of "git blame git-format-patch.sh":

0acfc972 git-format-patch-script (Junio C Hamano  2005-07-05 13:19:05 -0700 
0acfc972 git-format-patch-script (Junio C Hamano  2005-07-05 13:19:05 -0700 
0acfc972 git-format-patch-script (Junio C Hamano  2005-07-05 13:19:05 -0700 
19bb7327 git-format-patch.sh (Mike McCormack  2006-03-06 22:12:12 +0900   6)
66f04f38 git-format-patch.sh (Andreas Ericsso 2006-02-07 09:37:54 +0000   7)
66f04f38 git-format-patch.sh (Andreas Ericsso 2006-02-07 09:37:54 +0000   8)
66f04f38 git-format-patch.sh (Andreas Ericsso 2006-02-07 09:37:54 +0000   9)
66f04f38 git-format-patch.sh (Andreas Ericsso 2006-02-07 09:37:54 +0000  10)

However, I think this underlines that chopping people's names to
the first 15 bytes (or any length for that matter) does not buy
you much.
