From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 18:15:01 -0800
Message-ID: <7vejoonrdm.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180210490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3b54p78r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180259340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 03:15:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIbaN-0007Ic-Qd
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 03:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993092AbXBRCPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 21:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993093AbXBRCPG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 21:15:06 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38254 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993092AbXBRCPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 21:15:04 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218021503.LQCH21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 21:15:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QqF11W00C1kojtg0000000; Sat, 17 Feb 2007 21:15:02 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40055>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 17 Feb 2007, Junio C Hamano wrote:
>
>> I do agree diff-file is too confusing with diff-files, but...
>
> ... but nobody writes out diff-files these days, right?

Actually, "diff-files -c -p" while looking at a merge conflict
is the only thing I found "git diff" does not let me do.   The
latter always gives condensed combined diff.
