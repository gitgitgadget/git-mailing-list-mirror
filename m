From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] Enable ref log creation in git checkout -b.
Date: Sun, 21 May 2006 02:42:20 -0700
Message-ID: <7vk68fyarn.fsf@assigned-by-dhcp.cox.net>
References: <20060519091716.GM22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 11:43:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhkS9-0000fP-Fo
	for gcvg-git@gmane.org; Sun, 21 May 2006 11:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWEUJmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 05:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWEUJmX
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 05:42:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17355 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932352AbWEUJmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 05:42:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521094221.GKSB5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 05:42:21 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20447>

I've swallowed all 10 and pushed them out in "pu", but could you
add tests to check the Porcelainish commands you touched with
this series to make sure they all log correctly?

BTW, I noticed that a patch earlier in the series depended on
something not in "master" (it's rfc2822_date from js/fmt-patch
series).  Generally I do not want to make a branch hostage of
another branch by introducing a dependency, but for now I'll
pull in early part of js/fmt-patch branch into sp/reflog branch
and see what happens.

If sp/reflog branch graduates to the "master" first, it will
pull early parts of js/fmt-patch along with it, but the built-in
will be called "git fmt-patch" in the result, so it wouldn't
affect the use of "git format-patch".
