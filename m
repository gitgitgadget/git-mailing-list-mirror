From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/7] Replace fork_with_pipe in bundle with run_command
Date: Mon, 12 Mar 2007 16:59:05 -0700
Message-ID: <7vodmyovxy.fsf@assigned-by-dhcp.cox.net>
References: <20070312230011.GB16840@spearce.org>
	<Pine.LNX.4.63.0703130011190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:59:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQuQ5-0000jP-LV
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbXCLX7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbXCLX7I
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:59:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62892 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbXCLX7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:59:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312235905.JJZX1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 12 Mar 2007 19:59:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zzz51W00D1kojtg0000000; Mon, 12 Mar 2007 19:59:05 -0400
In-Reply-To: <Pine.LNX.4.63.0703130011190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 13 Mar 2007 00:44:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42096>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 12 Mar 2007, Shawn O. Pearce wrote:
>
>> Now that the run_command family supports all of the redirection
>> modes needed by builtin-bundle, we can use those functions rather
>> than the underlying POSIX primitives.  This should help to make the
>> bundle command slightly more portable to other systems, like Windows.
>
> Looks fine to me (and since it passes the tests, it must be correct, 
> right?)

Funny.  Maybe the tests need to be tightened up?
