From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add commit.editor configuration variable
Date: Wed, 18 Jul 2007 23:53:59 -0700
Message-ID: <7v1wf451fc.fsf@assigned-by-dhcp.cox.net>
References: <11848235881723-git-send-email-aroben@apple.com>
	<7v7iox3oz8.fsf@assigned-by-dhcp.cox.net>
	<47EE39C7-0D57-48EC-B5A0-C10E49997E32@apple.com>
	<20070719062302.GG32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 08:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBPtn-0007hz-Mg
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 08:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbXGSGyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 02:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbXGSGyD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 02:54:03 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34621 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbXGSGyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 02:54:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070719065400.JTVO1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 02:54:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RJtz1X00G1kojtg0000000; Thu, 19 Jul 2007 02:54:00 -0400
In-Reply-To: <20070719062302.GG32566@spearce.org> (Shawn O. Pearce's message
	of "Thu, 19 Jul 2007 02:23:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52944>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We only launch an editor for three reasons: commit messages, tag
> messages and git-rebase -i.  If we were to ever add a new editor
> using thingy, odds are the user would want the same editor by
> default for that too.
>
> So please, core.editor, and also use it in git-rebase--interactive.

Ah, add "git-am -i" to the mix.  Potentially, git-notes would
use it as well.
