From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Date: Fri, 08 Jun 2007 03:27:30 -0700
Message-ID: <7vk5uekagd.fsf@assigned-by-dhcp.cox.net>
References: <20070608100831.GA2335@cip.informatik.uni-erlangen.de>
	<7vodjqkazp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 12:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwbgw-0000Dk-J8
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 12:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765007AbXFHK1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 06:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937676AbXFHK1c
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 06:27:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65513 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765007AbXFHK1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 06:27:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608102731.DIB25947.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 06:27:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yTW1X0061kojtg0000000; Fri, 08 Jun 2007 06:27:30 -0400
In-Reply-To: <7vodjqkazp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 08 Jun 2007 03:15:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49456>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps repository was set up in an unusual way by hand
> (i.e. not by a clone), such that:
>
>  1. you have HEAD pointing at a branch (e.g. 'refs/heads/master'),
>  2. which does _not_ exist yet (i.e. no 'refs/heads/master'),
>  3. yet you have a tag that you can try to detach your HEAD to (e.g. v2.6.20).
>
> ... well that was my initial guess, but even after setting up such a
> funny repository by hand, I cannot seem to reproduce it.

Actually, that turns out to be the reason for 'maint' releases,
although it works on 'master' (hence will be in 1.5.3 later).

How did you get your repository into such a state to begin with?
