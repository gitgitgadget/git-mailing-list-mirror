From: Junio C Hamano <junkio@cox.net>
Subject: Re: removal of "percent done" messages from git pull
Date: Mon, 19 Feb 2007 15:01:04 -0800
Message-ID: <7vsld169cf.fsf@assigned-by-dhcp.cox.net>
References: <45D5E06B.6020706@lightspeed.com> <tnxr6sm5m2u.fsf@arm.com>
	<Pine.LNX.4.63.0702191611410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:01:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJHVR-0001zz-T6
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965445AbXBSXBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965439AbXBSXBI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:01:08 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39627 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408AbXBSXBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:01:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219230105.HQLL21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 18:01:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rb141W00C1kojtg0000000; Mon, 19 Feb 2007 18:01:05 -0500
In-Reply-To: <Pine.LNX.4.63.0702191611410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 19 Feb 2007 16:12:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40157>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Or (as done in StGIT for some messages), only print those interactive
>> messages when stdout is a tty, i.e. "if (isatty(1))".
>
> You mean something like this?
>
> --
> [PATCH] fetch: make things quiet when not outputting to a tty
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Please grep for 'git.fetch-pack' again.  Its output is list of
object names and the refnames where they live in the remote and
consumed by the later stages of git-fetch script.
