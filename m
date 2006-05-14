From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] commit: allow --pretty= args to be abbreviated
Date: Sun, 14 May 2006 16:47:09 -0700
Message-ID: <7vwtcoyxs2.fsf@assigned-by-dhcp.cox.net>
References: <11476199622462-git-send-email-normalperson@yhbt.net>
	<1147619963765-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:47:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfQIy-0000IX-EI
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWENXrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWENXrL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:47:11 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54678 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751410AbWENXrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 19:47:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514234709.JWYU19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 19:47:09 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <1147619963765-git-send-email-normalperson@yhbt.net> (Eric Wong's
	message of "Sun, 14 May 2006 08:19:21 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19995>

Eric Wong <normalperson@yhbt.net> writes:

>  commit.c |   42 +++++++++++++++++++++++++++++-------------
>  1 files changed, 29 insertions(+), 13 deletions(-)

This is applicable without the gitopt changes, but I have a
feeling that when we think about abbreviations the users would
expect the leading substring abbreviation, not strstr().

While "git log --pretty=lle" or "git log --pretty=or" might be
unambiguous, I think that is trying to be too cute and
confusing, especially if somebody picks up that habit by
watching others type such a cute abbreviations.

That comment probably incidentally applies to your bigger
patches.
