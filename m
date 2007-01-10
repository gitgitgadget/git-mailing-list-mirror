From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] get_tree_entry: map blank requested entry to tree root
Date: Tue, 09 Jan 2007 16:57:11 -0800
Message-ID: <7vac0rhf6g.fsf@assigned-by-dhcp.cox.net>
References: <20070109161147.GA9313@coredump.intra.peff.net>
	<7vk5zviwxa.fsf@assigned-by-dhcp.cox.net>
	<20070110004633.GA14345@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:57:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RmG-0008Fk-BO
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXAJA5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbXAJA5N
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:57:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57622 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbXAJA5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:57:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110005712.QIS3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 19:57:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9CwM1W00q1kojtg0000000; Tue, 09 Jan 2007 19:56:22 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070110004633.GA14345@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jan 2007 19:46:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36451>

Jeff King <peff@peff.net> writes:

>  - git-archive feeds the 'prefix' variable to get_tree_entry; it works
>    fine in the root with or without the patch. I seem to be getting an
>    error, with or without my patch, when doing a git-archive from a
>    subdirectory:
>      $ git-archive --format=tar origin >/dev/null
>      $ cd Documentation
>      $ git-archive --format=tar origin >/dev/null
>      fatal: cannot read c87c61af00c6d2cd7212240e260809000000aaab
>    but I haven't been able to track it down further. It's clearly
>    unrelated to my patch, though.

I've noticed this while looking at your patch and fixed it in my
tree already.
