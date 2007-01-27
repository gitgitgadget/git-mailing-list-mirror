From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems with branches
Date: Fri, 26 Jan 2007 16:03:27 -0800
Message-ID: <7vfy9xtjxs.fsf@assigned-by-dhcp.cox.net>
References: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John Rigby" <jcrigby@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 01:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAb2h-0006wi-78
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 01:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbXA0AD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 19:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXA0AD3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 19:03:29 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61455 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbXA0AD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 19:03:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127000328.KPSE15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 19:03:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G02W1W00f1kojtg0000000; Fri, 26 Jan 2007 19:02:30 -0500
In-Reply-To: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com>
	(John Rigby's message of "Fri, 26 Jan 2007 16:51:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37906>

"John Rigby" <jcrigby@gmail.com> writes:

> + git-merge mybranch
> fatal: Needed a single revision
> Usage: /home/jrigby/bin/git-merge [-n] [--no-commit] [--squash] [-s
> <strategy>]... <merge-message> <head> <remote>+
>
> Could some kind soul help me pull my head out?

Probably you are using v1.4.4.X.

The change to make git-merge accessible as the first level UI
happened during the preparation for the upcoming v1.5.0, and is
available only in v1.5.0-rc0 and newer versions (the latest is
at v1.5.0-rc2).

If you replace "git-merge mybranch" with "git-pull . mybranch"
you should be Ok.
