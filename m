From: Junio C Hamano <junkio@cox.net>
Subject: Re: merging initial part of a branch?
Date: Wed, 11 Jan 2006 15:47:34 -0800
Message-ID: <7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
References: <20060111230451.GH8618@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 00:48:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewph9-0005UC-V6
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 00:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWAKXrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 18:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWAKXrg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 18:47:36 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10487 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750721AbWAKXrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 18:47:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111234531.XUMR26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 18:45:31 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060111230451.GH8618@fieldses.org> (J. Bruce Fields's message
	of "Wed, 11 Jan 2006 18:04:51 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14525>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> External kernel projects sometimes work only against major
> releases--it's easier for their users/testers to find a major release
> than a random git version, and at least in the early prototype stage, it
> isn't critical to be working on the tip all the time.
>
> Is there a simple way to say, for example, "merge in all the upstream
> changes up to v2.6.15"?

I haven't tried this for some time, but I presume

	$ git pull linus tag v2.6.15

would do what you want.
