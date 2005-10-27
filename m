From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Thu, 27 Oct 2005 10:51:03 -0700
Message-ID: <7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
References: <1130434230.19641.21.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 19:55:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVBuA-0001Lr-B2
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 19:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVJ0RvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVJ0RvG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 13:51:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35753 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751351AbVJ0RvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 13:51:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027175050.YLKK16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 13:50:50 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1130434230.19641.21.camel@dv> (Pavel Roskin's message of "Thu,
	27 Oct 2005 13:30:30 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10720>

Pavel Roskin <proski@gnu.org> writes:

> Or maybe the SHA1 header should never be printed at all?  It looks like
> it's not documented anywhere.  It doesn't break the tests.

AFAIK, its only user (except humans) is patch-id.

> P.S. I consider printing the SHA1 header in git-diff-tree an
> undocumented feature (in other words, a bug).
