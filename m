From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset: allow --soft in a bare repo
Date: Fri, 13 Jul 2007 22:19:23 -0700
Message-ID: <7vir8nmujo.fsf@assigned-by-dhcp.cox.net>
References: <20070714044916.GA24911@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 07:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9a2c-0006Ph-L1
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 07:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbXGNFTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 01:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXGNFTZ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 01:19:25 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43960 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXGNFTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 01:19:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714051923.UXXU1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 01:19:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PHKP1X00Q1kojtg0000000; Sat, 14 Jul 2007 01:19:24 -0400
In-Reply-To: <20070714044916.GA24911@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Jul 2007 00:49:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52439>

Jeff King <peff@peff.net> writes:

> Previously, git-reset always required a work directory. For
> --mixed and --hard resets, this makes sense, as the bare
> repo doesn't have an index or a working tree. However, for
> --soft, there's no reason to prohibit this behavior.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Somebody asked about this on irc ("how do I rewind history in a bare
> repo"). The only other ways right now are to update the ref manually
> (which involves plumbing), or to "git-push -f" from a non-bare
> repository. I can't think of any good reason why a soft reset shouldn't
> be allowed.

How about "git branch -f this $that"???
