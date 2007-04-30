From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Mon, 30 Apr 2007 16:19:04 -0700
Message-ID: <7vps5lbgd3.fsf@assigned-by-dhcp.cox.net>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
	<1177693212202-git-send-email-lcapitulino@mandriva.com.br>
	<7vabwtobpg.fsf@assigned-by-dhcp.cox.net>
	<20070427181326.14bbbf5c@localhost>
	<7vy7kbeke1.fsf@assigned-by-dhcp.cox.net>
	<20070429070616.GV5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 01:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hif9G-0001aD-49
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423404AbXD3XTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423775AbXD3XTK
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:19:10 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47685 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423404AbXD3XTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:19:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430231904.UUMD1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 19:19:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tbK41W00Y1kojtg0000000; Mon, 30 Apr 2007 19:19:05 -0400
In-Reply-To: <20070429070616.GV5942@spearce.org> (Shawn O. Pearce's message of
	"Sun, 29 Apr 2007 03:06:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45892>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> But in_merge_base is heavyweight if the two commits are in the
> same object database, but aren't connected at all.  You'll need
> to traverse both histories before aborting and saying there is
> no merge base.  That ain't cheap on large trees.  But its also a
> single line of code.

Who said anything about "a single line of code"?  That is quite
different from heaviness hidden in a control structure
lookalike.
