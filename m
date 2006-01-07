From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-files -o no recurse?
Date: Sat, 07 Jan 2006 10:45:37 -0800
Message-ID: <7vace7khbi.fsf@assigned-by-dhcp.cox.net>
References: <1136400692.5919.11.camel@localhost.localdomain>
	<Pine.LNX.4.64.0601041330550.3668@g5.osdl.org>
	<7vk6ddq8x2.fsf@assigned-by-dhcp.cox.net>
	<1136658207.6141.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 19:45:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvJ4V-00064M-BP
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 19:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWAGSpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 13:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbWAGSpo
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 13:45:44 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59307 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030539AbWAGSpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 13:45:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107184351.DLE17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 13:43:51 -0500
To: Darrin Thompson <darrint@progeny.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14269>

Darrin Thompson <darrint@progeny.com> writes:

> Here's a rejiggered version of the original Linus patch. The names have
> been changed a little.
>
> Enjoy.
>
> It prevents git from recursing into "other" directories when used with
> the -o option.

Looks same to what I have in the proposed updates branch, so we
are on the same page.  Thanks.

I have been unsure about the name "--directory", like you said.
The most accurate one I thought of so far is:

  --dont-recurse-into-directories-without-tracked-files

but it is way too long.  We cannot even say "untracked
directories" (we do not track directories) to shorten it a bit.
